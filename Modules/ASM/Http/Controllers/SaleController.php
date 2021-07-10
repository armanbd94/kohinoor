<?php

namespace Modules\ASM\Http\Controllers;

use Exception;
use App\Models\Tax;
use App\Models\Unit;
use App\Traits\UploadAble;
use Illuminate\Http\Request;
use Modules\ASM\Entities\Sale;
use Modules\ASM\Entities\Upazila;
use Illuminate\Support\Facades\DB;
use Modules\ASM\Entities\Customer;
use Illuminate\Support\Facades\Auth;
use Modules\Location\Entities\Route;
use Modules\ASM\Entities\SalesPerson;
use App\Http\Controllers\BaseController;
use Modules\Account\Entities\ChartOfAccount;
use Modules\Account\Entities\Transaction;
use Modules\ASM\Http\Requests\SaleDeliveryFormRequest;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\ASM\Http\Requests\SaleFormRequest;
use Modules\SalesMen\Entities\SalesMenDailyRoute;
use Modules\FinishGoods\Entities\WarehouseFinishGoods;

class SaleController extends BaseController
{
    use UploadAble;
    private const MEMO_NO = 1001;
    public function __construct(Sale $model)
    {
        parent::__construct($model);
    }
    
    public function index()
    {

        $this->setPageData('Sale Manage','Sale Manage','fas fa-shopping-cart',[['name' => 'Sale Manage']]);
        $data = [
            'customers' => Customer::where('district_id',Auth::guard('asm')->user()->district_id)->get(),
            'salesmen'  => SalesPerson::where('district_id',Auth::guard('asm')->user()->district_id)->get(),
            'upazilas'  => Upazila::where('parent_id',Auth::guard('asm')->user()->district_id)->get(),
            'routes'    => Route::where('grand_parent_id',Auth::guard('asm')->user()->district_id)->get(),
        ];
        return view('asm::sale.index',$data);

    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){

            if (!empty($request->memo_no)) {
                $this->model->setMemoNo($request->memo_no);
            }
            if (!empty($request->from_date)) {
                $this->model->setFromDate($request->from_date);
            }
            if (!empty($request->to_date)) {
                $this->model->setToDate($request->to_date);
            }
            if (!empty($request->salesmen_id)) {
                $this->model->setSalesmenID($request->salesmen_id);
            }
            if (!empty($request->customer_id)) {
                $this->model->setCustomerID($request->customer_id);
            }
            if (!empty($request->payment_status)) {
                $this->model->setPaymentStatus($request->payment_status);
            }
            if (!empty($request->delivery_status)) {
                $this->model->setDeliveryStatus($request->delivery_status);
            }


            $this->set_datatable_default_properties($request);//set datatable default properties
            $list = $this->model->getDatatableList();//get table data
            $data = [];
            $no = $request->input('start');
            foreach ($list as $value) {
                $no++;
                $action = '';
                $action .= ' <a class="dropdown-item" href="'.route("asm.sale.edit",$value->id).'">'.self::ACTION_BUTTON['Edit'].'</a>';
                $action .= ' <a class="dropdown-item view_data" href="'.route("asm.sale.show",$value->id).'">'.self::ACTION_BUTTON['View'].'</a>';
                
                $delivery_text = $value->delivery_status ? 'Update Delivery' : 'Add Delivery';
                $action .= ' <a class="dropdown-item add_delivery" data-id="'.$value->id.'" data-status="'.$value->delivery_status.'" data-date="'.$value->delivery_date.'" 
                data-receivedby="'.$value->received_by.'"  data-authorizedby="'.$value->authorized_by.'"><i class="fas fa-truck text-info mr-2"></i> '.$delivery_text.'</a>';
                
                $row = [];
                $row[] = $no;
                $row[] = $value->memo_no;
                $row[] = $value->salesmen->name;
                $row[] = $value->customer->shop_name.' - '.$value->customer->name;
                $row[] = $value->item;
                $row[] = number_format($value->total_price,2);
                $row[] = $value->order_discount ? number_format($value->order_discount,2) : 0;
                $row[] = $value->total_labor_cost ? number_format($value->total_labor_cost,2) : 0;
                $row[] = $value->order_tax_rate ? number_format($value->order_tax_rate,2) : 0;
                $row[] = $value->order_tax ? number_format($value->order_tax,2) : 0;
                $row[] = $value->shipping_cost ? number_format($value->shipping_cost,2) : 0;
                $row[] = number_format($value->grand_total,2);
                $row[] = number_format($value->previous_due,2);
                $row[] = number_format(($value->grand_total + $value->previous_due),2);
                $row[] = number_format($value->paid_amount,2);
                $row[] = number_format($value->due_amount,2);
                $row[] = date(config('settings.date_format'),strtotime($value->sale_date));
                $row[] = PAYMENT_STATUS_LABEL[$value->payment_status];
                $row[] = $value->payment_method ? SALE_PAYMENT_METHOD[$value->payment_method] : '<span class="label label-danger label-pill label-inline" style="min-width:70px !important;">No</span>';
                $row[] = $value->delivery_status ? DELIVERY_STATUS[$value->delivery_status] : '<span class="label label-danger label-pill label-inline" style="min-width:70px !important;">No</span>';
                $row[] = $value->delivery_date ? date(config('settings.date_format'),strtotime($value->delivery_date)) : '';
                $row[] = action_button($action);//custom helper function for action button
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
            $this->model->count_filtered(), $data);
            
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function create()
    {
            $this->setPageData('Add Sale','Add Sale','fas fa-shopping-cart',[['name' => 'Add Sale']]);
            $data = [
                'salesmen'  => SalesPerson::where('district_id',Auth::guard('asm')->user()->district_id)->get(),
                'taxes'      => Tax::activeTaxes(),
                'memo_no'   => 'SINV-'.date('YmdHis').rand(1,999)
            ];
            return view('asm::sale.create',$data);
    }

    public function store(SaleFormRequest $request)
    {
        if($request->ajax()){
            DB::beginTransaction();
            try {
                $sale_data = [
                    'memo_no'          => $request->memo_no,
                    'warehouse_id'     => Auth::guard('asm')->user()->warehouse_id,
                    'asm_id'           => Auth::guard('asm')->user()->id,
                    'salesmen_id'      => $request->salesmen_id,
                    'customer_id'      => $request->customer_id,
                    'item'             => $request->item,
                    'total_qty'        => $request->total_qty,
                    'total_discount'   => $request->total_discount,
                    'total_tax'        => $request->total_tax,
                    'total_price'      => $request->total_price,
                    'order_tax_rate'   => $request->order_tax_rate,
                    'order_tax'        => $request->order_tax,
                    'order_discount'   => $request->order_discount ? $request->order_discount : 0,
                    'shipping_cost'    => $request->shipping_cost ? $request->shipping_cost : 0,
                    'total_labor_cost' => $request->labor_cost ? $request->labor_cost : 0,
                    'grand_total'      => $request->grand_total,
                    'previous_due'     => $request->previous_due ? $request->previous_due : 0,
                    'paid_amount'      => $request->paid_amount ? $request->paid_amount : 0,
                    'due_amount'       => ($request->net_total - ($request->paid_amount ? $request->paid_amount : 0)),
                    'payment_status'   => $request->payment_status,
                    'payment_method'   => $request->payment_method ? $request->payment_method : null,
                    'account_id'       => $request->account_id ? $request->account_id : null,
                    'note'             => $request->note,
                    'sale_date'        => $request->sale_date,
                    'created_by'       => Auth::guard('asm')->user()->name
                ];

                $payment_data = [
                    'payment_method' => $request->payment_method ? $request->payment_method : null,
                    'account_id'     => $request->account_id ? $request->account_id : null,
                    'paid_amount'    => $request->paid_amount ? $request->paid_amount : null,
                ];

                if($request->hasFile('document')){
                    $sale_data['document'] = $this->upload_file($request->file('document'),SALE_DOCUMENT_PATH);
                }

                //purchase materials
                $finish_goods = [];
                $direct_cost = [];
                if($request->has('products'))
                {
                    foreach ($request->products as $key => $value) {
                        $unit = Unit::where('unit_name',$value['unit'])->first();
                        if($unit->operator == '*'){
                            $qty = $value['qty'] * $unit->operation_value;
                        }else{
                            $qty = $value['qty'] / $unit->operation_value;
                        }

                        $finish_goods[$value['id']] = [
                            'qty'              => $value['qty'],
                            'sale_unit_id'     => $unit ? $unit->id : null,
                            'net_unit_price'   => $value['net_unit_price'],
                            'discount'         => $value['discount'],
                            'tax_rate'         => $value['tax_rate'],
                            'tax'              => $value['tax'],
                            'total'            => $value['subtotal']
                        ];

                        $warehouse_finish_goods = WarehouseFinishGoods::where(['warehouse_id'=>Auth::guard('asm')->user()->warehouse_id,'finish_goods_id'=>$value['id']])->first();
                        if($warehouse_finish_goods){
                            $warehouse_finish_goods->qty -= $qty;
                            $warehouse_finish_goods->save();
                        }

                        $finish_goods_data = FinishGood::find($value['id']);
                        $direct_cost[] = $qty * ($finish_goods_data ? $finish_goods_data->cost : 0);
                    }
                }
                $sum_direct_cost = array_sum($direct_cost);

                $total_tax = ($request->total_tax ? $request->total_tax : 0) + ($request->order_tax ? $request->order_tax : 0);
                $result  = $this->model->create($sale_data);
                if(empty($result))
                {
                    if($request->hasFile('document')){
                        $this->delete_file($sale_data['document'], SALE_DOCUMENT_PATH);
                    }
                }
                $sale = $this->model->with('sale_products')->find($result->id);
                $sale->sale_products()->sync($finish_goods);

               
                
                $customer = Customer::with('coa')->find($request->customer_id);

                $data = $this->sale_balance_add($result->id,$request->memo_no,$request->grand_total,$total_tax,$sum_direct_cost,$customer->coa->id,$customer->name,$request->sale_date,$payment_data);

                $output  = $this->store_message($result, $request->sale_id);
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

 
    private function sale_balance_add(int $sale_id, $invoice_no, $grand_total, $total_tax,$sum_direct_cost, int $customer_coa_id, string $customer_name, $sale_date, array $payment_data) {

        //Inventory Credit
        $coscr = array(
            'chart_of_account_id' => DB::table('chart_of_accounts')->where('code', $this->coa_head_code('inventory'))->value('id'),
            'warehouse_id'        => Auth::guard('asm')->user()->warehouse_id,
            'voucher_no'          => $sale_id,
            'voucher_type'        => 'INVOICE',
            'voucher_date'        => $sale_date,
            'description'         => 'Inventory Credit For Invoice No '.$invoice_no,
            'debit'               => 0,
            'credit'              => $sum_direct_cost,
            'posted'              => 1,
            'approve'             => 1,
            'created_by'          => auth()->user()->name,
            'created_at'          => date('Y-m-d H:i:s')
        ); 

            // customer Debit
            $sale_coa_transaction = array(
            'chart_of_account_id' => $customer_coa_id,
            'warehouse_id'        => Auth::guard('asm')->user()->warehouse_id,
            'voucher_no'          => $sale_id,
            'voucher_type'        => 'INVOICE',
            'voucher_date'        => $sale_date,
            'description'         => 'Customer debit For Invoice No -  ' . $invoice_no . ' Customer ' .$customer_name,
            'debit'               => $grand_total,
            'credit'              => 0,
            'posted'              => 1,
            'approve'             => 1,
            'created_by'          => auth()->user()->name,
            'created_at'          => date('Y-m-d H:i:s')
        );

        
        $income = $grand_total - $sum_direct_cost - $total_tax;
        $product_sale_income = array(
            'chart_of_account_id' => DB::table('chart_of_accounts')->where('code', $this->coa_head_code('product_sale'))->value('id'),
            'warehouse_id'        => Auth::guard('asm')->user()->warehouse_id,
            'voucher_no'          => $sale_id,
            'voucher_type'        => 'INVOICE',
            'voucher_date'        => $sale_date,
            'description'         => 'Sale Income For Invoice NO - ' . $invoice_no . ' Customer ' .$customer_name,
            'debit'               => 0,
            'credit'              => $income,
            'posted'              => 1,
            'approve'             => 1,
            'created_by'          => auth()->user()->name,
            'created_at'          => date('Y-m-d H:i:s')
        ); 
        Transaction::insert([
            $coscr, $sale_coa_transaction, $product_sale_income
        ]);

        if($total_tax){
            $tax_info = array(
                'chart_of_account_id' => DB::table('chart_of_accounts')->where('code', $this->coa_head_code('tax'))->value('id'),
                'warehouse_id'        => Auth::guard('asm')->user()->warehouse_id,
                'voucher_no'          => $sale_id,
                'voucher_type'        => 'INVOICE',
                'voucher_date'        => $sale_date,
                'description'         => 'Sale Total Tax For Invoice NO - ' . $invoice_no . ' Customer ' .$customer_name,
                'debit'               => 0,
                'credit'              => $total_tax,
                'posted'              => 1,
                'approve'             => 1,
                'created_by'          => auth()->user()->name,
                'created_at'          => date('Y-m-d H:i:s')
            ); 
            Transaction::create($tax_info);
        }
        

        if(!empty($payment_data['paid_amount']))
        {
            /****************/
            $customer_credit = array(
                'chart_of_account_id' => $customer_coa_id,
                'warehouse_id'        => Auth::guard('asm')->user()->warehouse_id,
                'voucher_no'          => $sale_id,
                'voucher_type'        => 'INVOICE',
                'voucher_date'        => $sale_date,
                'description'         => 'Customer credit for Paid Amount For Customer Invoice NO- ' . $invoice_no . ' Customer- ' . $customer_name,
                'debit'               => 0,
                'credit'              => $payment_data['paid_amount'],
                'posted'              => 1,
                'approve'             => 1,
                'created_by'          => auth()->user()->name,
                'created_at'          => date('Y-m-d H:i:s')
            );
            if($payment_data['payment_method'] == 1){
                //Cah In Hand debit
                $payment = array(
                    'chart_of_account_id' => $payment_data['account_id'],
                    'warehouse_id'        => Auth::guard('asm')->user()->warehouse_id,
                    'voucher_no'          => $sale_id,
                    'voucher_type'        => 'INVOICE',
                    'voucher_date'        => $sale_date,
                    'description'         => 'Cash in Hand in Sale for Invoice No - ' . $invoice_no . ' customer- ' .$customer_name,
                    'debit'               => $payment_data['paid_amount'],
                    'credit'              => 0,
                    'posted'              => 1,
                    'approve'             => 1,
                    'created_by'          => auth()->user()->name,
                    'created_at'          => date('Y-m-d H:i:s')
                    
                );
            }else{
                // Bank Ledger
                $payment = array(
                    'chart_of_account_id' => $payment_data['account_id'],
                    'warehouse_id'        => Auth::guard('asm')->user()->warehouse_id,
                    'voucher_no'          => $sale_id,
                    'voucher_type'        => 'INVOICE',
                    'voucher_date'        => $sale_date,
                    'description'         => 'Paid amount for customer  Invoice No - ' . $invoice_no . ' customer -' . $customer_name,
                    'debit'               => $payment_data['paid_amount'],
                    'credit'              => 0,
                    'posted'              => 1,
                    'approve'             => 1,
                    'created_by'          => auth()->user()->name,
                    'created_at'          => date('Y-m-d H:i:s')
                );
            }
            Transaction::insert([$customer_credit,$payment]);
            
        }
    }


    public function show(int $id)
    {

            $this->setPageData('Sale Details','Sale Details','fas fa-file',[['name'=>'Sale','link' => route('asm.sale')],['name' => 'Sale Details']]);
            $sale = $this->model->with('sale_products','customer','salesmen')->find($id);
            return view('asm::sale.details',compact('sale'));

    }
    public function edit(int $id)
    {


            $this->setPageData('Edit Sale','Edit Sale','fas fa-edit',[['name'=>'Sale','link' => route('purchase')],['name' => 'Edit Sale']]);
            $sale_data = $this->model->with('sale_products','customer')->find($id);
            $data = [
                'sale'      => $sale_data,
                'salesmen'  => SalesPerson::where('district_id',Auth::guard('asm')->user()->district_id)->get(),
                'taxes'     => Tax::activeTaxes(),
                'routes'    => SalesMenDailyRoute::with('route')->where('salesmen_id',$sale_data->salesmen_id)->get(),
                'customers' => Customer::where('route_id',$sale_data->customer->route_id)->get()
            ];
            return view('asm::sale.edit',$data);

    }

    public function update(SaleFormRequest $request)
    {
        if($request->ajax()){
            // dd($request->all());
            DB::beginTransaction();
            try {
                $sale_data = [
                    'memo_no'          => $request->memo_no,
                    'warehouse_id'     => Auth::guard('asm')->user()->warehouse_id,
                    'asm_id'           => Auth::guard('asm')->user()->id,
                    'salesmen_id'      => $request->salesmen_id,
                    'customer_id'      => $request->customer_id,
                    'item'             => $request->item,
                    'total_qty'        => $request->total_qty,
                    'total_discount'   => $request->total_discount,
                    'total_tax'        => $request->total_tax,
                    'total_price'      => $request->total_price,
                    'order_tax_rate'   => $request->order_tax_rate,
                    'order_tax'        => $request->order_tax,
                    'order_discount'   => $request->order_discount ? $request->order_discount : 0,
                    'shipping_cost'    => $request->shipping_cost ? $request->shipping_cost : 0,
                    'total_labor_cost' => $request->labor_cost ? $request->labor_cost : 0,
                    'grand_total'      => $request->grand_total,
                    'previous_due'     => $request->previous_due ? $request->previous_due : 0,
                    'paid_amount'      => $request->paid_amount ? $request->paid_amount : 0,
                    'due_amount'       => ($request->net_total - ($request->paid_amount ? $request->paid_amount : 0)),
                    'payment_status'   => $request->payment_status,
                    'payment_method'   => $request->payment_method ? $request->payment_method : null,
                    'account_id'       => $request->account_id ? $request->account_id : null,
                    'note'             => $request->note,
                    'sale_date'        => $request->sale_date,
                    'updated_by'       => Auth::guard('asm')->user()->name
                ];

                $payment_data = [
                    'payment_method' => $request->payment_method,
                    'account_id'     => $request->account_id,
                    'paid_amount'    => $request->paid_amount,
                ];

                if($request->hasFile('document')){
                    $sale_data['document'] = $this->upload_file($request->file('document'),SALE_DOCUMENT_PATH);
                }
                $saleData = $this->model->with('sale_products')->find($request->sale_id);
                $old_document = $saleData ? $saleData->document : '';

                if(!$saleData->sale_products->isEmpty())
                {
                    foreach ($saleData->sale_products as  $sale_product) {
                        $old_sold_qty = $sale_product->pivot->qty;
                        $sale_unit = Unit::find($sale_product->pivot->sale_unit_id);
                        if($sale_unit->operator == '*'){
                            $old_sold_qty = $old_sold_qty * $sale_unit->operation_value;
                        }else{
                            $old_sold_qty = $old_sold_qty / $sale_unit->operation_value;
                        }

                        $warehouse_product = WarehouseFinishGoods::where([
                            'warehouse_id'=>$saleData->warehouse_id,
                            'product_id'=>$sale_product->product_id,
                            'finish_goods_id'=>$sale_product->id,
                            ])->first();
                        $warehouse_product->qty += $old_sold_qty;
                        $warehouse_product->update();
                    }
                }

                //purchase finish goods
                $finish_goods = [];
                $direct_cost  = [];
                if($request->has('products'))
                {
                    foreach ($request->products as $key => $value) {
                        $unit = Unit::where('unit_name',$value['unit'])->first();
                        if($unit->operator == '*'){
                            $qty = $value['qty'] * $unit->operation_value;
                        }else{
                            $qty = $value['qty'] / $unit->operation_value;
                        }

                        $finish_goods[$value['id']] = [
                            'qty'              => $value['qty'],
                            'sale_unit_id'     => $unit ? $unit->id : null,
                            'net_unit_price'   => $value['net_unit_price'],
                            'discount'         => $value['discount'],
                            'tax_rate'         => $value['tax_rate'],
                            'tax'              => $value['tax'],
                            'total'            => $value['subtotal']
                        ];

                        $warehouse_finish_goods = WarehouseFinishGoods::where(['warehouse_id'=>Auth::guard('asm')->user()->warehouse_id,'finish_goods_id'=>$value['id']])->first();
                        if($warehouse_finish_goods){
                            $warehouse_finish_goods->qty -= $qty;
                            $warehouse_finish_goods->save();
                        }

                        $finish_goods_data = FinishGood::find($value['id']);
                        $direct_cost[] = $qty * ($finish_goods_data ? $finish_goods_data->cost : 0);
                    }
                }
                $sum_direct_cost = array_sum($direct_cost);
                $total_tax = ($request->total_tax ? $request->total_tax : 0) + ($request->order_tax ? $request->order_tax : 0);
                $sale = $saleData->update($sale_data);
                if($sale && $old_document != '')
                {
                    $this->delete_file($old_document,SALE_DOCUMENT_PATH);
                }
                
                $saleData->sale_products()->sync($finish_goods);

                Transaction::where(['voucher_no'=>$request->sale_id,'voucher_type'=>'INVOICE'])->delete();
                $customer = Customer::with('coa')->find($request->customer_id);
                $this->sale_balance_add($request->sale_id,$request->memo_no,$request->grand_total,$total_tax,$sum_direct_cost,$customer->coa->id,$customer->name,$request->sale_date,$payment_data);
                $output  = $this->store_message($sale, $request->sale_id);
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

    public function delivery_status_update(SaleDeliveryFormRequest $request)
    {
        $data = [
            'delivery_status' => $request->delivery_status,
            'delivery_date'   => $request->delivery_date,
            'authorized_by'   => $request->authorized_by,
            'received_by'     => $request->received_by,
        ];
        $result = $this->model->find($request->sale_id)->update($data);
        $output  = $this->store_message($result, $request->sale_id);
        return response()->json($output);
    }


}
