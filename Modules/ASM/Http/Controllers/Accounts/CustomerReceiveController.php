<?php

namespace Modules\ASM\Http\Controllers\Accounts;

use Exception;
use Illuminate\Http\Request;
use Modules\ASM\Entities\Upazila;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Modules\Customer\Entities\Customer;
use App\Http\Controllers\BaseController;
use Modules\Account\Entities\Transaction;
use Modules\ASM\Http\Requests\CustomerReceiveFormRequest;

class CustomerReceiveController extends BaseController
{
    public function __construct(Transaction $model)
    {
        parent::__construct($model);
    }


    public function index()
    {

        $this->setPageData('Customer Receive','Customer Receive','far fa-money-bill-alt',[['name'=>'Accounts'],['name'=>'Customer Receive']]);
        $voucher_no = 'CR-'.date('YmdHis').rand(1,999);
        $upazilas  = Upazila::where(['status'=>1,'parent_id'=> Auth::guard('asm')->user()->district_id])->get();
        return view('asm::account.customer-receive.index',compact('voucher_no','upazilas'));

    }

    public function store(CustomerReceiveFormRequest $request)
    {
        if($request->ajax()){
            DB::beginTransaction();
            try {
                $customer = Customer::with('coa')->find($request->customer_id);
                $vtype = 'CR';
                /****************/
                $customer_credit = array(
                    'chart_of_account_id' => $customer->coa->id,
                    'warehouse_id'        =>  Auth::guard('asm')->user()->warehouse_id,
                    'voucher_no'          => $request->voucher_no,
                    'voucher_type'        => $vtype,
                    'voucher_date'        => $request->voucher_date,
                    'description'         => $request->remarks,
                    'debit'               => 0,
                    'credit'              => $request->amount,
                    'posted'              => 1,
                    'approve'             => 1,
                    'created_by'          => auth()->user()->name,
                    'created_at'          => date('Y-m-d H:i:s')
                );
                if($request->payment_type == 1){
                    //Cah In Hand For Supplier
                    $payment = array(
                        'chart_of_account_id' => $request->account_id,
                        'warehouse_id'        =>  Auth::guard('asm')->user()->warehouse_id,
                        'voucher_no'          => $request->voucher_no,
                        'voucher_type'        => $vtype,
                        'voucher_date'        => $request->voucher_date,
                        'description'         => 'Cash In Hand For ' . $customer->name,
                        'debit'               => $request->amount,
                        'credit'              => 0,
                        'posted'              => 1,
                        'approve'             => 1,
                        'created_by'          => auth()->user()->name,
                        'created_at'          => date('Y-m-d H:i:s')
                        
                    );
                }else{
                    // Bank Ledger
                    $payment = array(
                        'chart_of_account_id' => $request->account_id,
                        'warehouse_id'        =>  Auth::guard('asm')->user()->warehouse_id,
                        'voucher_no'          => $request->voucher_no,
                        'voucher_type'        => $vtype,
                        'voucher_date'        => $request->voucher_date,
                        'description'         => 'Customer Receive From ' . $customer->name,
                        'debit'               => $request->amount,
                        'credit'              => 0,
                        'posted'              => 1,
                        'approve'             => 1,
                        'created_by'          => auth()->user()->name,
                        'created_at'          => date('Y-m-d H:i:s')
                    );
                }

                $customer_transaction = $this->model->create($customer_credit);
                $payment_transaction = $this->model->create($payment);
                if($customer_transaction && $payment_transaction){
                    $output = ['status'=>'success','message' => 'Payment Data Saved Successfully'];
                    $output['customer_transaction'] = $customer_transaction->id;
                }else{
                    $output = ['status'=>'error','message' => 'Failed To Save Payment Data'];
                }
                DB::commit();
            } catch (Exception $e) {
                DB::rollBack();
                $output = ['status' => 'error','message' => $e->getMessage()];
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function show(int $id,int $payment_type)
    {
        $this->setPageData('Customer Receive Voucher Print','Customer Receive Voucher Print','far fa-money-bill-alt',[['name'=>'Customer Receive Voucher Print']]);
        $data = $this->model->with('coa')->find($id);
        return view('asm::account.customer-receive.print',compact('data','payment_type'));
    }
}
