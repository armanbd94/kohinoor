<?php

namespace Modules\Report\Http\Controllers;

use App\Models\Warehouse;
use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\Report\Entities\WarehouseReport;

class WarehouseReportController extends BaseController
{
    public function __construct(WarehouseReport $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('warehouse-report-access')){
            $this->setPageData('Warehouse Report','Warehouse Report','fas fa-industry',[['name' => 'Warehouse Report']]);
            $warehouses = Warehouse::where('status',1)->get();
            $finished_goods = FinishGood::with('product','size')->get();
            return view('report::warehouse-report.index',compact('warehouses','finished_goods'));
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('production-report-access')){

                if (!empty($request->finish_goods_id)) {
                    $this->model->setFinishGoodsID($request->finish_goods_id);
                }
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
                    $row[] = $value->product_name;
                    $row[] = $value->size.' '.$value->size_unit;
                    $row[] = $value->code;
                    $row[] = PRODUCT_TYPE[$value->type];
                    $row[] = $value->stock_unit;
                    $row[] = $value->qty ? number_format($value->qty,2,'.',',') : 0;
                    $row[] = $value->alert_qty ? number_format($value->alert_qty,2,'.',',') : 0;
                    $data[] = $row;
                }
                return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
                $this->model->count_filtered(), $data);
            }
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
