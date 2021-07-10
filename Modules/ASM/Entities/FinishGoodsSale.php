<?php

namespace Modules\ASM\Entities;

use App\Models\Unit;
use App\Models\BaseModel;
use Illuminate\Support\Facades\Auth;
use Modules\FinishGoods\Entities\FinishGood;

class FinishGoodsSale extends BaseModel
{
    protected $table = 'finish_goods_sales';
    protected $fillable = ['sale_id', 'finish_goods_id', 'qty', 'sale_unit_id', 'net_unit_price', 'discount', 'tax_rate', 'tax', 'total'];

    public function sale()
    {
        return $this->belongsTo(Sale::class);
    }
    public function finish_goods()
    {
        return $this->belongsTo(FinishGood::class,'finish_goods_id','id');
    }
    public function sale_unit()
    {
        return $this->belongsTo(Unit::class,'sale_unit_id','id');
    }
     /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $_finish_goods_id; 
    protected $_start_date; 
    protected $_end_date; 

    //methods to set custom search property value
    public function setFinishGoodsID($finish_goods_id)
    {
        $this->_finish_goods_id = $finish_goods_id;
    }
    public function setStartDate($start_date)
    {
        $this->_start_date = $start_date;
    }
    public function setEndDate($end_date)
    {
        $this->_end_date = $end_date;
    }

    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)

        $this->column_order = ['id',null,null,null,null,null,null,null,null];
        
        
        $query = self::with('sale','finish_goods','sale_unit')
        ->whereHas('sale',function($q){
            $q->where([
                ['warehouse_id',Auth::guard('asm')->user()->warehouse_id],
                ['asm_id',Auth::guard('asm')->user()->id],
            ]);
        });

        //search query
        if (!empty($this->_finish_goods_id)) {
            $query->where('finish_goods_id', $this->_finish_goods_id);
        }
        if (!empty($this->_start_date)) {
            $start_date = $this->_start_date;
            $query->whereHas('sale',function($q) use ($start_date){
                $q->where('sale_date', '>=',$start_date);
            });
        }
        if (!empty($this->_end_date)) {
            $end_date = $this->_end_date;
            $query->whereHas('sale',function($q) use ($end_date){
                $q->where('sale_date', '<=',$end_date);
            });
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
        return  self::with('sale','finish_goods','sale_unit')
        ->whereHas('sale',function($q){
            $q->where([
                ['warehouse_id',Auth::guard('asm')->user()->warehouse_id],
                ['asm_id',Auth::guard('asm')->user()->id],
            ]);
        })->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/
}
