<?php

namespace Modules\Production\Http\Controllers;

use Exception;
use Keygen\Keygen;
use App\Models\Warehouse;
use Illuminate\Http\Request;
use PhpParser\Node\Stmt\TryCatch;
use Illuminate\Support\Facades\DB;
use Modules\Product\Entities\Product;
use Modules\Material\Entities\Material;
use App\Http\Controllers\BaseController;
use Modules\Production\Entities\Production;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\FinishGoods\Entities\WarehouseFinishGoods;
use Modules\Material\Entities\WarehouseMaterial;
use Modules\Production\Entities\ProductionCoupon;
use Modules\Production\Entities\FinishedGoodsMaterial;
use Modules\Production\Http\Requests\QRCodeFormRequest;
use Modules\Production\Entities\ProductionFinishedGoods;
use Modules\Production\Http\Requests\ProductionFormRequest;

class ProductionController extends BaseController
{
    private const BATCH_NO = 1001;
    public function __construct(Production $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('production-access')){
            $this->setPageData('Production Manage','Production Manage','fas fa-industry',[['name' => 'Production Manage']]);
            $products = Product::all();
            return view('production::index',compact('products'));
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('production-access')){

                if (!empty($request->batch_no)) {
                    $this->model->setBatchNo($request->batch_no);
                }
                if (!empty($request->start_date)) {
                    $this->model->setStartDate($request->start_date);
                }
                if (!empty($request->end_date)) {
                    $this->model->setEndDate($request->end_date);
                }
                if (!empty($request->product_id)) {
                    $this->model->setProductID($request->product_id);
                }
                if (!empty($request->production_status)) {
                    $this->model->setProductionStatus($request->production_status);
                }
                if (!empty($request->material_delivered_status)) {
                    $this->model->setMaterialDeliveredStatus($request->material_delivered_status);
                }
                if (!empty($request->material_received_status)) {
                    $this->model->setMarialReceivedStatus($request->material_received_status);
                }

                $this->set_datatable_default_properties($request);//set datatable default properties
                $list = $this->model->getDatatableList();//get table data
                $data = [];
                $no = $request->input('start');
                foreach ($list as $value) {
                    $no++;
                    $action = '';
                    if(permission('production-edit')){
                        if($value->production_status != 4){
                            $action .= ' <a class="dropdown-item" href="'.route("production.edit",$value->id).'">'.self::ACTION_BUTTON['Edit'].'</a>';
                        }
                    }
                    if(permission('production-view')){
                        $action .= ' <a class="dropdown-item view_data" href="'.route("production.view",$value->id).'">'.self::ACTION_BUTTON['View'].'</a>';
                    }
                    if(permission('production-delete')){
                        $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->batch_no . '">'.self::ACTION_BUTTON['Delete'].'</a>';
                    }
                    $row = [];
                    $row[] = $no;
                    $row[] = $value->batch_no;
                    $row[] = $value->product->product_name;
                    $row[] = date(config('settings.date_format'),strtotime($value->start_date));
                    $row[] = date(config('settings.date_format'),strtotime($value->end_date));
                    $row[] = PRODUCTION_STATUS_LABEL[$value->production_status];
                    $row[] = PRODUCTION_MATERIAL_DELIVERY_LABEL[$value->material_delivered_status];
                    $row[] = PRODUCTION_MATERIAL_RECEIVE_LABEL[$value->material_received_status];
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
        if(permission('production-add')){
            $this->setPageData('Add Production','Add Production','fas fa-industry',[['name'=>'Production','link'=> route('production')],['name' => 'Add Production']]);
            $production = $this->model->select('batch_no')->orderBy('batch_no','desc')->first();
            $data = [
                // 'materials'  => Material::with('unit')->where('status',1)->get(),
                'products'   => Product::where('status',1)->get(),
                'warehouses' => Warehouse::activeWarehouses(),
                'batch_no'   => $production ? $production->batch_no + 1 : self::BATCH_NO
            ];
            return view('production::create',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function store_or_update_data(ProductionFormRequest $request)
    {
        if($request->ajax()){
            if(permission('production-add') || permission('production-edit')){
                DB::beginTransaction();
                try {
                    $collection = collect($request->validated())->except('materials','variants');
                    $collection = $this->track_data($collection,$request->update_id);
                    $result     = $this->model->updateOrCreate(['id'=>$request->update_id],$collection->all());
                    $production = $this->model->with('production_materials')->find($result->id);

                    //product materials forl product_material table relation
                    $production_materials = [];
                    if($request->has('materials')){
                        foreach($request->materials as $value)
                        {
                            $production_materials[$value['id']] = [
                                'batch_no'     => $result->batch_no,
                                'required_qty' => !empty($value['qty']) ? $value['qty'] : null,
                            ];
                        }
                        $production->production_materials()->sync($production_materials);
                    }
                    

                    //product variants for finish goods table relation data
                    $variants_list = [];
                    if($request->has('variants')){
                        foreach($request->variants as $value)
                        {
                            $old_data = '';
                            if(!empty($value['id'])){
                                $old_data = ProductionFinishedGoods::find($value['id']);

                                if($value['id']){
                                    array_push($variants_list,$value['id']);
                                }
                            }
                            $variants = [
                                'production_id'   => $production->id,
                                'batch_no'        => $production->batch_no,
                                'finish_goods_id' => $value['finish_goods_id'],
                                'total_coupon'    => $value['total_coupon'] ? $value['total_coupon'] : null,
                                'coupon_price'    => $value['coupon_price'] ? $value['coupon_price'] : null,
                                'coupon_exp_date' => $value['coupon_expiration_date'] ? $value['coupon_expiration_date'] :null,
                                'created_by'      => auth()->user()->name
                            ];
                            
                            $production_finished_good = ProductionFinishedGoods::updateOrCreate([
                                'production_id'   => $production->id,
                                'batch_no'        => $production->batch_no,
                                'finish_goods_id' => $value['finish_goods_id']],$variants);
                                
                            if ($production_finished_good && empty($value['id'])) {
                                if(!empty($value['total_coupon']) && !empty($value['coupon_price']))
                                {
                                    ProductionCoupon::insert($this->generateCouponCode($production->id,$production_finished_good->id,$production->batch_no,$value['total_coupon']));
                                }
                            }else{
                                if($old_data)
                                {
                                    $new_coupon_qty = abs($old_data->total_coupon -  ($value['total_coupon'] ?  $value['total_coupon'] : 0));
                                    ProductionCoupon::insert($this->generateCouponCode($production->id,$production_finished_good->id,$production->batch_no,$new_coupon_qty));
                                }
                            }

                            if($request->has('materials')){
                                foreach($request->materials as $material)
                                {
                                    FinishedGoodsMaterial::updateOrCreate([
                                        'production_id'               => $production->id,
                                        'production_finished_good_id' => $production_finished_good->id,
                                        'material_id'                 => $material['id']
                                    ],[
                                        'production_id'               => $production->id,
                                        'production_finished_good_id' => $production_finished_good->id,
                                        'material_id'                 => $material['id'],
                                        'created_by'                  => empty($request->update_id) ? auth()->user()->name : null,
                                        'modified_by'                 => empty($request->update_id) ? null : auth()->user()->name,
                                        'created_at'                  => empty($request->update_id) ? date('Y-m-d H:i:s') : null,
                                        'updated_at'                  => empty($request->update_id) ? null : date('Y-m-d H:i:s'),
                                    ]);
                                }
                            }
                            
                        }
                       
                        if(count($variants_list) > 0)
                        {
                            $remove_list = ProductionFinishedGoods::where(['production_id'   => $production->id,
                            'batch_no'        => $production->batch_no])->whereNotIn('id',$variants_list)->get();
                            if($remove_list)
                            {
                                foreach ($remove_list as $value) {
                                    $coupons_deleted = ProductionCoupon::where(['production_id'=> $production->id, 'batch_no' => $production->batch_no,'finish_goods_id'=>$value->id])->delete();
                                    $materials_deleted = FinishedGoodsMaterial::where(['production_id'=> $production->id,'finish_goods_id'=>$value->id])->delete();
                                    if($coupons_deleted && $materials_deleted)
                                    {
                                        ProductionFinishedGoods::find($value->id)->delete();
                                    }
                                }
                            }

                        }
                        
                    }

                    $output  = $this->store_message($result, $request->update_id);
                    $output['production_id'] = $production->id;
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
        if(permission('production-view')){
            $this->setPageData('Production Details','Production Details','fas fa-file',[['name'=>'Production','link'=> route('production')],['name' => 'Production Details']]);
            $production = $this->model->with('product','warehouse','production_materials','production_finished_goods')->findOrFail($id);

            // dd($production->production_finished_goods[0]);
            return view('production::details',compact('production'));
        }else{
            return $this->access_blocked();
        }
    }

    
    public function edit(int $id)
    {
        if(permission('production-edit')){
            $this->setPageData('Edit Production','Edit Production','fas fa-edit',[['name'=>'Production','link'=> route('production')],['name' => 'Edit Production']]);
            $data = [
                'production' => $this->model->with('product','warehouse','production_materials','production_finished_goods')->findOrFail($id),
                'materials'  => Material::where('status',1)->get(),
                'products'   => Product::where('status',1)->get(),
                'warehouses' => Warehouse::activeWarehouses(),
            ];
            // dd($data['production']->production_finished_goods);
            return view('production::edit',$data);
        }else{
            return $this->access_blocked();
        }
    }

    //Ajax Render Product Variant List In Production Add Page
    public function product_variants(Request $request)
    {
        if($request->ajax())
        {
            $finished_goods = FinishGood::with('product','size')->where(['product_id'=>$request->product_id,'status'=>1])->get();
            return view('production::product-variants',compact('finished_goods'))->render();
        }
    }

    public function generateCouponCode(int $production_id,int $production_finished_good_id,int $batch_no,int $total_coupon)
    {
        $chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        $coupon_code = [];
        for ($coupon = 1; $coupon <= $total_coupon; $coupon++) {
            $code  = "";
            for ($i = 0; $i < 10; $i++) {
                $code .= $chars[mt_rand(0, strlen($chars)-1)];
            }

            $code_exist = ProductionCoupon::where('coupon_code',$code)->first();
            if($code_exist)
            {
                $this->generateCouponCode($production_id,$production_finished_good_id,$batch_no,$total_coupon);
            }else{
                $coupon_code[] = [
                    'production_id'               => $production_id,
                    'production_finished_good_id' => $production_finished_good_id,
                    'batch_no'                    => $batch_no,
                    'coupon_code'                 => $code,
                    'created_at'                  => date('Y-m-d H:i:s')
                ];
            }
        }
        return $coupon_code;
    }

    public function generateQRCode(QRCodeFormRequest $request)
    {
        if($request->ajax())
        {
            $coupons = ProductionCoupon::with('production_finished_good')->where([
                'production_id' => $request->production_id,
            'production_finished_good_id' => $request->production_finished_good_id,
            'batch_no'                    => $request->batch_no
            ])->get();
            $data = [
                'coupons'     => $coupons,
                'row_qty'     => $request->row_qty,
            ];
            return view('production::print-qrcode',$data)->render();
        }
    }

    public function delete(Request $request)
    {
        if($request->ajax())
        {
            if(permission('production-delete')){
                DB::beginTransaction();
                try {
                    
                    $production = $this->model->with('production_materials','production_finished_goods')->find($request->id);
                    if($production){
                        //Remove Materials used in Finished Goods
                        FinishedGoodsMaterial::where('production_id',$production->id)->delete();
                        //Remove Production Coupon
                        ProductionCoupon::where('production_id',$production->id)->delete();
                        if(!$production->production_materials->isEmpty())
                        {
                            //If material received for production then returned the received qty to stock
                            if($production->material_received_status != 1){
                                foreach ($production->production_materials as $value) {

                                    //Material total qty update
                                    $update_material_qty = Material::find($value->pivot->material_id);
                                    if($update_material_qty){
                                        $update_material_qty->qty += $value->pivot->received_qty;
                                        $update_material_qty->update();
                                    }
                                    
                                    //Material warehouse stock qty update
                                    $warehouse_update = WarehouseMaterial::where([
                                        'warehouse_id'=> $production->warehouse_id,
                                        'material_id' => $value->pivot->material_id
                                        ])->first();
                                    if($warehouse_update){
                                        $warehouse_update->qty += $value->pivot->received_qty;
                                        $warehouse_update->update();
                                    }
                                }
                            }
                            $production->production_materials()->detach(); //Remove all materials used in production
                            
                        }
                        if(!$production->production_finished_goods->isEmpty())
                        {
                            foreach ($production->production_finished_goods as $value) {

                                //Finished Goods total qty update
                                $update_finish_good_qty = FinishGood::find($value->pivot->finish_goods_id);
                                if($update_finish_good_qty){
                                    $update_finish_good_qty->qty -= $value->pivot->qty;
                                    $update_finish_good_qty->update();
                                }
                                
                                //Finished Goods warehouse stock qty update
                                $warehouse_finished_goods_update = WarehouseFinishGoods::where([
                                    'warehouse_id'=> $production->warehouse_id,
                                    'product_id'=> $production->product_id,
                                    'finish_goods_id' => $value->pivot->finish_goods_id
                                    ])->first();
                                if($warehouse_finished_goods_update){
                                    $warehouse_finished_goods_update->qty -= $value->pivot->qty;
                                    $warehouse_finished_goods_update->update();
                                }
                            }
                            $production->production_finished_goods()->detach(); //Remove all production finished goods
                        }
                        $result = $production->delete();
                        $output = $result ? ['status'=>'success','message'=>'Data deleted successfully'] : ['status'=>'error','message'=>'Failed to delete data']; 
                    }else{
                        $output = ['status'=>'error','message'=>'Failed to delete data'];
                    }
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollBack();
                    $output = ['status'=>'error','message'=>$e->getMessage()];
                }
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }
    }

    public function change_status(Request $request)
    {

        if(permission('production-edit')){
            $result = Production::find($request->production_id)->update([
                'production_status'=>$request->production_status,
                'end_date' => $request->production_status == 4 ? date('Y-m-d') : null
                ]);
            if($result)
            {
                session()->flash('success','Status Has Been Changed Successfully');
            }else{
                session()->flash('error','Failed To Change Status');
            }
        }else{
            session()->flash('error','Unauthorized Access Blocked!');
        }
        return redirect()->back();
        
    }

   

    // public function qrcode()
    // {
    //     if(permission('print-qrcode-access')){
    //         $this->setPageData('Print QR Code','Print QR Code','fas fa-qrcode',[['name' => 'Print QR Code']]);
    //         return view('production::qrcode');
    //     }else{
    //         return $this->access_blocked();
    //     }
    // }

    // public function check_valid_code(Request $request)
    // {
        
    //     // $text = 'Batch:1001;Code:AVD56E;ExpDate:10-Dec-2021';
    //     $text = $request->get('text');
    //     if($text){
    //         $data = [
    //             'batch_no' => explode(':',explode(';',$text)[0])[1],
    //             'code' => explode(':',explode(';',$text)[1])[1],
    //             'exp_date' => date('Y-m-d',strtotime(explode(':',explode(';',$text)[2])[1])),
    //             'amount' => number_format(20,2)
    //         ];
    //     }else{
    //         $data = [];
    //     }
        
    //     return response()->json(['statuc'=>'success','message'=>'Valid','data'=>$data]);
    // }
}
