<?php

namespace Modules\ASM\Http\Controllers\Report;

use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\ASM\Entities\FinishGoodsSale;
use Modules\FinishGoods\Entities\FinishGood;

class ProductWiseSalesReportController extends BaseController
{
    public function __construct(FinishGoodsSale $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Product Wise Sales Report','Product Wise Sales Report','fas fa-file-signature',[['name' => 'Report'],['name' => 'Product Wise Sales Report']]);
        $finish_goods = FinishGood::with('product','size')->get();
        return view('asm::report.product-wise-sales-report.index',compact('finish_goods'));
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
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
                $row[] = $value->sale->sale_date;
                $row[] = $value->finish_goods->product->product_name;
                $row[] = $value->finish_goods->size->size.$value->finish_goods->size->unit->unit_name;
                $row[] = $value->sale->memo_no;
                $row[] = $value->sale->customer->name;
                $row[] = $value->qty.' '.$value->sale_unit->unit_name;
                $row[] = number_format($value->net_unit_price,2);
                $row[] = number_format($value->total,2);
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
            $this->model->count_filtered(), $data);
            
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
