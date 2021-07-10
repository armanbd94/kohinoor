<?php

namespace Modules\ASM\Http\Controllers\Report;

use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\ASM\Entities\TodaysCustomerReceipt;

class TodaysCustomerReceiptController extends BaseController
{
    public function __construct(TodaysCustomerReceipt $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Todays Customer Received','Todays Customer Received','fas fa-file-signature',[['name' => 'Report'],['name' => 'Todays Customer Received']]);
        return view('asm::report.todays-customer-receipt.index');
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            $this->set_datatable_default_properties($request);//set datatable default properties
            $list = $this->model->getDatatableList();//get table data
            $data = [];
            $no = $request->input('start');
            foreach ($list as $value) {
                $no++;
                $row = [];
                $row[] = $no;
                $row[] = $value->customer_name.' ( '.$value->shop_name.')';
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
