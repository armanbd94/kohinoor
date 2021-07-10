<?php

namespace Modules\ReceivedCoupon\Http\Controllers;

use App\Models\Salesmen;
use Illuminate\Http\Request;
use Modules\Location\Entities\Route;
use Modules\Location\Entities\Upazila;
use Modules\Customer\Entities\Customer;
use Modules\Location\Entities\District;
use App\Http\Controllers\BaseController;
use Modules\ReceivedCoupon\Entities\ReceivedCoupon;

class ReceivedCouponController extends BaseController
{
    public function __construct(ReceivedCoupon $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('coupon-received-access')){
            $this->setPageData('Received Coupon','Received Coupon','fas fa-qrcode',[['name'=>'Received Coupon']]);
            $data = [
                'salesmen'   => Salesmen::where('status', 1)->get(),
                'customers'  => Customer::where('status', 1)->get(),
                'districts'  => District::where(['status'=>1,'parent_id'=>0])->get(),
                'upazilas'   => Upazila::where('status', 1)->get(),
                'routes'     => Route::where('status', 1)->get(),
            ];
            return view('receivedcoupon::index',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('coupon-received-access')){
                if (!empty($request->from_date)) {
                    $this->model->setFromDate($request->from_date);
                }
                if (!empty($request->to_date)) {
                    $this->model->setToDate($request->to_date);
                }
                if (!empty($request->salesmen_id)) {
                    $this->model->setSalesmenID($request->salesmen_id);
                }
                if (!empty($request->customer_id)) {
                    $this->model->setCustomerID($request->customer_id);
                }
                if (!empty($request->district_id)) {
                    $this->model->setDistrictID($request->district_id);
                }
                if (!empty($request->upazila_id)) {
                    $this->model->setUpazilaID($request->upazila_id);
                }
                if (!empty($request->route_id)) {
                    $this->model->setRouteID($request->route_id);
                }
                $this->set_datatable_default_properties($request);//set datatable default properties
                $list = $this->model->getDatatableList();//get table data
                $data = [];
                $no = $request->input('start');
                foreach ($list as $value) {
                    $no++;
                    $row       = [];
                    $row []    = $no;
                    $row []    = $value->coupon->coupon_code;
                    $row []    = $value->customer->name.' ( '.$value->customer->shop_name.')';
                    $row []    = $value->salesmen->name.' - '.$value->salesmen->phone;
                    $row []    = $value->customer->district->name;
                    $row []    = $value->customer->upazila->name;
                    $row []    = $value->customer->route->name;
                    $row []    = date(config('settings.date_format'),strtotime($value->created_at));
                    $row []    = number_format($value->coupon_price,2);
                    $data[]    = $row;
                }
                return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
                $this->model->count_filtered(), $data);
            }
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
