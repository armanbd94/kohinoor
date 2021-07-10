<?php

namespace Modules\ASM\Http\Controllers\Report;

use Illuminate\Http\Request;
use Modules\ASM\Entities\DueReport;
use App\Http\Controllers\BaseController;

class DueReportController extends BaseController
{
    public function __construct(DueReport $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Due Report','Due Report','fas fa-file-signature',[['name' => 'Report'],['name' => 'Due Report']]);
        return view('asm::report.due-report.index');
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
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
                $row[] = date(config('settings.date_format',strtotime($value->sale_date)));
                $row[] = $value->memo_no;
                $row[] = $value->name.' ('.$value->shop_name.')';
                $row[] = number_format(($value->grand_total),2, '.', ',');
                $row[] = number_format(($value->previous_due),2, '.', ',');
                $row[] = number_format(($value->paid_amount),2, '.', ',');
                $row[] = number_format(($value->due_amount),2, '.', ',');
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
            $this->model->count_filtered(), $data);
            
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
