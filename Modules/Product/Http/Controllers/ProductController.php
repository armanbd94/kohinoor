<?php

namespace Modules\Product\Http\Controllers;

use Exception;
use Keygen\Keygen;
use App\Models\Tax;
use App\Models\Unit;
use App\Models\Category;
use App\Traits\UploadAble;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Product\Entities\Size;
use Modules\Product\Entities\Product;
use Modules\Material\Entities\Material;
use App\Http\Controllers\BaseController;
use App\Models\Warehouse;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\FinishGoods\Entities\WarehouseFinishGoods;
use Modules\Product\Http\Requests\ProductFormRequest;
use Modules\Production\Entities\ProductionFinishedGoods;

class ProductController extends BaseController
{
    use UploadAble;
    public function __construct(Product $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('product-access')){
            $this->setPageData('Product Manage','Product Manage','fab fa-product-hunt',[['name' => 'Product Manage']]);
            $data = [
                'categories' => Category::allProductCategories(),
            ];
            return view('product::index',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('product-access')){

                if (!empty($request->product_name)) {
                    $this->model->setProductName($request->product_name);
                }
                if (!empty($request->category_id)) {
                    $this->model->setCategoryID($request->category_id);
                }
                if (!empty($request->type)) {
                    $this->model->setType($request->type);
                }
                if (!empty($request->status)) {
                    $this->model->setStatus($request->status);
                }

                $this->set_datatable_default_properties($request);//set datatable default properties
                $list = $this->model->getDatatableList();//get table data
                $data = [];
                $no = $request->input('start');
                foreach ($list as $value) {
                    $no++;
                    $action = '';
                    if(permission('product-edit')){
                        $action .= ' <a class="dropdown-item" href="'.route("product.edit",$value->id).'">'.self::ACTION_BUTTON['Edit'].'</a>';
                    }
                    if(permission('product-view')){
                        $action .= ' <a class="dropdown-item" href="'.url("product/view/".$value->id).'">'.self::ACTION_BUTTON['View'].'</a>';
                    }
                    if(permission('product-delete')){
                        $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->product_name . '">'.self::ACTION_BUTTON['Delete'].'</a>';
                    }

                    $row = [];
                    if(permission('product-bulk-delete')){
                        $row[] = row_checkbox($value->id);//custom helper function to show the table each row checkbox
                    }
                    $row[] = $no;
                    $row[] = $this->table_image(PRODUCT_IMAGE_PATH,$value->product_image,$value->product_name);
                    $row[] = $value->product_name;
                    $row[] = $value->category->name;
                    $row[] = PRODUCT_TYPE[$value->type];
                    $row[] = optional($value->tax)->name;
                    $row[] = TAX_METHOD[$value->tax_method];
                    $row[] = permission('product-edit') ? change_status($value->id,$value->status, $value->product_name) : STATUS_LABEL[$value->status];
                    $row[] = action_button($action);//custom helper function for action button
                    $data[] = $row;
                }
                return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
                $this->model->count_filtered(), $data);
            }
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function create()
    {
        if(permission('product-add')){
            $this->setPageData('Add Product','Add Product','fab fa-product-hunt',[['name'=>'Product','link'=> route('product')],['name' => 'Add Product']]);
            $data = [
                'materials'  => Material::where('status',1)->get(),
                'categories' => Category::allProductCategories(),
                'units'      => Unit::all(),
                'taxes'      => Tax::activeTaxes(),
                'sizes'      => Size::with('unit')->where('status',1)->get(),
            ];
            return view('product::create',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function store_or_update_data(ProductFormRequest $request)
    {
        if($request->ajax()){
            if(permission('product-add') || permission('product-edit')){
                DB::beginTransaction();
                try {
                    $collection    = collect($request->validated())->except('product_image','materials','variants','tax_id');
                    $product_image = !empty($request->old_product_image) ? $request->old_product_image : null;
                    if($request->hasFile('product_image')){
                        $product_image  = $this->upload_file($request->file('product_image'),PRODUCT_IMAGE_PATH);
                        if(!empty($request->old_product_image)){
                            $this->delete_file($request->old_product_image, PRODUCT_IMAGE_PATH);
                        }  
                    }
                    $tax_id            = ($request->tax_id != 0) ? $request->tax_id : null;
                    $collection        = $collection->merge(compact('product_image','tax_id'));
                    $collection        = $this->track_data($collection,$request->update_id);
                    $result  = $this->model->updateOrCreate(['id'=>$request->update_id],$collection->all());
                    if(empty($result))
                    {
                        if($request->hasFile('product_image')){
                            $this->delete_file($product_image, PRODUCT_IMAGE_PATH);
                        }
                    }
                    $product = $this->model->with('product_material')->find($result->id);
                    //product materials forl product_material table relation
                    $product_materials = [];
                    if($request->has('materials')){
                        foreach($request->materials as $key => $value)
                        {
                            array_push($product_materials,$value['id']);
                        }
                    }
                    $product->product_material()->sync($product_materials);
                    //product variants for finish goods table relation data
                    if($request->has('variants')){
                        $default_warehouse = Warehouse::find(1);

                        // WarehouseFinishGoods::where(['warehouse_id'=>$default_warehouse->id,'product_id'=>$product->id])->delete();
                       
                        
                        $variants_list = [];
                        foreach($request->variants as $key => $value)
                        {
                            
                            $variants = [
                                    'product_id'        => $product->id,
                                    'size_id'           => !empty($value['size_id']) ? $value['size_id'] : null,
                                    'code'              => !empty($value['code']) ? $value['code'] : null,
                                    'unit_id'           => !empty($value['unit_id']) ? $value['unit_id'] : null,
                                    'sale_unit_id'      => !empty($value['sale_unit_id']) ? $value['sale_unit_id'] : null,
                                    'cost'              => !empty($value['cost']) ? $value['cost'] : null,
                                    'price'             => !empty($value['price']) ? $value['price'] : null,
                                    'qty'               => !empty($value['qty']) ? $value['qty'] : null,
                                    'alert_qty'         => !empty($value['alert_qty']) ? $value['alert_qty'] : null,
                                    'opening_stock_qty' => !empty($value['qty']) ? $value['qty'] : null,      
                                    'created_by'        => auth()->user()->name                                                        
                            ];
                            if(!empty($value['id'])){
                                $finish_goods = FinishGood::updateOrCreate(['id'=>$value['id']],$variants);
                            }else{
                                $finish_goods = FinishGood::create($variants);
                            }

                            WarehouseFinishGoods::updateOrCreate(
                                [
                                    'warehouse_id'=>$default_warehouse->id,
                                    'product_id'=>$product->id,
                                    'finish_goods_id'=>$finish_goods->id,
                                ],
                                [
                                'warehouse_id'=>$default_warehouse->id,
                                'product_id'=>$product->id,
                                'finish_goods_id'=>$finish_goods->id,
                                'qty' => $value['qty']
                            ]);
                            if(!empty($value['id'])){
                                array_push($variants_list,$value['id']);
                            }else{
                                if($request->update_id){
                                    array_push($variants_list,$finish_goods->id);
                                }
                                
                            }
                        }

                        if(count($variants_list) > 0)
                        {
                            $remove_list = FinishGood::where('product_id',$product->id)->whereNotIn('id',$variants_list)->get();
                            if($remove_list)
                            {
                                foreach ($remove_list as $value) {
                                    $child_data = ProductionFinishedGoods::where('finish_goods_id',$value->id)->get()->count();
                                    if($child_data == 0)
                                    {
                                        WarehouseFinishGoods::where( [
                                                'warehouse_id'=>$default_warehouse->id,
                                                'product_id'=>$product->id,
                                                'finish_goods_id'=>$value->id,
                                        ])->delete();
                                        FinishGood::find($value->id)->delete();
                                    }
                                }
                            }

                        }
                    }
                    
                    
                    // $product->product_size()->sync($variants);
                    $output  = $this->store_message($result, $request->update_id);
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollback();
                    $output = ['status' => 'error','message' => $e->getMessage()];
                }
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function show(int $id)
    {

        if(permission('product-view')){
            $this->setPageData('Product Details','Product Details','fab fa-file',[['name'=>'Product','link'=> route('product')],['name' => 'Product Details']]);
            $product = $this->model->with('product_material','category','tax','finish_goods')->findOrFail($id);
            return view('product::details',compact('product'));
        }else{
            return $this->access_blocked();
        }
        
    }

    public function edit(int $id)
    {
        if(permission('product-edit')){
            $this->setPageData('Edit Product','Edit Product','fab fa-pencil',[['name'=>'Product','link'=> route('product')],['name' => 'Edit Product']]);
            $data = [
                'product'    => $this->model->with('product_material','product_size')->findOrFail($id),
                'materials'  => Material::where('status',1)->get(),
                'categories' => Category::allProductCategories(),
                'units'      => Unit::all(),
                'taxes'      => Tax::activeTaxes(),
                'sizes'      => Size::with('unit')->where('status',1)->get(),
            ];
            // dd($data['product']->product_size[0]);
            return view('product::create',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function delete(Request $request)
    {
        if($request->ajax()){
            if(permission('product-delete')){
                $product  = $this->model->find($request->id);
                $old_image = $product ? $product->product_image : '';
                $result    = $product->delete();
                if($result && $old_image != ''){
                    $this->delete_file($old_image, PRODUCT_IMAGE_PATH);
                }
                $output   = $this->delete_message($result);
            }else{
                $output   = $this->unauthorized();

            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function bulk_delete(Request $request)
    {
        if($request->ajax()){
            if(permission('product-bulk-delete')){
                // $result   = $this->model->destroy($request->ids);
                // $output   = $this->bulk_delete_message($result);
                $products = $this->model->toBase()->select('product_image')->whereIn('id',$request->ids)->get();
                $result = $this->model->destroy($request->ids);
                if($result){
                    if(!empty($products)){
                        foreach ($products as $product) {                   
                            if($product->product_image != null)
                            {
                                $this->delete_file($product->product_image,PRODUCT_IMAGE_PATH);    
                            }
                        }
                    }
                }
                $output   = $this->bulk_delete_message($result);
            }else{
                $output   = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function change_status(Request $request)
    {
        if($request->ajax()){
            if(permission('product-edit')){
                $result   = $this->model->find($request->id)->update(['status' => $request->status]);
                $output   = $result ? ['status' => 'success','message' => 'Status Has Been Changed Successfully']
                : ['status' => 'error','message' => 'Failed To Change Status'];
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    // public function generateProductCode(Request $request)
    // {
    //     if ($request->ajax()) {
    //         if ($request->barcode_symbology == 'C128' || $request->barcode_symbology == 'C39' 
    //         || $request->barcode_symbology == 'UPCE' || $request->barcode_symbology == 'EAN8') {
    //             $code = Keygen::numeric(8)->generate();
    //         }else{
    //             $code = Keygen::numeric(13)->generate();
    //         }
            
    //         return response()->json($code);
    //     }
        
    // }


    
}
