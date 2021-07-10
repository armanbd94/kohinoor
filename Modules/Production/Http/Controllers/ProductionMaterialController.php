<?php

namespace Modules\Production\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Modules\Production\Entities\Production;
use Illuminate\Contracts\Support\Renderable;
use Modules\Material\Entities\Material;
use Modules\Material\Entities\WarehouseMaterial;
use Modules\Production\Entities\ProductionMaterial;
use Modules\Production\Http\Requests\MaterialReturnedFormRequest;
use Modules\Production\Http\Requests\MaterialDeliveredFormRequest;

class ProductionMaterialController extends Controller
{
    public function index(Request $request)
    {
        if($request->ajax())
        {
            $production = Production::find($request->id);
            $production_materials = ProductionMaterial::with('material')->where('production_id',$request->id)->get();
            return view('production::material-list',compact('production','production_materials'))->render();
        }
    }
    public function materialDeliveryList(Request $request)
    {
        if($request->ajax())
        {
            
            $production_materials = ProductionMaterial::with('material')->where('production_id',$request->id)->get();
            return view('production::material-delivery-list',compact('production_materials'))->render();
        }
    }

    public function materialDelivered(MaterialDeliveredFormRequest $request)
    {
        if($request->ajax())
        {
            if (permission('production-material-deliver')) {
                DB::beginTransaction();
                try {
                    $production = Production::find($request->production_id);
                    $old_delivery_status = $production->material_delivered_status;
                    $old_received_status = $production->material_received_status;
                    $warehouse_id = $production->warehouse_id;
                    $result = $production->update([
                        'material_delivered_status'    => $request->material_delivered_status,
                        'material_delivered_by'       => auth()->user()->name,
                        'material_delivered_datetime' => date('Y-m-d H:i:s'),
                        ]);
                    if($result)
                    {
                        if($request->has('delivry_material')){
                            foreach($request->delivry_material as $value)
                            {
                                ProductionMaterial::find($value['id'])->update(['delivered_qty'=>$value['delivered_qty']]);
                                if($old_delivery_status == 3 && $old_received_status==3)
                                {
                                    if($value['delivered_qty'] != $value['old_delivered_qty'])
                                    {
                                        $update_material_qty = Material::find($value['material_id']);
                                        if($update_material_qty){
                                            $update_material_qty->qty = $update_material_qty->qty + $value['old_delivered_qty'];
                                            $update_material_qty->update();
                                        }
                                        
                                        $warehouse_update = WarehouseMaterial::where([
                                            'warehouse_id'=> $warehouse_id,
                                            'material_id' => $value['material_id']
                                            ])->first();
                                        if($warehouse_update){
                                            $warehouse_update->qty = $warehouse_update->qty + $value['old_delivered_qty'];
                                            $warehouse_update->update();
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                        $output = ['status' => 'success','message' => 'Data saved successfully'];
                    }else{
                        $output = ['status' => 'error','message' => 'Failed to save data'];
                    }
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollback();
                    $output = ['status' => 'error','message' => $e->getMessage()];
                }
                return response()->json($output);
                
            }
        }
    }

    public function materialReceived(Request $request)
    {
        if($request->ajax())
        {
            if (permission('production-material-receive')) {
                DB::beginTransaction();
                try {
                    $result = Production::find($request->production_id)->update([
                        'material_received_status'    => $request->material_received_status,
                        'material_received_by'       => auth()->user()->name,
                        'material_received_datetime' => date('Y-m-d H:i:s'),
                        ]);
                    if($result)
                    {
                        $production_materials = ProductionMaterial::with('production')->where('production_id',$request->production_id)->get();
                        if(!$production_materials->isEmpty()){
                            foreach($production_materials as $material)
                            {
                                ProductionMaterial::find($material->id)->update(['received_qty'=>$material->delivered_qty]);
                                $update_material_qty = Material::find($material->material_id);
                                if($update_material_qty){
                                    $update_material_qty->qty = $update_material_qty->qty - $material->delivered_qty;
                                    $update_material_qty->update();
                                }
                                
                                $warehouse_update = WarehouseMaterial::where([
                                    'warehouse_id'=>$material->production->warehouse_id,
                                    'material_id'=>$material->material_id
                                    ])->first();
                                if($warehouse_update){
                                    $warehouse_update->qty = $warehouse_update->qty - $material->delivered_qty;
                                    $warehouse_update->update();
                                }
                                
                            }
                            
                        }
                        $output = ['status' => 'success','message' => 'Data saved successfully'];
                    }else{
                        $output = ['status' => 'error','message' => 'Failed to save data'];
                    }
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollback();
                    $output = ['status' => 'error','message' => $e->getMessage()];
                }
                return response()->json($output);
                
            }
        }
    }

    public function materialReturnList(Request $request)
    {
        if($request->ajax())
        {
            $production_materials = ProductionMaterial::with('material')->where('production_id',$request->id)->get();
            return view('production::material-return-list',compact('production_materials'))->render();
        }
    }

    public function materialReturned(MaterialReturnedFormRequest $request)
    {
        if($request->ajax())
        {
            if (permission('production-material-receive')) {
                DB::beginTransaction();
                try {
                    if($request->has('return_material')){
                        foreach($request->return_material as $value)
                        {
                            $production_material =  ProductionMaterial::with('production')->find($value['id']);
                            if($production_material){
                                $material_id  = $production_material->material_id;
                                $warehouse_id = $production_material->production->warehouse_id;

                                if(!empty($value['odd_qty'])){
                                    $update_material_qty = Material::find($material_id);
                                    if($update_material_qty){
                                        $update_material_qty->qty += $value['odd_qty'];
                                        $update_material_qty->update();
                                    }
                                    
                                    $warehouse_update = WarehouseMaterial::where([
                                        'warehouse_id'=> $warehouse_id,
                                        'material_id' => $material_id
                                        ])->first();
                                    if($warehouse_update){
                                        $warehouse_update->qty +=  $value['odd_qty'];
                                        $warehouse_update->update();
                                    }
                                }
                                
                                
                            }
                        } 
                        $production = Production::find($request->production_id);
                        $production->material_returned          = 1;
                        $production->material_returned_by       = auth()->user()->name;
                        $production->material_returned_datetime = date('Y-m-d H:i:s');
                        $production->update();
                        $output = ['status' => 'success','message' => 'Data saved successfully'];
                    }else{
                        $output = ['status' => 'error','message' => 'Data Failed to Save'];
                    }
                   
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollback();
                    $output = ['status' => 'error','message' => $e->getMessage()];
                }
                return response()->json($output);
                
            }
        }
    }
}
