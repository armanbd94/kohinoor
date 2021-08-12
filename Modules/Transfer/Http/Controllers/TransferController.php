<?php

namespace Modules\Transfer\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Transfer\Entities\Transfer;
use App\Http\Controllers\BaseController;
use Modules\Production\Entities\Production;
use Modules\Product\Entities\WarehouseProduct;
use Modules\Transfer\Entities\TransferProduct;
use Modules\Transfer\Http\Requests\TransferRequest;

class TransferController extends BaseController
{
    public function __construct(Transfer $model)
    {
        $this->model = $model;
    }

    public function index()
    {
        if(permission('stock-transfer-access')){
            $this->setPageData('Manage Transfer','Manage Transfer','fas fa-share-square',[['name' => 'Manage Transfer']]);
            $warehouses = DB::table('warehouses')->where('status',1)->pluck('name','id');
            return view('transfer::index',compact('warehouses'));
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('stock-transfer-access')){

                if (!empty($request->chalan_no)) {
                    $this->model->setChalanNo($request->chalan_no);
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

                $this->set_datatable_default_properties($request);//set datatable default properties
                $list = $this->model->getDatatableList();//get table data
                $data = [];
                $no = $request->input('start');
                foreach ($list as $value) {
                    $no++;
                    $action = '';

                    if(permission('production-view')){
                        $action .= ' <a class="dropdown-item" href="'.url("transfer/view/".$value->id).'">'.self::ACTION_BUTTON['View'].'</a>';
                    }

                    $row = [];
                    $row[] = $no;
                    $row[] = $value->production->batch_no;
                    $row[] = $value->chalan_no;
                    $row[] = $value->warehouse->name;
                    $row[] = date('d-M-Y',strtotime($value->transfer_date));
                    $row[] = $value->item;
                    $row[] = $value->grand_total;
                    $row[] = $value->received_by;
                    $row[] = $value->carried_by;
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

    public function store(TransferRequest $request)
    {
        if ($request->ajax()) {
            if(permission('stock-transfer-add')){
                // dd($request->all());
                DB::beginTransaction();
                try {
                    $production = Production::find($request->production_id)->update([
                        'transfer_status' => $request->transfer_status,
                        'transfer_date'   => $request->transfer_date
                    ]);
                    if($production && $request->transfer_status == 2)
                    {
                        $transfer_data = [
                            'production_id'       => $request->production_id,
                            'chalan_no'           => $request->chalan_no,
                            'warehouse_id'        => $request->warehouse_id,
                            'item'                => $request->total_item,
                            'total_unit_qty'      => $request->total_unit_qty,
                            'total_base_unit_qty' => $request->total_base_unit_qty,
                            'total_tax'           => $request->total_tax,
                            'total'               => $request->total_cost,
                            'shipping_cost'       => $request->shipping_cost,
                            'labor_cost'          => $request->labor_cost,
                            'grand_total'         => $request->grand_total,
                            'received_by'         => $request->received_by,
                            'carried_by'          => $request->carried_by,
                            'transfer_date'       => $request->transfer_date,
                            'remarks'             => $request->remarks,
                            'created_by'          => auth()->user()->name
                        ];

                        $transfer = $this->model->create($transfer_data);
                        if($transfer){
                            $products = [];
                            if($request->has('products'))
                            {
                                foreach ($request->products as $value) {
                                    $products[] = [
                                        'transfer_id'     => $transfer->id,
                                        'product_id'      => $value['product_id'],
                                        'unit_qty'        => $value['unit_qty'],
                                        'base_unit_qty'   => $value['base_unit_qty'],
                                        'net_unit_price'  => $value['net_unit_price'],
                                        'base_unit_price' => $value['base_unit_price'],
                                        'tax_rate'        => $value['tax_rate'],
                                        'tax'             => $value['tax'],
                                        'total'           => $value['total'],
                                        'created_at'      => date('Y-m-d')
                                    ];
        
                                    $warehouse_product = WarehouseProduct::where([
                                        ['warehouse_id', $request->warehouse_id],
                                        ['batch_no', $request->batch_no],
                                        ['product_id', $value['product_id']],
                                    ])->first();
                                    if ($warehouse_product) {
                                        $warehouse_product->qty += $value['base_unit_qty'];
                                        $warehouse_product->update();
                                    } else {
                                        WarehouseProduct::create([
                                            'batch_no'     => $request->batch_no,
                                            'warehouse_id' => $request->warehouse_id,
                                            'product_id'   => $value['product_id'],
                                            'qty'          => $value['base_unit_qty'],
                                        ]);
                                    }
                                }
                                if(count($products) > 0)
                                {
                                    TransferProduct::insert($products);
                                }
                            }
                            $output = ['status'=>'success','message'=>'Production products transferred successfully','transfer_id'=>$transfer->id];
                        }else{
                            $output = ['status'=>'error','message'=>'Failed to transfer products!'];
                        }
                    }
                    DB::commit();
                } catch (\Throwable $th) {
                    $output = ['status'=>'error','message'=>$th->getMessage()];
                }
                return response()->json($output);
            }
        }
    }

    public function show(int $id)
    {
        if(permission('stock-transfer-view')){
            $this->setPageData('Transfer Details','Transfer Details','fas fa-file',[['name' => 'Transfer Details']]);
            $transfer = $this->model->with(['production:id,batch_no','warehouse:id,name','products'])->find($id);
            return view('transfer::details',compact('transfer'));
        }else{
            return $this->access_blocked();
        }
    }
}
