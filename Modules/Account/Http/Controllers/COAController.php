<?php

namespace Modules\Account\Http\Controllers;

use App\Models\Warehouse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\BaseController;
use Modules\Account\Entities\ChartOfAccount;
use Modules\Account\Http\Requests\COAFormRequest;

class COAController extends BaseController
{
    public function __construct(ChartOfAccount $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('coa-access')){
            $this->setPageData('Chart of Account','Chart of Account','far fa-money-bill-alt',[['name' => 'Chart of Account']]);
            $data = [
                'warehouses' => Warehouse::where('status',1)->get(),
                'accounts'      => $this->model->where('status',1)->orderBy('name','asc')->get(),
            ];
            return view('account::coa.index',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('coa-access')){

                if (!empty($request->name)) {
                    $this->model->setName($request->name);
                }
                

                $this->set_datatable_default_properties($request);//set datatable default properties
                $list = $this->model->getDatatableList();//get table data
                $data = [];
                $no = $request->input('start');
                foreach ($list as $value) {
                    $no++;
                    $action = '';
                    if(permission('coa-edit')){
                        $action .= ' <a class="dropdown-item edit_data" data-id="' . $value->id . '">'.self::ACTION_BUTTON['Edit'].'</a>';
                    }
                    if(permission('coa-delete')){
                        $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->name . '">'.self::ACTION_BUTTON['Delete'].'</a>';
                    }

                    $row = [];
                    $row[] = $no;
                    $row[] = $value->name;
                    $row[] = $value->code;
                    $row[] = $value->parent_name;
                    $row[] = $value->type;
                    $row[] = $this->opening_coa_balance($value->id,$value->name,$request->warehouse_id);
                    $row[] = $this->coa_balance($value->id,$value->name,$request->warehouse_id);
                    // $row[] = action_button($action);//custom helper function for action button
                    $data[] = $row;
                }
                return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
                $this->model->count_filtered(), $data);
            }
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function store_or_update_data(COAFormRequest $request)
    {
        if($request->ajax()){
            if(permission('coa-add')){
                $collection     = collect($request->validated())->except('material_image','purchase_price','qty','alert_qty','tax_id');
                $material_image = $request->old_material_image;
                $purchase_price = $request->purchase_price ? $request->purchase_price : 0;
                $qty            = $request->qty ? $request->qty : 0;
                $alert_qty      = $request->alert_qty ? $request->alert_qty : 0;
                if($request->hasFile('material_image')){
                    $material_image  = $this->upload_file($request->file('material_image'),MATERIAL_IMAGE_PATH);
                    if(!empty($request->old_material_image)){
                        $this->delete_file($request->old_material_image, MATERIAL_IMAGE_PATH);
                    }  
                }
                $tax_id       = ($request->tax_id != 0) ? $request->tax_id : null;
                $collection   = $collection->merge(compact('material_image','purchase_price','qty','alert_qty','tax_id'));
                $collection   = $this->track_data($collection,$request->update_id);
                $result       = $this->model->updateOrCreate(['id'=>$request->update_id],$collection->all());
                $output       = $this->store_message($result, $request->update_id);
                if(!$result)
                {
                    if($request->hasFile('material_image')){
                        $this->delete_file($material_image, MATERIAL_IMAGE_PATH);
                    }
                }
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }


    public function edit(Request $request)
    {
        if($request->ajax()){
            if(permission('coa-edit')){
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
            if(permission('coa-delete')){
                $result  = $this->model->find($request->id);
                $output   = $this->delete_message($result);
            }else{
                $output   = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    /*******************************
    * Begin :: Opening COA Balance *
    ********************************/
    public function opening_coa_balance($coa_id, $coa_name,$warehouse_id = null)
    {
        $query = DB::table('transactions as t')
                ->selectRaw('sum(t.debit) as predebit, sum(t.credit) as precredit')
                ->where([['approve',1],['is_opening',1],['chart_of_account_id',$coa_id]]);
        if($warehouse_id)
        {
            $query->where('warehouse_id',$warehouse_id);
        }
        $query = $query->first();
        $ass_bal = $query->predebit - $query->precredit;
        $balance = $ass_bal;
        if ($coa_name == 'Customer Receivable') {
            $balance = $this->customer_rec_opening($warehouse_id);
        }
        if ($coa_name == 'Loan Receivable') {
            $balance = $this->loan_rec_opening($warehouse_id);
        }
        if ($coa_name == 'Account Receivable') {
            $root_balance = $this->account_rec_opening($warehouse_id);
            $customer_balance = $this->customer_rec_opening($warehouse_id);
            $loan_balance = $this->loan_rec_opening($warehouse_id);
            $balance = $root_balance + $customer_balance + $loan_balance;
        }
        if ($coa_name == 'Cash At Bank') {
            $balance = $this->bank_opening($warehouse_id);
        }
        if ($coa_name == 'Cash At Mobile Bank') {
            $balance = $this->mobile_bank_opening($warehouse_id);
        }
        if ($coa_name == 'Cash & Cash Equivalent') {
            $balance = $this->cash_equivalent_opening($warehouse_id);
        }
        if ($coa_name == 'Current Asset') {
            $cash_equivalent_balance = $this->cash_equivalent_opening($warehouse_id);
            $root_balance = $this->account_rec_opening($warehouse_id);
            $customer_balance = $this->customer_rec_opening($warehouse_id);
            $loan_balance = $this->loan_rec_opening($warehouse_id);
            $balance = $root_balance + $customer_balance + $loan_balance + $cash_equivalent_balance;
        }

        if ($coa_name == 'Non Current Assets') {
            $balance = $this->non_current_ass_opening($warehouse_id);
        }
        if ($coa_name == 'Assets') {
            $non_curopen = $this->non_current_ass_opening($warehouse_id);
            $cash_equivalent_balance = $this->cash_equivalent_opening($warehouse_id);
            $root_balance = $this->account_rec_opening($warehouse_id);
            $customer_balance = $this->customer_rec_opening($warehouse_id);
            $loan_balance = $this->loan_rec_opening($warehouse_id);
            $balance = $root_balance + $customer_balance + $loan_balance + $cash_equivalent_balance + $non_curopen;
        }

        if ($coa_name == 'Equity') {
            $balance = $this->equity_opening($warehouse_id);
        }

        if ($coa_name == 'Expense') {
            $balance = $this->expense_opening($warehouse_id);
        }

        if ($coa_name == 'Income') {
            $balance = $this->income_opening($warehouse_id);
        }
        if ($coa_name == 'Account Payable') {
            $balance = $this->acc_payable_opening($warehouse_id);
        }

        if ($coa_name == 'Employee Ledger') {
            $balance = $this->acc_employeeledger_opening($warehouse_id);
        }

        if ($coa_name == 'Current Liabilities') {
            $cur_balance = $this->acc_curliabilities_opening($warehouse_id);
            $paya_balance = $this->acc_payable_opening($warehouse_id);
            $employe_balance = $this->acc_employeeledger_opening($warehouse_id);
            $balance = $cur_balance + $paya_balance + $employe_balance;
        }

        if ($coa_name == 'Non Current Liabilities') {
            $balance = $this->acc_non_curliabilities_opening($warehouse_id);
        }

        if ($coa_name == 'Liabilities') {
            $non_balance = $this->acc_non_curliabilities_opening($warehouse_id);
            $cur_balance = $this->acc_curliabilities_opening($warehouse_id);
            $paya_balance = $this->acc_payable_opening($warehouse_id);
            $employe_balance = $this->acc_employeeledger_opening($warehouse_id);
            $balance = $cur_balance + $paya_balance + $employe_balance + $non_balance;
        }

        return (!empty($balance) ? number_format($balance, 2) : number_format(0, 2));
    }

    private function customer_rec_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Customer Receivable');
        if(!$coa->isEmpty())
        {
            foreach ($coa as $assetcoa) {
                $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
                $cust_bal = $query->predebit - $query->precredit;
                $total += $cust_bal;
            }
        }
        return $total;
    }

    private function loan_rec_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Loan Receivable');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function account_rec_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Account Receivable');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function bank_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Cash At Bank');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }
    private function mobile_bank_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Cash At Mobile Bank');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function cash_equivalent_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Cash & Cash Equivalent');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function non_current_ass_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Non Current Assets');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function equity_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Equity');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function expense_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Expense');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function income_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Income');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function acc_payable_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Account Payable');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function acc_employeeledger_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Employee Ledger');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function acc_curliabilities_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Current Liabilities');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function acc_non_curliabilities_opening($warehouse_id = null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Non Current Liabilities');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_opening_transaction($assetcoa->id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            $total += $cust_bal;
        }
        return $total;
    }

    private function coa_opening_transaction($coa_id,$warehouse_id = null)
    {
        $query = DB::table('transactions as t')
                ->selectRaw('sum(t.debit) as predebit, sum(t.credit) as precredit')
                ->where([['approve',1],['is_opening',1],['chart_of_account_id',$coa_id]]);
        if($warehouse_id)
        {
            $query->where('warehouse_id',$warehouse_id);
        }
        $query = $query->first();
        return $query;
    }
    /*******************************
    * End :: Opening COA Balance *
    ********************************/
    private function coa_parent_name_based_list($parent_name)
    {
        return $this->model->where('parent_name',$parent_name)->get();
    }
    /*******************************
    * Start :: COA Balance *
    ********************************/
    private function coa_transaction($coa_id,$warehouse_id = null)
    {
        $query = DB::table('transactions as t')
                ->selectRaw('sum(t.debit) as predebit, sum(t.credit) as precredit')
                ->where([['approve',1],['chart_of_account_id',$coa_id]]);
        if($warehouse_id)
        {
            $query->where('warehouse_id',$warehouse_id);
        }
        $query = $query->first();
        return $query;
    }
    public function coa_balance($coa_id, $coa_name,$warehouse_id = null)
    {
        $head_info = $this->model->find($coa_id);
        $balance = 0;
        $total_customer_rcv = 0;
        $total_loan_rcv = 0;
        $single_balance = 0;
        /*all head single(common) balance*/
        $query = $this->coa_transaction($coa_id,$warehouse_id);
        $single_bal = $query->predebit - $query->precredit;
        $single_balance += (!empty($single_bal) ? $single_bal : 0);
        $balance = $single_balance;

        /*single customer receivable balance*/
        if ($head_info->parent_name == 'Customer Receivable') {
            $query = $this->coa_transaction($coa_id,$warehouse_id);
            $cust_bal = $query->predebit - $query->precredit;
            // $customer_balance += (!empty($cust_bal) ? $cust_bal : 0);

            $balance = (!empty($cust_bal) ? $cust_bal : 0);
        }

        /*single loan receivable balance*/
        if ($head_info->parent_name == 'Loan Receivable') {
            $query = $this->coa_transaction($coa_id,$warehouse_id);
            $lnp_bal = $query->predebit - $query->precredit;
            // $loanrcv_balance += (!empty($lnp_bal) ? $lnp_bal : 0);

            $balance = (!empty($lnp_bal) ? $lnp_bal : 0);
        }

        /*total customer receivable balance*/
        if ($coa_name == 'Customer Receivable') {
            $coa = $this->coa_parent_name_based_list('Customer Receivable');
            $asset_balance = 0;
            foreach ($coa as $assetcoa) {
                $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
                $ass_bal = $query->predebit - $query->precredit;
                $asset_balance += (!empty($ass_bal) ? $ass_bal : 0);
            }

            $balance = $asset_balance;

        }

        /*total Loan receivable balance*/
        if ($coa_name == 'Loan Receivable') {
            $coa = $this->coa_parent_name_based_list('Loan Receivable');
            $asset_balance = 0;
            foreach ($coa as $assetcoa) {
                $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
                $ass_bal = $query->predebit - $query->precredit;
                $asset_balance += (!empty($ass_bal) ? $ass_bal : 0);
            }

            $balance = $asset_balance;
            $total_loan_rcv = $balance;

        }

        /*total cash at bank balance*/
        if ($coa_name == 'Cash At Bank') {
            $coa = $this->coa_parent_name_based_list('Cash At Bank');
            $asset_balance = 0;
            foreach ($coa as $assetcoa) {
                $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
                $ass_bal = $query->predebit - $query->precredit;
                $asset_balance += (!empty($ass_bal) ? $ass_bal : 0);
            }

            $balance = $asset_balance;

        }

        /*single bank balance*/
        if ($head_info->parent_name == 'Cash At Bank') {
            $query = $this->coa_transaction($coa_id,$warehouse_id);
            $bank_bal = $query->predebit - $query->precredit;
            // $bank_balance += (!empty($bank_bal) ? $bank_bal : 0);
            $balance = (!empty($bank_bal) ? $bank_bal : 0);

        }

        /*total account receivable*/
        if ($coa_name == 'Account Receivable') {
            $coa = $this->coa_parent_name_based_list('Customer Receivable');
            $asset_balance = $loan_balance = 0;
            foreach ($coa as $assetcoa) {
                $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
                $ass_bal = $query->predebit - $query->precredit;
                $asset_balance += (!empty($ass_bal) ? $ass_bal : 0);
            }

            $lncoa = $this->coa_parent_name_based_list('Loan Receivable');
            foreach ($lncoa as $lnassetcoa) {
                $lnquery = $this->coa_transaction($lnassetcoa->id,$warehouse_id);
                $ln_bal = $lnquery->predebit - $lnquery->precredit;
                $loan_balance += (!empty($ln_bal) ? $ln_bal : 0);
            }

            $single_acc_rcv = $this->coa_parent_name_based_list('Account Receivable');
            foreach ($single_acc_rcv as $singl_rcv) {
                $rcvquery = $this->coa_transaction($singl_rcv->id,$warehouse_id);
                $sreceive_bal = $rcvquery->predebit - $rcvquery->precredit;
                $single_balance += (!empty($sreceive_bal) ? $sreceive_bal : 0);
            }

            $balance = $asset_balance + $loan_balance + $single_balance;

        }

        if ($coa_name == 'Cash & Cash Equivalent') {
            $bank_balance = 0;
            $mobile_bank_balance = 0;
            $cash_balance = 0;

            $coa = $this->coa_parent_name_based_list('Cash At Bank');
            foreach ($coa as $assetcoa) {
                $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
                $bank_bal = $query->predebit - $query->precredit;
                $bank_balance += (!empty($bank_bal) ? $bank_bal : 0);
            }

            $coa_mobile = $this->coa_parent_name_based_list('Cash At Mobile Bank');
            foreach ($coa_mobile as $assetcoa) {
                $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
                $mobile_bank_bal = $query->predebit - $query->precredit;
                $mobile_bank_balance += (!empty($mobile_bank_bal) ? $mobile_bank_bal : 0);
            }

            $cash_other = $this->coa_parent_name_based_list('Cash & Cash Equivalent');
            foreach ($cash_other as $cashother) {
                $query = $this->coa_transaction($cashother->id,$warehouse_id);
                $cash_bal = $query->predebit - $query->precredit;
                $cash_balance += (!empty($cash_bal) ? $cash_bal : 0);
            }

            $balance = $bank_balance + $mobile_bank_balance + $cash_balance;

        }

        if ($coa_name == 'Current Asset') {

            $balance = $this->total_current_asset_balance($warehouse_id);

        }

        if ($coa_name == 'Non Current Assets') {

            $balance = $this->total_non_current_asset_balance($warehouse_id);

        }
        if ($coa_name == 'Assets') {
            $cur_balance = $this->total_current_asset_balance($warehouse_id);
            $non_cure_balance = $this->total_non_current_asset_balance($warehouse_id);
            $balance = $cur_balance + $non_cure_balance;

        }

        if ($coa_name == 'Equity') {
            $balance = $this->total_equity_balance($warehouse_id);
        }

        if ($coa_name == 'Expense') {
            $balance = $this->total_expense_balance($warehouse_id);
        }

        if ($coa_name == 'Income') {
            $balance = $this->total_income_balance($warehouse_id);
        }
        if ($coa_name == 'Account Payable') {
            $balance = $this->total_acc_payable_balance($warehouse_id);
        }
        if ($coa_name == 'Employee Ledger') {
            $balance = $this->total_acc_employee_balance($warehouse_id);
        }
        if ($coa_name == 'Current Liabilities') {
            $balance_ac_payable = $this->total_acc_payable_balance($warehouse_id);
            $emp_payable = $this->total_acc_employee_balance($warehouse_id);
            $rootcur_liablities = $this->total_acc_cruliabilities_balance($warehouse_id);
            $balance = $balance_ac_payable + $emp_payable + $rootcur_liablities;
        }

        if ($coa_name == 'Non Current Liabilities') {
            $balance = $this->total_acc_no_curliability_balance($warehouse_id);
        }

        if ($coa_name == 'Liabilities') {
            $non_cur_balance = $this->total_acc_no_curliability_balance($warehouse_id);
            $balance_ac_payable = $this->total_acc_payable_balance($warehouse_id);
            $emp_payable = $this->total_acc_employee_balance($warehouse_id);
            $rootcur_liablities = $this->total_acc_cruliabilities_balance($warehouse_id);
            $balance = $balance_ac_payable + $emp_payable + $rootcur_liablities + $non_cur_balance;
        }

        return (!empty($balance) ? number_format($balance, 2) : number_format(0, 2));
    }

    public function total_current_asset_balance($warehouse_id=null)
    {
        $asset_balance = $loan_balance = $single_balance = 0;
        $coa = $this->coa_parent_name_based_list('Customer Receivable');
        $asset_balance = 0;
        foreach ($coa as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $ass_bal = $query->predebit - $query->precredit;
            $asset_balance += (!empty($ass_bal) ? $ass_bal : 0);
        }

        $lncoa = $this->coa_parent_name_based_list('Loan Receivable');
        foreach ($lncoa as $lnassetcoa) {
            $lnquery = $this->coa_transaction($lnassetcoa->id,$warehouse_id);
            $ln_bal = $lnquery->predebit - $lnquery->precredit;
            $loan_balance += (!empty($ln_bal) ? $ln_bal : 0);
        }

        $single_acc_rcv = $this->coa_parent_name_based_list('Account Receivable');
        foreach ($single_acc_rcv as $singl_rcv) {
            $rcvquery = $this->coa_transaction($singl_rcv->id,$warehouse_id);
            $sreceive_bal = $rcvquery->predebit - $rcvquery->precredit;
            $single_balance += (!empty($sreceive_bal) ? $sreceive_bal : 0);
        }

        $bank_balance = 0;
        $mobile_bank_balance = 0;
        $cash_balance = 0;
        $coa = $this->coa_parent_name_based_list('Cash At Bank');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $bank_bal = $query->predebit - $query->precredit;
            $bank_balance += (!empty($bank_bal) ? $bank_bal : 0);
        }

        $coa_mobile = $this->coa_parent_name_based_list('Cash At Mobile Bank');
        foreach ($coa_mobile as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $mobile_bank_bal = $query->predebit - $query->precredit;
            $mobile_bank_balance += (!empty($mobile_bank_bal) ? $mobile_bank_bal : 0);
        }

        $cash_other = $this->coa_parent_name_based_list('Cash & Cash Equivalent');
        foreach ($cash_other as $cashother) {
            $query = $this->coa_transaction($cashother->id,$warehouse_id);
            $cash_bal = $query->predebit - $query->precredit;
            $cash_balance += (!empty($cash_bal) ? $cash_bal : 0);
        }

        return $balance = $asset_balance + $loan_balance + $single_balance + $bank_balance + $mobile_bank_balance + $cash_balance;

    }

    public function total_non_current_asset_balance($warehouse_id=null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Non Current Assets');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $balance = $query->predebit - $query->precredit;
            $total += (!empty($balance) ? $balance : 0);
        }
        return $total;
    }

    public function total_equity_balance($warehouse_id=null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Equity');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $balance = $query->predebit - $query->precredit;
            $total += (!empty($balance) ? $balance : 0);
        }
        return $total;
    }

    public function total_expense_balance($warehouse_id=null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Expense');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $balance = $query->predebit - $query->precredit;
            $total += (!empty($balance) ? $balance : 0);
        }
        return $total;
    }

    public function total_income_balance($warehouse_id=null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Income');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $balance = $query->predebit - $query->precredit;
            $total += (!empty($balance) ? $balance : 0);
        }
        return $total;
    }

    public function total_acc_payable_balance($warehouse_id=null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Account Payable');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $balance = $query->predebit - $query->precredit;
            $total += (!empty($balance) ? $balance : 0);
        }
        return $total;
    }

    public function total_acc_employee_balance($warehouse_id=null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Employee Ledger');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $balance = $query->predebit - $query->precredit;
            $total += (!empty($balance) ? $balance : 0);
        }
        return $total;
    }

    public function total_acc_cruliabilities_balance($warehouse_id=null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Current Liabilities');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $balance = $query->predebit - $query->precredit;
            $total += (!empty($balance) ? $balance : 0);
        }
        return $total;
    }

    public function total_acc_no_curliability_balance($warehouse_id=null)
    {
        $total = 0;
        $coa = $this->coa_parent_name_based_list('Non Current Liabilities');
        foreach ($coa as $assetcoa) {
            $query = $this->coa_transaction($assetcoa->id,$warehouse_id);
            $balance = $query->predebit - $query->precredit;
            $total += (!empty($balance) ? $balance : 0);
        }
        return $total;
    }
    /*******************************
    * End :: COA Balance *
    ********************************/

}
