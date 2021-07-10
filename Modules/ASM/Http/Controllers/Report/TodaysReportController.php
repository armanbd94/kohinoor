<?php

namespace Modules\ASM\Http\Controllers\Report;

use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\ASM\Entities\TodaysSalesReport;

class TodaysReportController extends BaseController
{

    public function __construct(TodaysSalesReport $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Todays Sales Report','Todays Sales Report','fas fa-file-signature',[['name' => 'Report'],['name' => 'Todays Sales Report']]);
        return view('asm::report.todays-sales-report.index');
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            $this->set_datatable_default_properties($request);//set datatable default properties
            $list = $this->model->getDatatableList();//get table data
            $data = [];
            $no = $request->input('start');
            foreach ($list as $value) {
                $no++;
                $row = [];
                $row[] = $no;
                $row[] = date(config('settings.date_format',strtotime($value->sale_date)));
                $row[] = $value->salesmen->name;
                $row[] = $value->customer->name.' ( '.$value->customer->shop_name.')';
                $row[] = number_format($value->grand_total,2);
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
            $this->model->count_filtered(), $data);
            
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
