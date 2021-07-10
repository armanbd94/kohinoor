<?php

namespace Modules\ASM\Entities;

use App\Models\BaseModel;
use App\Models\Warehouse;
use Illuminate\Support\Facades\Auth;
use Modules\Product\Entities\Product;
use Modules\FinishGoods\Entities\FinishGood;

class Inventory extends BaseModel
{
    protected $table = 'warehouse_finish_goods';
    protected $fillable = ['warehouse_id','product_id','finish_goods_id','qty','rack_no'];

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class,'warehouse_id','id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class,'product_id','id');
    }

    public function finish_goods()
    {
        return $this->belongsTo(FinishGood::class,'finish_goods_id','id');
    }

    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $_finish_goods_id; 

    //methods to set custom search property value
    public function setFinishGoodsID($_finish_goods_id)
    {
        $this->_finish_goods_id = $_finish_goods_id;
    }

    private function get_datatable_query()
    {

        $this->column_order = ['id','product_id','finish_goods_id',null.null.null.null.null];
        
        $query = self::with("product","finish_goods")->where('warehouse_id',Auth::guard('asm')->user()->warehouse_id);

        //search query
        if (!empty($this->_finish_goods_id)) {
            $query->where('finish_goods_id', $this->_finish_goods_id);
        }

        //order by data fetching code
        if (isset($this->orderValue) && isset($this->dirValue)) { //orderValue is the index number of table header and dirValue is asc or desc
            $query->orderBy($this->column_order[$this->orderValue], $this->dirValue); //fetch data order by matching column
        } else if (isset($this->order)) {
            $query->orderBy(key($this->order), $this->order[key($this->order)]);
        }
        return $query;
    }

    public function getDatatableList()
    {
        $query = $this->get_datatable_query();
        if ($this->lengthVlaue != -1) {
            $query->offset($this->startVlaue)->limit($this->lengthVlaue);
        }
        return $query->get();
    }

    public function count_filtered()
    {
        $query = $this->get_datatable_query();
        return $query->get()->count();
    }

    public function count_all()
    {
        return self::toBase()->where('warehouse_id',Auth::guard('asm')->user()->warehouse_id)->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/
}
