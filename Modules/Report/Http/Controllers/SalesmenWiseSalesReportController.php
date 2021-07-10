<?php

namespace Modules\Report\Http\Controllers;

use App\Models\Salesmen;
use App\Models\Warehouse;
use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\Report\Entities\SalesmenWiseSalesReport;

class SalesmenWiseSalesReportController extends BaseController
{
    public function __construct(SalesmenWiseSalesReport $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('salesmen-wise-sales-report-access')){
            $this->setPageData('Salesmen Wise Sales Report','Salesmen Wise Sales Report','fas fa-file-signature',[['name' => 'Report'],['name' => 'Salesmen Wise Sales Report']]);
            $salesmen = Salesmen::with('district','upazila')->where(['status'=>1])->get();
            $warehouses = Warehouse::where('status',1)->get();
            return view('report::salesmen-wise-sales-report.index',compact('salesmen','warehouses'));
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
                $row[] = $value->warehouse_name;
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
