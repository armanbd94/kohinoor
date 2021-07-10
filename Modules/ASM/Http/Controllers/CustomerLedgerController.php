<?php

namespace Modules\ASM\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Illuminate\Support\Facades\Auth;
use Modules\ASM\Entities\Customer;
use Modules\ASM\Entities\CustomerLedger;

class CustomerLedgerController extends BaseController
{
    public function __construct(CustomerLedger $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Customer Ledger','Customer Ledger','fas fa-file-invoice-dollar',[['name'=>'Customer','link'=>route('asm.customer')],['name'=>'Customer Ledger']]);
        $customers = Customer::with('coa')->where(['status'=>1,'district_id'=> Auth::guard('asm')->user()->district_id])->orderBy('name','asc')->get();
        return view('asm::customer.ledger.index',compact('customers'));
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){

            if (!empty($request->customer_id)) {
                $this->model->setCustomerID($request->customer_id);
            }
            if (!empty($request->start_date)) {
                $this->model->setStartDate($request->start_date);
            }
            if (!empty($request->end_date)) {
                $this->model->setEndDate($request->end_date);
            }

            $this->set_datatable_default_properties($request);//set datatable default properties
            $list = $this->model->getDatatableList();//get table data
            $data = [];
            $debit = $credit = $balance = 0;
            foreach ($list as $value) {
                $debit += $value->debit;
                $credit += $value->credit;
                $balance = $debit - $credit;
                $row = [];
                $row[] = $value->voucher_date;
                $row[] = $value->description;
                $row[] = $value->voucher_no;
                $row[] = $value->debit ? number_format($value->debit,2, '.', ',') :  number_format(0,2, '.', ',');
                $row[] = $value->credit ? number_format($value->credit,2, '.', ',') :  number_format(0,2, '.', ',');
                $row[] = number_format(($balance),2, '.', ',');
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
            $this->model->count_filtered(), $data);
            
        }else{
            return response()->json($this->unauthorized());
        }
    }

    
}
