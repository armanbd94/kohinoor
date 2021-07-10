<?php

namespace Modules\Report\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\Report\Entities\ProductionFinishedGoods;

class ProductionReportController extends BaseController
{
    public function __construct(ProductionFinishedGoods $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('production-report-access')){
            $this->setPageData('Production Report','Production Report','fas fa-industry',[['name' => 'Production Report']]);
            $finished_goods = FinishGood::with('product','size')->get();
            return view('report::production-report.index',compact('finished_goods'));
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('production-report-access')){

                if (!empty($request->batch_no)) {
                    $this->model->setBatchNo($request->batch_no);
                }
                if (!empty($request->finish_goods_id)) {
                    $this->model->setFinishGoodsID($request->finish_goods_id);
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
                    $row[] = $value->batch_no;
                    $row[] = $value->finished_goods->product->product_name.' '.$value->finished_goods->size->size.' '.$value->finished_goods->size->unit->unit_name;
                    $row[] = $value->qty;
                    $row[] = $value->finished_goods->unit->unit_name;
                    $row[] = number_format(($value->direct_cost / $value->qty),2,'.',',');
                    $row[] = number_format($value->direct_cost,2,'.',',');
                    $row[] = $value->total_coupon ? $value->total_coupon : 0;
                    $row[] = $value->coupon_price ? number_format($value->coupon_price,2,'.',',') : 0;
                    $row[] = $value->coupon_exp_date ? date(config('settings.date_format'),strtotime($value->coupon_exp_date)) : '';
                    $row[] = $value->production->start_date ? date(config('settings.date_format'),strtotime($value->production->start_date)) : '';
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
