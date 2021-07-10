<?php

namespace Modules\Production\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\Production\Entities\ProductionFinishedGoods;

class ProductionFinishedController extends BaseController
{
    public function __construct(ProductionFinishedGoods $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('production-finished-access')){
            $this->setPageData('Production Manage','Production Manage','fas fa-industry',[['name' => 'Production Manage']]);
            $finished_goods = FinishGood::with('product','size')->get();
            return view('production::production-finished',compact('finished_goods'));
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('production-finished-access')){

                if (!empty($request->batch_no)) {
                    $this->model->setBatchNo($request->batch_no);
                }
                if (!empty($request->finish_goods_id)) {
                    $this->model->setFinishedGoodsID($request->finish_goods_id);
                }
               
                $this->set_datatable_default_properties($request);//set datatable default properties
                $list = $this->model->getDatatableList();//get table data
                $data = [];
                $no = $request->input('start');
                foreach ($list as $value) {
                    $no++;
                    $action = '';
                    if(permission('production-finished-view')){
                        $action .= ' <a class="dropdown-item view_data"  data-id="' . $value->id . '" data-name="' . $value->finished_goods->product->product_name.' '.$value->finished_goods->size->size.' '.$value->finished_goods->size->unit->unit_name . '">'.self::ACTION_BUTTON['View'].'</a>';
                    }
                    $row = [];
                    $row[] = $no;
                    $row[] = $value->batch_no;
                    $row[] = $value->finished_goods->product->product_name.' '.$value->finished_goods->size->size.' '.$value->finished_goods->size->unit->unit_name;
                    $row[] = $value->qty;
                    $row[] = $value->finished_goods->unit->unit_name;
                    $row[] = number_format(($value->direct_cost / $value->qty),2,'.',',');
                    $row[] = $value->total_coupon ? $value->total_coupon : 0;
                    $row[] = $value->coupon_price ? number_format($value->coupon_price,2,'.',',') : 0;
                    $row[] = $value->coupon_exp_date ? date(config('settings.date_format'),strtotime($value->coupon_exp_date)) : '';
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

    public function show(Request $request)
    {
        if($request->ajax())
        {
            $data = ProductionFinishedGoods::with('production','finished_goods','finished_goods_materials')->find($request->id);
            // dd($data);
            return view('production::finished-goods-details',compact('data'))->render();
        }
    }
}
