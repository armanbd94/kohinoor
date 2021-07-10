<?php

namespace Modules\ASM\Http\Controllers\Report;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Modules\ASM\Entities\SalesPerson;
use App\Http\Controllers\BaseController;
use Modules\ASM\Entities\SalesmenWiseSalesReport;

class SalesmenWiseSalesReportController extends BaseController
{
    public function __construct(SalesmenWiseSalesReport $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Salesmen Wise Sales Report','Salesmen Wise Sales Report','fas fa-file-signature',[['name' => 'Report'],['name' => 'Salesmen Wise Sales Report']]);
        $salesmen = SalesPerson::where(['asm_id' => Auth::guard('asm')->user()->id,'status'=>1])->get();
        return view('asm::report.salesmen-wise-sales-report.index',compact('salesmen'));
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if (!empty($request->salesmen_id)) {
                $this->model->setSalesmenID($request->salesmen_id);
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
            $no = $request->input('start');
            foreach ($list as $value) {
                $no++;
                $row = [];
                $row[] = $no;
                $row[] = $value->name.' ( '.$value->phone.')';
                $row[] = $value->total_invoice;
                $row[] = number_format($value->total_amount,2);
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
            $this->model->count_filtered(), $data);
            
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
