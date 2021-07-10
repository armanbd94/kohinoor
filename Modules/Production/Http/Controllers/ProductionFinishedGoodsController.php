<?php

namespace Modules\Production\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\BaseController;
use Modules\Production\Entities\Production;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\Production\Entities\ProductionMaterial;
use Modules\FinishGoods\Entities\WarehouseFinishGoods;
use Modules\Production\Entities\FinishedGoodsMaterial;
use Modules\Production\Entities\ProductionFinishedGoods;
use Modules\Production\Http\Requests\ProductionFinishedGoodsUpdateRequest;

class ProductionFinishedGoodsController extends BaseController
{
    public function __construct(ProductionFinishedGoods $model)
    {
        parent::__construct($model);
    }

    public function updateFinishedGoods(Request $request)
    {
        if($request->ajax())
        {   if(permission('production-packaging')){
                DB::beginTransaction();
                try {
                    // dd($request->data['finish_goods_id']);
                    $old_finished_goods_qty = ($request->data['type'] == 1) ? $request->data['old_packaging_master_pipi_qty'] : $request->data['old_packaging_carton_qty'];
                    $new_finished_goods_qty = ($request->data['type'] == 1) ? $request->data['packaging_master_pipi_qty'] : $request->data['packaging_carton_qty'];
                    
                    $collection             = collect($request->data)->except(['id','finish_goods_id','type']);
                    $collection             = $this->track_data($request->data['id'],$collection);
                    $result                 = $this->model->updateOrCreate(['id'=>$request->data['id']],$collection->all());
                    if($result){
                        if($old_finished_goods_qty != $new_finished_goods_qty){
                            // dd($old_finished_goods_qty);
                           $finish_goods =  FinishGood::where('id',$request->data['finish_goods_id'])->first();
                           $finish_goods->qty = (($finish_goods->qty ? $finish_goods->qty : 0) - ($old_finished_goods_qty ? $old_finished_goods_qty : 0)) + ($new_finished_goods_qty ? $new_finished_goods_qty : 0);
                           $finish_goods->update();
                        }
                    }
                    $output = $this->store_message($result, $request->data['id']);
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollback();
                    $output = ['status' => 'error','message' => $e->getMessage()];
                }
                
                return response()->json($output);
            }else{
                return response()->json($this->unauthorized());
            }
        }
    }


    public function production_finished_goods_list(Request $request)
    {
        if ($request->ajax()) {
            $production = Production::with('product','production_finished_goods')->find($request->id);
            return view('production::finished-goods',compact('production'))->render();
        }
    }
    public function production_finished_goods_material_list(Request $request)
    {
        if ($request->ajax()) {
            $data = ProductionFinishedGoods::with('production','finished_goods','finished_goods_materials')->find($request->id);
            return view('production::production-finished-goods-materials-list',compact('data'))->render();
        }
    }

    public function production_finished_goods_material_update(ProductionFinishedGoodsUpdateRequest $request)
    {
        if ($request->ajax()) {
            DB::beginTransaction();
            try {
                
                $direct_cost = [];
                if($request->has('materials'))
                {
                    foreach ($request->materials as $key => $value) {
                        $finish_goods_material = FinishedGoodsMaterial::find($value['id']);
                        $production_material = ProductionMaterial::where([
                            'production_id'=>$finish_goods_material->production_id,
                            'material_id'=>$finish_goods_material->material_id,
                            ])->first();
                        $diff_used_qty    = ($finish_goods_material->used_qty ? $finish_goods_material->used_qty : 0) - ($value['used_qty'] ? $value['used_qty'] : 0);
                        $diff_damaged_qty = ($finish_goods_material->damaged_qty ? $finish_goods_material->damaged_qty : 0) - ($value['damaged_qty'] ? $value['damaged_qty'] : 0);
                        $diff_odd_qty     = ($finish_goods_material->odd_qty ? $finish_goods_material->odd_qty : 0) - ($value['odd_qty'] ? $value['odd_qty'] : 0);
                        
                        if(empty($finish_goods_material->used_qty))
                        {
                            $production_material->used_qty    += $value['used_qty'] ? $value['used_qty'] : 0;
                        }else{
                            $production_material->used_qty    -= $diff_used_qty;
                        }
                        if(empty($finish_goods_material->damaged_qty))
                        {
                            $production_material->damaged_qty    += $value['damaged_qty'] ? $value['damaged_qty'] : 0;
                        }else{
                            $production_material->damaged_qty    -= $diff_damaged_qty;
                        }


                        $finish_goods_material->update([
                            'total_qty'   => $value['total_qty'] ? $value['total_qty'] : null,
                            'used_qty'    => $value['used_qty'] ? $value['used_qty'] : null,
                            'damaged_qty' => $value['damaged_qty'] ? $value['damaged_qty'] : null,
                            'odd_qty'     => $value['odd_qty'] ? $value['odd_qty'] : null,
                            'direct_cost' => $value['direct_cost'] ? $value['direct_cost'] : null,
                            'modified_by' => auth()->user()->name
                        ]);
                        
                        
                        $production_material->update();
                        array_push($direct_cost,($value['direct_cost'] ? $value['direct_cost'] : 0));
                    }
                }
                $production_finished_goods = ProductionFinishedGoods::find($request->production_finished_good_id);
                $finish_goods = FinishGood::find($production_finished_goods->finish_goods_id);
                $warehouse_finished_goods = WarehouseFinishGoods::where(['warehouse_id'=>1,'product_id'=>$finish_goods->product_id,'finish_goods_id'=>$finish_goods->id])->first();
                $diff_qty = ($production_finished_goods->qty ? $production_finished_goods->qty : 0) - $request->production_qty;
                if(empty($production_finished_goods->qty))
                {
                    $finish_goods->qty += $request->production_qty;
                    $warehouse_finished_goods->qty += $request->production_qty;
                }else{
                    $finish_goods->qty -= $diff_qty;
                    $warehouse_finished_goods->qty -= $diff_qty;
                }
                $cost = (count($direct_cost) > 0) ? array_sum($direct_cost) : null;
                // dd($cost);
                $production_finished_goods->update([
                    'qty'=>$request->production_qty,
                    'direct_cost' => $cost,
                    'modified_by' => auth()->user()->name,
                    ]);
                if($cost){
                    $finish_goods->cost = $cost / $request->production_qty;
                }
                $finish_goods->update();
                $warehouse_finished_goods->update();
                $output = ['status' => 'success','message'=>'Data saved successfully'];
                DB::commit();
            } catch (Exception $e) {
                DB::rollBack();
                $output = ['status' => 'error','message'=> $e->getMessage()];
            }
            return response()->json($output);
        }
    }

}
