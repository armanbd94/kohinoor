<?php

namespace Modules\ASM\Http\Controllers\Accounts;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\BaseController;
use Illuminate\Support\Facades\Auth;
use Modules\Account\Entities\Transaction;
use Modules\Account\Entities\ChartOfAccount;
use Modules\ASM\Http\Requests\OpeningBalanceFormRequest;


class OpeningBalanceController extends BaseController
{
    
    public function __construct(Transaction $model)
    {
        parent::__construct($model);
    }

    public function index()
    {

        $this->setPageData('Opening Balance','Opening Balance','far fa-money-bill-alt',[['name'=>'Accounts'],['name'=>'Opening Balance']]);
        $coas = ChartOfAccount::toBase()->where([['status',1],['supplier_id',null],['customer_id',null]])
        ->orderBy('id','asc')->get();
        $voucher_no = 'OP-'.date('YmdHis').rand(1,999);
        return view('asm::account.opening-balance.index',compact('coas','voucher_no',));

    }

    public function store(OpeningBalanceFormRequest $request)
    {
        if($request->ajax()){
            DB::beginTransaction();
            try {
                $data = array(
                    'warehouse_id'        => Auth::guard('asm')->user()->warehouse_id,
                    'chart_of_account_id' => $request->chart_of_account_id,
                    'voucher_no'          => $request->voucher_no,
                    'voucher_type'        => 'Opening',
                    'voucher_date'        => $request->voucher_date,
                    'description'         => $request->remarks,
                    'debit'               => $request->amount,
                    'credit'              => 0,
                    'is_opening'          => 1,
                    'posted'              => 1,
                    'approve'             => 1,
                    'created_by'          => auth()->user()->name,
                    'created_at'          => date('Y-m-d H:i:s')
                );
                $result = $this->model->create($data);
                $output = $this->store_message($result, null);
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
}
