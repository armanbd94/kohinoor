<?php

namespace Modules\ASM\Http\Controllers;

use Illuminate\Http\Request;
use Modules\ASM\Entities\Route;
use Modules\ASM\Entities\Upazila;
use Modules\ASM\Entities\Customer;
use Illuminate\Support\Facades\Auth;
use Modules\ASM\Entities\SalesPerson;
use App\Http\Controllers\BaseController;
use Modules\ASM\Entities\ReceivedCoupon;

class ReceivedCouponController extends BaseController
{
    public function __construct(ReceivedCoupon $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Received Coupon','Received Coupon','fas fa-qrcode',[['name'=>'Received Coupon']]);
        $data = [
            'salesmen'   => SalesPerson::where('asm_id', Auth::guard('asm')->user()->id )->get(),
            'customers'  => Customer::where('district_id',Auth::guard('asm')->user()->district_id)->get(),
            'upazilas'   => Upazila::where('parent_id',Auth::guard('asm')->user()->district_id)->get(),
            'routes'     => Route::where('grand_parent_id',Auth::guard('asm')->user()->district_id)->get(),
        ];
        return view('asm::coupon.index',$data);
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
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
                $row []    = $value->customer->shop_name.' - '.$value->customer->name;
                $row []    = $value->salesmen->name.' - '.$value->salesmen->phone;
                $row []    = $value->customer->upazila->name;
                $row []    = $value->customer->route->name;
                $row []    = date(config('settings.date_format'),strtotime($value->created_at));
                $row []    = number_format($value->coupon_price,2);
                $data[]    = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
             $this->model->count_filtered(), $data);
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
