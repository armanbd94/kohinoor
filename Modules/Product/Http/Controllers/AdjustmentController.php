<?php

namespace Modules\Product\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Product\Entities\Product;
use App\Http\Controllers\BaseController;
use Modules\Product\Entities\Adjustment;
use Modules\Product\Entities\AdjustmentProduct;
use Modules\Product\Http\Requests\AdjustmentFormRequest;


class AdjustmentController extends BaseController
{

    public function __construct(Adjustment $model)
    {
        $this->model = $model;
    }
    
    public function index()
    {
        if(permission('adjustment-access')){
            $this->setPageData('Manage Adjustment','Manage Adjustment','fas fa-shopping-cart',[['name' => 'Manage Adjustment']]);
            return view('product::adjustment.index');
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('adjustment-access')){

                if (!empty($request->adjustment_no)) {
                    $this->model->setAdjustmentNo($request->adjustment_no);
                }
                if (!empty($request->from_date)) {
                    $this->model->setFromDate($request->from_date);
                }
                if (!empty($request->to_date)) {
                    $this->model->setToDate($request->to_date);
                }

                $this->set_datatable_default_properties($request);//set datatable default properties
                $list = $this->model->getDatatableList();//get table data
                $data = [];
                $no = $request->input('start');
                foreach ($list as $value) {
                    $no++;
                    $action = '';
                    if(permission('adjustment-edit')){
                        $action .= ' <a class="dropdown-item" href="'.route("adjustment.edit",$value->id).'">'.self::ACTION_BUTTON['Edit'].'</a>';
                    }

                    if(permission('adjustment-view')){
                        $action .= ' <a class="dropdown-item view_data" href="'.route("adjustment.view",$value->id).'">'.self::ACTION_BUTTON['View'].'</a>';
                    }
                    
                    if(permission('adjustment-delete')){
                        $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->adjustment_no . '">'.self::ACTION_BUTTON['Delete'].'</a>';
                    }
                    
                    $row = [];
                    if(permission('adjustment-bulk-delete')){
                        $row[] = row_checkbox($value->id);//custom helper function to show the table each row checkbox
                    }
                    $row[] = $no;
                    $row[] = $value->adjustment_no;
                    $row[] = $value->item;
                    $row[] = number_format($value->total_qty,2);
                    $row[] = date(config('settings.date_format'),strtotime($value->created_at));
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
        if(permission('adjustment-add')){
            $this->setPageData('Add Adjustment','Add Adjustment','fas fa-adjust',[['name' => 'Add Adjustment']]);
            $data = [
                'adjustment_no' => 'ADJ-'.date('my').rand(1,999),
                'warehouses'    => DB::table('warehouses')->where('status',1)->pluck('name','id')
            ];
            return view('product::adjustment.create',$data);
        }else{
            return $this->access_blocked();
        }
        
    }

    public function store(AdjustmentFormRequest $request)
    {
        if($request->ajax()){
            if(permission('adjustment-add')){
                // dd($request->all());
                DB::beginTransaction();
                try {
                    $adjustment_data = [
                        'adjustment_no'    => $request->adjustment_no,
                        'item'             => $request->item,
                        'total_qty'        => $request->total_qty,
                        'note'             => $request->note,
                        'created_by'       => auth()->user()->name
                    ];
                    $adjustment  = $this->model->create($adjustment_data);
                    //purchase products
                    $products = [];
                    if($request->has('products'))
                    {
                        foreach ($request->products as $key => $value) {

                            $product = Product::find($value['id']);
                            ($value['action'] == '+') ? $product->qty += $value['qty'] : $product->qty -= $value['qty'];
                            $product->save();

                            if($product->type == 2)
                            {
                                $variant = ProductVariant::findExactProductWithCode($value['id'],$value['code'])->first();
                                if($variant){
                                    ($value['action'] == '+') ? $variant->item_qty += $value['qty'] : $variant->item_qty -= $value['qty'];
                                    $variant->save();
                                }
                            } 

                            $products[] = [
                                'adjustment_id'        => $adjustment->id,
                                'product_id'         => $value['id'],
                                'product_variant_id' => $value['variant_id'],
                                'qty'                => $value['qty'],
                                'action'           => $value['action'],
                            ];
                        }
                        if(count($products) > 0)
                        {
                            AdjustmentProduct::insert($products);
                        }

                    }
                    $output  = $this->store_message($adjustment, null);
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
        if(permission('adjustment-view')){
            $this->setPageData('Adjustment Details','Adjustment Details','fas fa-file',[['name'=>'Adjustment','link' => route('purchase')],['name' => 'Adjustment Details']]);
            $adjustment = $this->model->with('products')->find($id);
            return view('product::adjustment.details',compact('adjustment'));
        }else{
            return $this->access_blocked();
        }
    }
    public function edit(int $id)
    {

        if(permission('adjustment-edit')){
            $this->setPageData('Edit Adjustment','Edit Adjustment','fas fa-edit',[['name'=>'Adjustment','link' => route('adjustment')],['name' => 'Edit Adjustment']]);
            $data = [
                'adjustment'   => $this->model->with('products')->find($id),
            ];
            return view('product::adjustment.edit',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function update(AdjustmentFormRequest $request)
    {
        if($request->ajax()){
            if(permission('adjustment-edit')){
                // dd($request->all());
                DB::beginTransaction();
                try {
                    $adjustmentData = $this->model->with('products')->find($request->adjustment_id);

                    $adjustment_data = [
                        'item'             => $request->item,
                        'total_qty'        => $request->total_qty,
                        'note'             => $request->note,
                        'updated_by'       => auth()->user()->name
                    ];

                    if(!$adjustmentData->products->isEmpty())
                    {
                        foreach ($adjustmentData->products as  $adjustment_product) {
                            $old_qty = $adjustment_product->qty ? $adjustment_product->qty : 0;
                            $product_data = Product::find($adjustment_product->product_id);
                            if($product_data){
                                ($adjustment_product->action == '+') ? $product_data->qty -= $old_qty : $product_data->qty += $old_qty;
                                $product_data->update();
                            }
                            if(!empty($adjustment_product->product_variant_id)){
                                $product_variant = ProductVariant::find($adjustment_product->product_variant_id);
                                if($product_variant){
                                    ($adjustment_product->action == '+') ? $product_variant->item_qty -= $old_qty : $product_variant->item_qty += $old_qty;
                                    $product_variant->update();
                                }
                            }
                        }
                    }

                    $products = [];
                    if($request->has('products'))
                    {
                        foreach ($request->products as $key => $value) {

                            $product = Product::find($value['id']);
                            ($value['action'] == '+') ? $product->qty += $value['qty'] : $product->qty -= $value['qty'];
                            $product->save();

                            if($product->type == 2)
                            {
                                $variant = ProductVariant::findExactProductWithCode($value['id'],$value['code'])->first();
                                if($variant){
                                    ($value['action'] == '+') ? $variant->item_qty += $value['qty'] : $variant->item_qty -= $value['qty'];
                                    $variant->save();
                                }
                            } 

                            $products[] = [
                                'adjustment_id'      => $request->adjustment_id,
                                'product_id'         => $value['id'],
                                'product_variant_id' => $value['variant_id'],
                                'qty'                => $value['qty'],
                                'action'             => $value['action'],
                            ];
                        }
                        if(count($products) > 0)
                        {
                            AdjustmentProduct::where('adjustment_id',$adjustmentData->id)->delete();
                            AdjustmentProduct::insert($products);
                        }
                    }
                    $adjustment = $adjustmentData->update($adjustment_data);
                    $output  = $this->store_message($adjustment, $request->adjustment_id);
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

    public function delete(Request $request)
    {
        if($request->ajax()){
            if(permission('adjustment-delete')){
                DB::beginTransaction();
                try {
                    $adjustmentData = $this->model->with('products')->find($request->id);
                    if(!$adjustmentData->products->isEmpty())
                    {
                        foreach ($adjustmentData->products as  $adjustment_product) {
                            $old_qty = $adjustment_product->qty ? $adjustment_product->qty : 0;
                            $product_data = Product::find($adjustment_product->product_id);
                            if($product_data){
                                ($adjustment_product->action == '+') ? $product_data->qty -= $old_qty : $product_data->qty += $old_qty;
                                $product_data->update();
                            }
                            if(!empty($adjustment_product->product_variant_id)){
                                $product_variant = ProductVariant::find($adjustment_product->product_variant_id);
                                if($product_variant){
                                    ($adjustment_product->action == '+') ? $product_variant->item_qty -= $old_qty : $product_variant->item_qty += $old_qty;
                                    $product_variant->update();
                                }
                            }
                        }
                        $adjustmentData->products()->delete();
                    }
                    $adjustment = $adjustmentData->delete();
                    $output = $adjustment ? ['status' => 'success','message' => 'Data has been deleted successfully'] : ['status' => 'error','message' => 'failed to delete data'];
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollBack();
                    $output = ['status'=>'error','message'=>$e->getMessage()];
                }
                return response()->json($output);
            }else{
                $output = $this->access_blocked();
            }
            return response()->json($output);
        }else{
            return response()->json($this->access_blocked());
        }
    }

    public function bulk_delete(Request $request)
    {
        if($request->ajax()){
            if(permission('adjustment-bulk-delete')){
                foreach ($request->ids as $id) {
                    DB::beginTransaction();
                    try {
                        $adjustmentData = $this->model->with('products')->find($id);
                        if(!$adjustmentData->products->isEmpty())
                        {
                            foreach ($adjustmentData->products as  $adjustment_product) {
                                $old_qty = $adjustment_product->qty ? $adjustment_product->qty : 0;
                                $product_data = Product::find($adjustment_product->product_id);
                                if($product_data){
                                    ($adjustment_product->action == '+') ? $product_data->qty -= $old_qty : $product_data->qty += $old_qty;
                                    $product_data->update();
                                }
                                if(!empty($adjustment_product->product_variant_id)){
                                    $product_variant = ProductVariant::find($adjustment_product->product_variant_id);
                                    if($product_variant){
                                        ($adjustment_product->action == '+') ? $product_variant->item_qty -= $old_qty : $product_variant->item_qty += $old_qty;
                                        $product_variant->update();
                                    }
                                }
                            }
                            $adjustmentData->products()->delete();
                        }
                        $adjustment = $adjustmentData->delete();
                        $output = $adjustment ? ['status' => 'success','message' => 'Data has been deleted successfully'] : ['status' => 'error','message' => 'failed to delete data'];
                        DB::commit();
                    } catch (Exception $e) {
                        DB::rollBack();
                        $output = ['status'=>'error','message'=>$e->getMessage()];
                    }
                    return response()->json($output);
                }
            }else{
                $output = $this->access_blocked();
            }
            return response()->json($output);
        }else{
            return response()->json($this->access_blocked());
        }
    }

}
