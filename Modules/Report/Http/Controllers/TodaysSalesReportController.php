<?php

namespace Modules\Report\Http\Controllers;

use App\Models\Warehouse;
use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\Report\Entities\TodaysSalesReport;

class TodaysSalesReportController extends BaseController
{

    public function __construct(TodaysSalesReport $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('todays-sales-report-access')){
            $this->setPageData('Todays Sales Report','Todays Sales Report','fas fa-file-signature',[['name' => 'Report','link'=>'javascript::void();'],['name' => 'Todays Sales Report']]);
            $warehouses = Warehouse::where('status',1)->get();
            return view('report::todays-sales-report.index',compact('warehouses'));
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if (!empty($request->warehouse_id)) {
                $this->model->setWarehouseID($request->warehouse_id);
            }
            $this->set_datatable_default_properties($request);//set datatable default properties
            $list = $this->model->getDatatableList();//get table data
            $data = [];
            $no = $request->input('start');
            foreach ($list as $value) {
                $no++;
                $row = [];
                $row[] = $no;
                $row[] = $value->warehouse->name;
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
