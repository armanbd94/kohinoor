<?php

namespace Modules\FinishGoods\Http\Controllers;

use Illuminate\Http\Request;
use Modules\Product\Entities\Size;
use Modules\Product\Entities\Product;
use App\Http\Controllers\BaseController;
use App\Models\Unit;
use Exception;
use Illuminate\Support\Facades\DB;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\FinishGoods\Entities\WarehouseFinishGoods;
use Modules\FinishGoods\Http\Requests\FinishedGoodsFormRequest;

class FinishGoodsController extends BaseController
{
    public function __construct(FinishGood $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('inventory-access')){
            $this->setPageData('Finished Goods','Finished Goods','fas fa-boxes',[['name' => 'Finished Goods']]);
            $data = [
                'products' => Product::all(),
                'sizes'    => Size::with('unit')->get(),
                'units'    => Unit::all(),
            ];
            return view('finishgoods::index',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('inventory-access')){

                if (!empty($request->product_id)) {
                    $this->model->setProductID($request->product_id);
                }
                if (!empty($request->code)) {
                    $this->model->setCode($request->code);
                }
                if (!empty($request->size_id)) {
                    $this->model->setSizeID($request->size_id);
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
                    if(permission('inventory-edit')){
                        $action .= ' <a class="dropdown-item edit_data" data-id="' . $value->id . '">'.self::ACTION_BUTTON['Edit'].'</a>';
                    }
                    // if(permission('inventory-view')){
                    //     $action .= ' <a class="dropdown-item view_data" data-id="' . $value->id . '" data-name="' . $value->product->product_name.' '.$value->size->size.$value->size->unit. '">'.self::ACTION_BUTTON['View'].'</a>';
                    // }
                    if(permission('inventory-delete')){
                        $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->product->product_name.' '.$value->size->size.$value->size->unit. '">'.self::ACTION_BUTTON['Delete'].'</a>';
                    }

                    $row = [];
                    if(permission('inventory-bulk-delete')){
                        $row[] = row_checkbox($value->id);//custom helper function to show the table each row checkbox
                    }
                    $row[] = $no;
                    $row[] = $value->product->product_name;
                    $row[] = $value->size->size.' '.$value->size->unit->unit_name;
                    $row[] = $value->code;
                    $row[] = PRODUCT_TYPE[$value->product->type];
                    $row[] = number_format($value->cost,2);
                    $row[] = number_format($value->price,2);
                    $row[] = $value->unit->unit_name;
                    $row[] = $value->sale_unit->unit_name;
                    $row[] = number_format($value->qty,2);
                    $row[] = number_format($value->alert_qty,2);
                    $row[] = permission('inventory-edit') ? change_status($value->id,$value->status, $value->product->product_name.' '.$value->size->size.$value->size->unit) : STATUS_LABEL[$value->status];
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


    public function store_or_update_data(FinishedGoodsFormRequest $request)
    {
        if($request->ajax()){
            if(permission('inventory-add') || permission('inventory-edit')){
                $collection   = collect($request->validated())->except('cost');
                $cost = !empty($request->cost) ? $request->cost : null;
                $collection = $collection->merge(compact('cost'));
                $collection   = $this->track_data($collection,$request->update_id);
                $result       = $this->model->updateOrCreate(['id'=>$request->update_id],$collection->all());
                $output       = $this->store_message($result, $request->update_id);
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
            if(permission('inventory-view')){
                $material = $this->model->with('category')->findOrFail($request->id);
                return view('finishgoods::view',compact('material'))->render();
            }
        }
    }

    public function edit(Request $request)
    {
        if($request->ajax()){
            if(permission('inventory-edit')){
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
            if(permission('inventory-delete')){
                $finish_good  = $this->model->find($request->id);
                $warehouseFinishGoods = WarehouseFinishGoods::where(['product_id'=>$finish_good->product_id,'finish_goods_id'=>$finish_good->id])->delete();
                if($warehouseFinishGoods)
                {
                    if($finish_good->delete())
                    {
                        $output = ['status'=>'success','message'=>'Data deleted successfully'];
                    }else{
                        $output = ['status'=>'error','message'=>'Failed to delete data'];
                    }
                }else{
                    $output = ['status'=>'error','message'=>'Failed to delete data'];
                }
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
            if(permission('inventory-bulk-delete')){
                DB::beginTransaction();
                try {
                    WarehouseFinishGoods::whereIn('finish_goods_id',$request->ids)->delete();
                    $result = $this->model->destroy($request->ids);
                    $output   = $this->bulk_delete_message($result);
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollBack();
                    $output = ['status'=>'error','message'=> $e->getMessage()];
                }
                
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
            if(permission('inventory-edit')){
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

}
