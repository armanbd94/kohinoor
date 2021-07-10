<?php

namespace Modules\Report\Http\Controllers;

use App\Models\Warehouse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\BaseController;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\Report\Entities\ProductCouponReport;

class ProductCouponReportController extends BaseController
{

    public function __construct(ProductCouponReport $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('product-coupon-report-access')){
            $this->setPageData('Product Coupon Report','Product Coupon Report','fas fa-file-signature',[['name' => 'Report'],['name' => 'Product Coupon Report']]);
            $finish_goods = FinishGood::with('product','size')->get();
            $warehouses = Warehouse::where('status',1)->get();

            // $report = DB::table('production_finished_goods as pfg')
            // ->selectRaw('pfg.finish_goods_id,p.product_name,s.size,u.unit_name,SUM(pfg.total_coupon) as total_coupon')
            // ->join('finish_goods as fg','pfg.finish_goods_id','=','fg.id')
            // ->join('products as p','fg.product_id','=','p.id')
            // ->join('sizes as s','fg.size_id','=','s.id')
            // ->join('units as u','s.unit_id','=','u.id')
            // ->groupBy('pfg.finish_goods_id')
            // ->where('pfg.total_coupon','<>',null)
            // ->get();


            // $total_used = [];
            // $total_unused = [];
            // $total_paid = [];

            // foreach ($report as $key => $value) {
            //     $total_used_data = DB::table('production_coupons as pc')
            //             ->selectRaw('COUNT(*) as total_used')
            //             ->join('production_finished_goods as pfg','pc.production_finished_good_id','=','pfg.id')
            //             ->where([['pfg.finish_goods_id',$value->finish_goods_id],['pc.status',1]])
            //             ->groupBy('pfg.finish_goods_id')
            //             ->first();
            //     $total_unused_data = DB::table('production_coupons as pc')
            //             ->selectRaw('COUNT(*) as total_used')
            //             ->join('production_finished_goods as pfg','pc.production_finished_good_id','=','pfg.id')
            //             ->where([['pfg.finish_goods_id',$value->finish_goods_id],['pc.status',2]])
            //             ->groupBy('pfg.finish_goods_id')
            //             ->first();
            //     $total_paid_data = DB::table('received_coupons as rc')
            //             ->selectRaw('SUM(rc.coupon_price) as total_paid')
            //             ->join('production_coupons as pc','rc.coupon_id','=','pc.id')
            //             ->join('production_finished_goods as pfg','pc.production_finished_good_id','=','pfg.id')
            //             ->where('pfg.finish_goods_id',$value->finish_goods_id)
            //             ->groupBy('pfg.finish_goods_id')
            //             ->first();
            //     array_push($total_used,$total_used_data ? $total_used_data->total_used : 0);
            //     array_push($total_unused,$total_unused_data ? $total_unused_data->total_used : 0);
            //     array_push($total_paid,$total_paid_data ? $total_paid_data->total_paid : 0);
                
            // }
            // dd($total_paid);

            return view('report::product-coupon-report.index',compact('finish_goods','warehouses'));
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){

            if (!empty($request->finish_goods_id)) {
                $this->model->setFinishGoodsID($request->finish_goods_id);
            }
            // if (!empty($request->start_date)) {
            //     $this->model->setStartDate($request->start_date);
            // }
            // if (!empty($request->end_date)) {
            //     $this->model->setEndDate($request->end_date);
            // }
            $this->set_datatable_default_properties($request);//set datatable default properties
            $list = $this->model->getDatatableList();//get table data
            $data = [];
            $no = $request->input('start');
            foreach ($list as $value) {
                $no++;
                $row = [];
                $row[] = $no;
                $row[] = $value->product_name.' '.$value->size.$value->unit_name;
                $row[] = $value->total_coupon;
                $row[] =$this->total_used_coupon($value->finish_goods_id);
                $row[] =$this->total_unused_coupon($value->finish_goods_id);
                $row[] = number_format($value->coupon_price,2);
                $row[] = number_format($this->total_coupon_price_paid($value->finish_goods_id),2);
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
            $this->model->count_filtered(), $data);
            
        }else{
            return response()->json($this->unauthorized());
        }
    }

    private function total_used_coupon($finish_goods_id)
    {
        $data = DB::table('production_coupons as pc')
                        ->selectRaw('COUNT(*) as total_used')
                        ->join('production_finished_goods as pfg','pc.production_finished_good_id','=','pfg.id')
                        ->where([['pfg.finish_goods_id',$finish_goods_id],['pc.status',1]])
                        ->groupBy('pfg.finish_goods_id')
                        ->first();
        return $data ? $data->total_used : 0;
    }
    private function total_unused_coupon($finish_goods_id)
    {
        $data = DB::table('production_coupons as pc')
                        ->selectRaw('COUNT(*) as total_unused')
                        ->join('production_finished_goods as pfg','pc.production_finished_good_id','=','pfg.id')
                        ->where([['pfg.finish_goods_id',$finish_goods_id],['pc.status',2]])
                        ->groupBy('pfg.finish_goods_id')
                        ->first();
        return $data ? $data->total_unused : 0;
    }

    private function total_coupon_price_paid($finish_goods_id)
    {
        $data = DB::table('received_coupons as rc')
                ->selectRaw('SUM(rc.coupon_price) as total_paid')
                ->join('production_coupons as pc','rc.coupon_id','=','pc.id')
                ->join('production_finished_goods as pfg','pc.production_finished_good_id','=','pfg.id')
                ->where('pfg.finish_goods_id',$finish_goods_id)
                ->groupBy('pfg.finish_goods_id')
                ->first();
        return $data ? $data->total_paid : 0;
    }


}
