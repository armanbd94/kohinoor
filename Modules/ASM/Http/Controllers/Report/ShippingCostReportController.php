<?php

namespace Modules\ASM\Http\Controllers\Report;

use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\ASM\Entities\ShippingCostReport;

class ShippingCostReportController extends BaseController
{
    public function __construct(ShippingCostReport $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Shipping Cost Report','Shipping Cost Report','fas fa-file-signature',[['name' => 'Report'],['name' => 'Shipping Cost Report']]);
        return view('asm::report.shipping-cost-report.index');
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
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
                $row[] = date(config('settings.date_format',strtotime($value->sale_date)));
                $row[] = $value->memo_no;
                $row[] = $value->name.' ('.$value->shop_name.')';
                $row[] = number_format(($value->shipping_cost),2, '.', ',');
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
            $this->model->count_filtered(), $data);
            
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
