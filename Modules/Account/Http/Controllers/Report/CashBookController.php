<?php

namespace Modules\Account\Http\Controllers\Report;

use App\Models\Warehouse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\BaseController;
use Modules\Account\Entities\Transaction;

class CashBookController extends BaseController
{
    public function __construct(Transaction $model)
    {
        parent::__construct($model);
    }


    public function index()
    {
        if(permission('cash-book-access')){
            $this->setPageData('Cash Book','Cash Book','far fa-money-bill-alt',[['name'=>'Accounts'],['name'=>'Report'],['name'=>'Cash Book']]);
            $warehouses = Warehouse::where('status',1)->get();
            return view('account::report.cash-book.index',compact('warehouses'));
        }else{
            return $this->access_blocked();
        }
    }

    public function report(Request $request)
    {
        if ($request->ajax()) {
            $start_date = $request->start_date ? $request->start_date : date('Y-m-d');
            $end_date   = $request->end_date ? $request->end_date : date('Y-m-d');
            $warehouse_id = $request->warehouse_id;

            $previous_balance = 0;
            $cash_in_hand_acc_id = DB::table('chart_of_accounts')->where('code', $this->coa_head_code('cash_in_hand'))->value('id');
            $previous_balance_data = DB::table('transactions')
                                        ->selectRaw('SUM(debit) as debit, SUM(credit) as credit,approve')
                                        ->where([['voucher_date','<',$start_date],['chart_of_account_id',$cash_in_hand_acc_id]]);

            $report_data = DB::table('transactions as t')
                            ->selectRaw('t.id,t.warehouse_id,t.voucher_no, t.voucher_type, t.voucher_date, 
                            t.debit, t.credit, t.approve, t.chart_of_account_id, coa.name as account_name, coa.parent_name, coa.type, t.description,w.name as warehouse_name')
                            ->leftJoin('chart_of_accounts as coa','t.chart_of_account_id','=','coa.id')
                            ->leftJoin('warehouses as w','t.warehouse_id','=','w.id')
                            ->whereDate('t.voucher_date','>=',$start_date)
                            ->whereDate('t.voucher_date','<=',$end_date)
                            ->where('t.chart_of_account_id',$cash_in_hand_acc_id)
                            ->where('t.approve',1);

            if($warehouse_id != 0){
                $previous_balance_data->where('warehouse_id',$warehouse_id);
                $report_data->where('t.warehouse_id',$warehouse_id);
            }
            $previous_balance_data = $previous_balance_data->groupBy('chart_of_account_id','approve')->first();
            $report_data = $report_data->groupBy('t.voucher_no', 't.voucher_type', 't.voucher_date', 't.approve', 't.chart_of_account_id')
                                    ->havingRaw('SUM(t.debit)-SUM(t.credit) <> 0')
                                    ->orderBy('t.voucher_date','asc')
                                    ->orderBy('t.voucher_no','asc')
                                    ->get();

            if($previous_balance_data)
            {

                $previous_balance = $previous_balance_data->credit - $previous_balance_data->debit;
            }
            

            return view('account::report.cash-book.report',compact('start_date','end_date','previous_balance','report_data'))->render();
            
        }
    }
}
