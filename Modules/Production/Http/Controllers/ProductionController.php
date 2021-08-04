<?php

namespace Modules\Production\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Product\Entities\Product;
use Modules\Setting\Entities\Warehouse;
use App\Http\Controllers\BaseController;
use Modules\Production\Entities\Production;
use Modules\Production\Entities\ProductionCoupon;
use Modules\Production\Entities\ProductionProduct;

class ProductionController extends BaseController
{
    public function __construct(Production $model)
    {
        $this->model = $model;
    }

    public function index()
    {
        if(permission('production-access')){
            $this->setPageData('Manage Production','Manage Production','fas fa-industry',[['name' => 'Manage Production']]);
            $warehouses = DB::table('warehouses')->where('status',1)->pluck('name','id');
            return view('production::production.index',compact('warehouses'));
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
                if (!empty($request->warehouse_id)) {
                    $this->model->setWarehouseID($request->warehouse_id);
                }
                if (!empty($request->status)) {
                    $this->model->setStatus($request->status);
                }
                if (!empty($request->production_status)) {
                    $this->model->setProductionStatus($request->production_status);
                }
                if (!empty($request->transfer_status)) {
                    $this->model->setTransferStatus($request->transfer_status);
                }

                $this->set_datatable_default_properties($request);//set datatable default properties
                $list = $this->model->getDatatableList();//get table data
                $data = [];
                $no = $request->input('start');
                foreach ($list as $value) {
                    $no++;
                    $action = '';
                    if(permission('production-edit') && $value->status == 2){
                        $action .= ' <a class="dropdown-item" href="'.route("production.edit",$value->id).'">'.self::ACTION_BUTTON['Edit'].'</a>';
                    }
                    if(permission('production-view')){
                        $action .= ' <a class="dropdown-item" href="'.url("production/view/".$value->id).'">'.self::ACTION_BUTTON['View'].'</a>';
                    }
                    if(permission('production-delete')  && $value->status == 2 && $value->production_status != 3 && $value->transfer_status == 1){
                        $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->name . '">'.self::ACTION_BUTTON['Delete'].'</a>';
                    }

                    $row = [];
                    $row[] = $no;
                    $row[] = $value->batch_no;
                    $row[] = $value->warehouse->name;
                    $row[] = date('d-M-Y',strtotime($value->start_date));
                    $row[] = $value->end_date ? date('j-F-Y',strtotime($value->end_date)) : '-';
                    $row[] = $value->item;
                    $row[] = APPROVE_STATUS_LABEL[$value->status];
                    $row[] = $value->status == 1 ? PRODUCTION_STATUS_LABEL[$value->production_status] : '-';
                    $row[] = $value->production_status == 3 ? TRANSFER_STATUS_LABEL[$value->transfer_status] : '-';
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
            $this->setPageData('Add Production','Add Production','fas fa-industry',[['name' => 'Add Production']]);
            $last_batch_no = $this->model->select('batch_no')->orderBy('id','desc')->first();
            $data = [
                'products'   => DB::table('products')->where('status', 1)->pluck('name','id'),
                'warehouses' => Warehouse::activeWarehouses(),
                'batch_no'   => $last_batch_no ? $last_batch_no + 1 : '1001'
            ];
            return view('production::production.create',$data);
        }else{
            return $this->access_blocked(); 
        }
    }

    public function store(Request $request)
    {
        if ($request->ajax()) {
            // dd($request->all());
            if (permission('production-add')) {
                if($request->has('production')){
                    DB::beginTransaction();
                    try {
                        $production = $this->model->create([
                            'batch_no'     => $request->batch_no,
                            'warehouse_id' => $request->warehouse_id,
                            'item'         => count($request->production),
                            'start_date'   => $request->start_date,
                            'created_by'   => auth()->user()->name
                        ]);
                        if($production)
                        {
                            foreach($request->production as $product)
                            {
                                $product_data = [
                                    'production_id'   => $production->id,
                                    'product_id'      => $product['product_id'],
                                    'year'            => $product['year'],
                                    'mfg_date'        => $product['mfg_date'],
                                    'exp_date'        => $product['exp_date'],
                                    'has_coupon'      => $product['has_coupon'],
                                    'total_coupon'    => $product['has_coupon'] == 1 ? $product['total_coupon'] : null,
                                    'coupon_price'    => $product['has_coupon'] == 1 ? $product['coupon_price'] : null,
                                    'coupon_exp_date' => $product['has_coupon'] == 1 ? $product['coupon_exp_date'] : null,
                                ];
                                $productData = ProductionProduct::create($product_data);
                                if($product){
                                    $production_product = ProductionProduct::with('materials')->find($productData->id);
                                    $materials = [];
                                    if (!empty($product['materials']) && count($product['materials']) > 0) {
                                        foreach ($product['materials'] as $value) {
                                            $materials[$value['material_id']] = [
                                                'unit_id' => $value['unit_id'],
                                                'qty'     => $value['qty'],
                                                'cost'    => $value['cost'],
                                                'total'   => $value['total'],
                                            ];
                                        }
                                        $production_product->materials()->sync($materials);
                                    }
                                    if($product['has_coupon'] == 1)
                                    {
                                        ProductionCoupon::insert($this->generateCouponCode($production_product->id,$production->batch_no,$product['total_coupon']));
                                    }
                                }
                            }
                            $output = ['status' => 'success','message' => 'Data has been saved successfully'];
                        }else{
                            $output = ['status' => 'error','message' => 'Failed to save data'];
                        }
                        DB::commit();
                    } catch (\Throwable $th) {
                        DB::rollback();
                        $output = ['status' => 'error', 'message' => $th->getMessage()];
                    }
                }else{
                    $output = ['status' => 'error','message' => 'Fill up the input field properly'];
                }
                return response()->json($output);
            } else {
                return response()->json($this->unauthorized());
            }
        }
    }

    private function generateCouponCode(int $production_product_id,int $batch_no,int $total_coupon)
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
                $this->generateCouponCode($production_product_id,$batch_no,$total_coupon);
            }else{
                $coupon_code[] = [
                    'production_product_id' => $production_product_id,
                    'batch_no'              => $batch_no,
                    'coupon_code'           => $code,
                    'created_at'            => date('Y-m-d H:i:s')
                ];
            }
        }
        return $coupon_code;
    }

    public function product_material_list(Request $request)
    {
        $tab = $request->tab;
        $materials = DB::table('product_material as pm')
                    ->join('materials as m','pm.material_id','=','m.id')
                    ->leftJoin('units as u','m.unit_id','=','u.id')
                    ->select('pm.*','m.material_name','m.material_code','m.cost','m.qty','m.type','m.unit_id','u.unit_name','u.unit_code')
                    ->where('pm.product_id',$request->product_id)
                    ->get();
        return view('production::production.materials',compact('materials','tab'))->render();
    }
}
