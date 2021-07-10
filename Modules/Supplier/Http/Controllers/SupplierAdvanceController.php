<?php

namespace Modules\Supplier\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Supplier\Entities\Supplier;
use App\Http\Controllers\BaseController;
use Modules\Supplier\Entities\SupplierAdvance;
use Modules\Supplier\Http\Requests\SupplierAdvanceFormRequest;

class SupplierAdvanceController extends BaseController
{
    public function __construct(SupplierAdvance $model)
    {
        parent::__construct($model);
    }


    public function index()
    {
        if(permission('supplier-advance-access')){
            $this->setPageData('Supplier Advance','Supplier Advance','fas fa-hand-holding-usd',[['name'=>'Supplier','link'=>route('supplier')],['name'=>'Supplier Advance']]);
            $suppliers = Supplier::with('coa')->where(['status'=>1])->orderBy('name','asc')->get();
            return view('supplier::advance.index',compact('suppliers'));
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('supplier-advance-access')){

                if (!empty($request->supplier_id)) {
                    $this->model->setSupplierID($request->supplier_id);
                }
                if (!empty($request->type)) {
                    $this->model->setType($request->type);
                }

                $this->set_datatable_default_properties($request);//set datatable default properties
                $list = $this->model->getDatatableList();//get table data
                $data = [];
                $no = $request->input('start');
                foreach ($list as $value) {
                    $no++;
                    $action = '';
                    if(permission('supplier-advance-edit')){
                        $action .= ' <a class="dropdown-item edit_data" data-id="' . $value->id . '">'.self::ACTION_BUTTON['Edit'].'</a>';
                    }
                    if(permission('supplier-advance-delete')){
                        $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->voucher_no . '" data-name="' . $value->name . ' advance ">'.self::ACTION_BUTTON['Delete'].'</a>';
                    }

                    $row = [];
                    if(permission('supplier-advance-bulk-delete')){
                        $row[] = row_checkbox($value->voucher_no);
                    }
                    $row[] = $no;
                    $row[] = $value->name.' - '.$value->mobile;
                    $row[] = ($value->debit != 0) ? 'Payment' : 'Receive' ;
                    $row[] = ($value->debit != 0) ? $value->debit : $value->credit;
                    $row[] = date(config('settings.date_format'),strtotime($value->created_at));
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

    public function store_or_update_data(SupplierAdvanceFormRequest $request)
    {
        if($request->ajax()){
            if(permission('supplier-advance-add')){
                DB::beginTransaction();
                try {
                    if(empty($request->id)){
                        $result = $this->advance_add($request->type,$request->amount,$request->supplier_coaid,$request->supplier_name);
                        $output = $this->store_message($result, $request->id);
                    }else{
                        $result = $this->advance_update($request->id,$request->type,$request->amount,$request->supplier_coaid,$request->supplier_name);
                        $output = $this->store_message($result, $request->id);
                    }
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollBack();
                    $output = ['status' => 'error','message' => $e->getMessage()];
                }
            }else{
                $output = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    private function advance_add(string $type, $amount, int $supplier_coa_id, string $supplier_name) {
        if(!empty($type) && !empty($amount) && !empty($supplier_coa_id) && !empty($supplier_name)){
            $transaction_id = generator(10);

            $supplier_accledger = array(
                'warehouse_id' => 1,
                'chart_of_account_id' => $supplier_coa_id,
                'voucher_no'          => $transaction_id,
                'voucher_type'        => 'Advance',
                'voucher_date'        => date("Y-m-d"),
                'description'         => 'Supplier Advance For '.$supplier_name,
                'debit'               => ($type == 'debit') ? $amount : 0,
                'credit'              => ($type == 'credit') ? $amount : 0,
                'posted'              => 1,
                'approve'             => 1,
                'created_by'          => auth()->user()->name,
                'created_at'          => date('Y-m-d H:i:s')
            );
            $cc = array(
                'warehouse_id' => 1,
                'chart_of_account_id' => DB::table('chart_of_accounts')->where('code', $this->coa_head_code('cash_in_hand'))->value('id'),
                'voucher_no'          => $transaction_id,
                'voucher_type'        => 'Advance',
                'voucher_date'        => date("Y-m-d"),
                'description'         => 'Cash in Hand For '.$supplier_name,
                'debit'               => ($type == 'debit') ? $amount : 0,
                'credit'              => ($type == 'credit') ? $amount : 0,
                'posted'              => 1,
                'approve'             => 1,
                'created_by'          => auth()->user()->name,
                'created_at'          => date('Y-m-d H:i:s')
            ); 

            return $this->model->insert([
                $supplier_accledger,$cc
            ]);
        }
    }

    private function advance_update(int $transaction_id, string $type, $amount, int $supplier_coa_id, string $supplier_name) {
        if(!empty($type) && !empty($amount) && !empty($supplier_coa_id) && !empty($supplier_name)){

            $supplier_advance_data = $this->model->find($transaction_id);

            $voucher_no = $supplier_advance_data->voucher_no;

            $updated = $supplier_advance_data->update([
                'description'         => 'Supplier Advance For '.$supplier_name,
                'debit'               => ($type == 'debit') ? $amount : 0,
                'credit'              => ($type == 'credit') ? $amount : 0,
                'modified_by'         => auth()->user()->name,
                'updated_at'          => date('Y-m-d H:i:s')
            ]);
            if($updated)
            {
                $this->model->where([
                    'chart_of_account_id' => DB::table('chart_of_accounts')->where('code', $this->coa_head_code('cash_in_hand'))->value('id'), 
                    'voucher_no'=> $voucher_no])
                    ->update([
                        'description'         => 'Cash in Hand For '.$supplier_name,
                        'debit'               => ($type == 'debit') ? $amount : 0,
                        'credit'              => ($type == 'credit') ? $amount : 0,
                        'modified_by'         => auth()->user()->name,
                        'updated_at'          => date('Y-m-d H:i:s')
                    ]);
                return true;
            }else{
                return false;
            }
           
        }
    }

    public function edit(Request $request)
    {
        if($request->ajax()){
            if(permission('supplier-advance-edit')){
                $data   = $this->model->select('transactions.*','coa.id as coa_id','coa.code','s.id as supplier_id','s.name','s.mobile')->join('chart_of_accounts as coa','transactions.chart_of_account_id','=','coa.id')
                ->join('suppliers as s','coa.supplier_id','s.id')->where('transactions.id',$request->id)->first();

                $output = []; //if data found then it will return data otherwise return error message
                if($data){
                    $output = [
                        'id'          => $data->id,
                        'supplier_id' => $data->supplier_id,
                        'type'        => ($data->debit != 0) ? 'debit' : 'credit',
                        'amount'      => ($data->debit != 0) ? $data->debit : $data->credit,
                    ];
                }
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
            if(permission('supplier-advance-delete')){
                $result   = $this->model->where('voucher_no',$request->id)->delete();
                $output   = $this->delete_message($result);
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function bulk_delete(Request $request)
    {
        if($request->ajax()){
            if(permission('supplier-advance-bulk-delete')){
                $result   = $this->model->whereIn('voucher_no',$request->ids)->delete();
                $output   = $this->bulk_delete_message($result);
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

}
