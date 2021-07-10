<?php

namespace Modules\ASM\Http\Controllers;

use Illuminate\Http\Request;
use Modules\ASM\Entities\Inventory;
use App\Http\Controllers\BaseController;
use Modules\FinishGoods\Entities\FinishGood;

class InventoryController extends BaseController
{
    public function __construct(Inventory $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Inventory','Inventory','fas fa-boxes',[['name'=>'Inventory']]);
        $finish_goods = FinishGood::with('product','size','unit')->get();
        return view('asm::inventory.index',compact('finish_goods'));
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if (!empty($request->finish_goods_id)) {
                $this->model->setFinishGoodsID($request->finish_goods_id);
            }
            $this->set_datatable_default_properties($request);//set datatable default properties
            $list = $this->model->getDatatableList();//get table data
            $data = [];
            $no = $request->input('start');
            foreach ($list as $value) {
                $no++;

                $row       = [];
                $row []    = $no;
                $row []    = $value->product->product_name;
                $row []    = $value->finish_goods->size->size.$value->finish_goods->size->unit->unit_name;
                $row []    = $value->qty;
                $row []    = $value->finish_goods->unit->unit_name;
                $row []    = $value->finish_goods->sale_unit->unit_name;
                $row []    = number_format($value->finish_goods->price,2);
                $row []    = STOCK_STATUS_LABEL[$value->qty > 0 ? 1 : 2];
                $data[]    = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
             $this->model->count_filtered(), $data);
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
