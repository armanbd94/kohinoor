<?php

namespace Modules\Material\Http\Controllers;

use Keygen;
use App\Models\Tax;
use App\Models\Unit;
use App\Models\Category;
use App\Traits\UploadAble;
use Illuminate\Http\Request;
use Modules\Product\Entities\Product;
use Modules\Material\Entities\Material;
use App\Http\Controllers\BaseController;
use Modules\Product\Entities\ProductMaterial;
use Modules\Material\Http\Requests\MaterialFormRequest;

class MaterialController extends BaseController
{
    use UploadAble;
    public function __construct(Material $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('material-access')){
            $this->setPageData('Material','Material','fas fa-toolbox',[['name' => 'Material']]);
            $data = [
                'categories' => Category::allMaterialCategories(),
                'units'      => Unit::where('status',1)->get(),
                'taxes'      => Tax::activeTaxes(),
            ];
            return view('material::material.index',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('material-access')){

                if (!empty($request->material_name)) {
                    $this->model->setMaterialName($request->material_name);
                }
                if (!empty($request->material_code)) {
                    $this->model->setMaterialCode($request->material_code);
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
                    if(permission('material-edit')){
                        $action .= ' <a class="dropdown-item edit_data" data-id="' . $value->id . '">'.self::ACTION_BUTTON['Edit'].'</a>';
                    }
                    if(permission('material-view')){
                        $action .= ' <a class="dropdown-item view_data" data-id="' . $value->id . '" data-name="' . $value->material_name . '">'.self::ACTION_BUTTON['View'].'</a>';
                    }
                    if(permission('material-delete')){
                        $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->material_name . '">'.self::ACTION_BUTTON['Delete'].'</a>';
                    }

                    $row = [];
                    if(permission('material-bulk-delete')){
                        $row[] = row_checkbox($value->id);//custom helper function to show the table each row checkbox
                    }
                    $row[] = $no;
                    $row[] = $this->table_image(MATERIAL_IMAGE_PATH,$value->material_image,$value->material_name);
                    $row[] = $value->material_name;
                    $row[] = $value->material_code;
                    $row[] = $value->category->name;
                    $row[] = $value->purchase_price ? number_format($value->purchase_price,2,'.',',') : 0;
                    $row[] = $value->unit->unit_name;
                    $row[] = $value->qty ? $value->qty : "<span class='label label-rounded label-danger'>0</span>";
                    $row[] = $value->alert_qty ? $value->alert_qty : "<span class='label label-rounded label-danger'>0</span>";
                    $row[] = $value->tax->rate;
                    $row[] = TAX_METHOD[$value->tax_method];
                    $row[] = MATERIAL_TYPE[$value->type];
                    $row[] = permission('material-edit') ? change_status($value->id,$value->status, $value->material_name) : STATUS_LABEL[$value->status];
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

    public function store_or_update_data(MaterialFormRequest $request)
    {
        if($request->ajax()){
            if(permission('material-add')){
                $collection     = collect($request->validated())->except('material_image','purchase_price','qty','alert_qty','tax_id');
                $material_image = $request->old_material_image;
                $purchase_price = $request->purchase_price ? $request->purchase_price : 0;
                $qty            = $request->qty ? $request->qty : 0;
                $alert_qty      = $request->alert_qty ? $request->alert_qty : 0;
                if($request->hasFile('material_image')){
                    $material_image  = $this->upload_file($request->file('material_image'),MATERIAL_IMAGE_PATH);
                    if(!empty($request->old_material_image)){
                        $this->delete_file($request->old_material_image, MATERIAL_IMAGE_PATH);
                    }  
                }
                $tax_id       = ($request->tax_id != 0) ? $request->tax_id : null;
                $collection   = $collection->merge(compact('material_image','purchase_price','qty','alert_qty','tax_id'));
                $collection   = $this->track_data($collection,$request->update_id);
                $result       = $this->model->updateOrCreate(['id'=>$request->update_id],$collection->all());
                $output       = $this->store_message($result, $request->update_id);
                if(!$result)
                {
                    if($request->hasFile('material_image')){
                        $this->delete_file($material_image, MATERIAL_IMAGE_PATH);
                    }
                }
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function show(Request $request)
    {
        if($request->ajax()){
            if(permission('material-view')){
                $material = $this->model->with('category','unit','purchase_unit')->findOrFail($request->id);
                return view('material::material.view-modal-data',compact('material'))->render();
            }
        }
    }

    public function edit(Request $request)
    {
        if($request->ajax()){
            if(permission('material-edit')){
                $data   = $this->model->findOrFail($request->id);
                $output = $this->data_message($data); //if data found then it will return data otherwise return error message
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function delete(Request $request)
    {
        if($request->ajax()){
            if(permission('material-delete')){
                $material  = $this->model->find($request->id);
                $old_image = $material ? $material->material_image : '';
                $result    = $material->delete();
                if($result && $old_image != ''){
                    $this->delete_file($old_image, MATERIAL_IMAGE_PATH);
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
            if(permission('material-bulk-delete')){
                $result   = $this->model->destroy($request->ids);
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
            if(permission('material-edit')){
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

    public function generateMaterialCode(Request $request)
    {
        if ($request->ajax()) {
            // if ($request->barcode_symbology == 'C128' || $request->barcode_symbology == 'C39' 
            // || $request->barcode_symbology == 'UPCE' || $request->barcode_symbology == 'EAN8') {
            //     $code = Keygen::numeric(8)->generate();
            // }else{
                $code = Keygen::numeric(6)->generate();
            // }
            
            return response()->json($code);
        }
    }

    public function autocomplete_search_material(Request $request)
    {

        if(!empty($request->search)){
            $data = $this->model->where('material_name', 'like','%'.$request->search.'%')
                                ->orWhere('material_code', 'like','%'.$request->search.'%')
                                ->get();
            $output = array();
            if(!empty($data) && count($data) > 0)
            {
                foreach($data as $row)
                {
                    $temp_array             = array();

                    $temp_array['id']       = $row->id;
                    $temp_array['value']    = $row->material_code.' ('.$row->material_name.')';
                    $temp_array['label']    = $row->material_code.' ('.$row->material_name.')';
                    $output[]               = $temp_array;
                }
            } else{
                $output['value']            = '';
                $output['label']            = 'No Record Found';
            }

            return $output;
            
        }
    }

    public function search_material(Request $request)
    {
        $material_code = explode(" ", $request['data']);
        $material_data = $this->model->where('material_code', $material_code[0])->first();
        if($material_data)
        {
            $material['id']         = $material_data->id;
            $material['name']       = $material_data->material_name;
            $material['code']       = $material_data->material_code;
            $material['cost']       = $material_data->purchase_price;
            $material['tax_rate']   = $material_data->tax->rate ? $material_data->tax->rate : 0;
            $material['tax_name']   = $material_data->tax->name;
            $material['tax_method'] = $material_data->tax_method;

            $units = Unit::where('base_unit',$material_data->unit_id)->orWhere('id',$material_data->unit_id)->get();
            $unit_name            = [];
            $unit_operator        = [];
            $unit_operation_value = [];
            if($units)
            {
                foreach ($units as $unit) {
                    if($material_data->purchase_unit_id == $unit->id)
                    {
                        array_unshift($unit_name,$unit->unit_name);
                        array_unshift($unit_operator,$unit->operator);
                        array_unshift($unit_operation_value,$unit->operation_value);
                    }else{
                        $unit_name           [] = $unit->unit_name;
                        $unit_operator       [] = $unit->operator;
                        $unit_operation_value[] = $unit->operation_value;
                    }
                }
            }
            $material['unit_name'] = implode(',',$unit_name).',';
            $material['unit_operator'] = implode(',',$unit_operator).',';
            $material['unit_operation_value'] = implode(',',$unit_operation_value).',';
            return $material;
        }
    }

    public function product_wise_materials(Request $request)
    {
        if($request->ajax())
        {
            $product = Product::with('product_material')->find($request->product_id);
            return view('material::product-wise-list',compact('product'))->render();
        }
    }
    
}
