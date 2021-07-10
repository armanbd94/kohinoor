<?php

namespace Modules\Report\Http\Controllers;

use App\Models\Warehouse;
use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\Report\Entities\TodaysCustomerReceipt;

class TodaysCustomerReceiptController extends BaseController
{
    public function __construct(TodaysCustomerReceipt $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('todays-customer-receipt-access')){
            $this->setPageData('Todays Customer Received','Todays Customer Received','fas fa-file-signature',[['name' => 'Report','link'=>'javascript::void();'],['name' => 'Todays Customer Received']]);
            $warehouses = Warehouse::where('status',1)->get();
            return view('report::todays-customer-receipt.index',compact('warehouses'));
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
                $row[] = $value->customer_name.' ( '.$value->shop_name.')';
                $row[] = $value->district_name;
                $row[] = $value->upazila_name;
                $row[] = $value->route_name;
                $row[] = $value->description;
                $row[] = number_format($value->credit,2);
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
            $this->model->count_filtered(), $data);
            
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
