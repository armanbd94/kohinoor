<?php

namespace Modules\Report\Http\Controllers;

use App\Models\Warehouse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\BaseController;
use Modules\ReceivedCoupon\Entities\ReceivedCoupon;


class WarehouseCouponReportController extends BaseController
{
    public function __construct(ReceivedCoupon $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('warehouse-coupon-report-access')){
            $this->setPageData('Warehouse Coupon Report','Warehouse Coupon Report','far fa-money-bill-alt',[['name'=>'Accounts','link'=>'javascript::void(0);'],['name'=>'Report','link'=>'javascript::void(0);'],['name'=>'Warehouse Coupon Report']]);
            $warehouses = Warehouse::where('status',1)->get();
            return view('report::warehouse-coupon-report.index',compact('warehouses'));
        }else{
            return $this->access_blocked();
        }
    }

    public function report(Request $request)
    {
        if ($request->ajax()) {
            $start_date   = $request->start_date ? $request->start_date : date('Y-m-d');
            $end_date     = $request->end_date ? $request->end_date : date('Y-m-d');
            $warehouse_id = $request->warehouse_id;

            $report_data = DB::table('received_coupons as rc')
                            ->selectRaw('w.name,asms.warehouse_id,count(rc.id) as total_coupon,sum(rc.coupon_price) as total_price')
                            ->leftJoin('asms','rc.asm_id','=','asms.id')
                            ->leftJoin('warehouses as w','asms.warehouse_id','=','w.id')
                            ->groupBy('asms.warehouse_id')
                            ->whereDate('rc.created_at','>=',$start_date)
                            ->whereDate('rc.created_at','<=',$end_date);

            if($warehouse_id != 0){
                $report_data->where('asms.warehouse_id',$warehouse_id);
            }

            $report_data = $report_data->get();

            // dd($report_data);
            return view('report::warehouse-coupon-report.report',compact('start_date','end_date','report_data'))->render();
            
            
        }
    }
}
