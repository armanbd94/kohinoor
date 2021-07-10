<?php

namespace Modules\Report\Entities;

use App\Models\BaseModel;
use Illuminate\Support\Facades\DB;

class ProductCouponReport extends BaseModel
{
    protected $table = 'production_finished_goods';
    protected $fillable = ['sale_id', 'finish_goods_id', 'qty', 'sale_unit_id', 'net_unit_price', 'discount', 'tax_rate', 'tax', 'total'];

    protected $order = ['pfg.finish_goods_id' => 'asc'];
     /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $_finish_goods_id; 
    // protected $_start_date; 
    // protected $_end_date; 

    //methods to set custom search property value
    public function setFinishGoodsID($finish_goods_id)
    {
        $this->_finish_goods_id = $finish_goods_id;
    }
    // public function setStartDate($start_date)
    // {
    //     $this->_start_date = $start_date;
    // }
    // public function setEndDate($end_date)
    // {
    //     $this->_end_date = $end_date;
    // }

    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)

        $this->column_order = ['id',null,null,null,null,null,null,null,null,null];
        
        $warehouse_id = $this->_warehouse_id;
        $query = DB::table('production_finished_goods as pfg')
        ->selectRaw('pfg.finish_goods_id,pfg.coupon_price,p.product_name,s.size,u.unit_name,SUM(pfg.total_coupon) as total_coupon')
        ->join('finish_goods as fg','pfg.finish_goods_id','=','fg.id')
        ->join('products as p','fg.product_id','=','p.id')
        ->join('sizes as s','fg.size_id','=','s.id')
        ->join('units as u','s.unit_id','=','u.id')
        ->groupBy('pfg.finish_goods_id')
        ->where('pfg.total_coupon','<>',null);

        //search query
        if (!empty($this->_finish_goods_id)) {
            $query->where('pfg.finish_goods_id', $this->_finish_goods_id);
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
        return  DB::table('production_finished_goods as pfg')
        ->selectRaw('pfg.finish_goods_id,p.product_name,s.size,u.unit_name,SUM(pfg.total_coupon) as total_coupon')
        ->join('finish_goods as fg','pfg.finish_goods_id','=','fg.id')
        ->join('products as p','fg.product_id','=','p.id')
        ->join('sizes as s','fg.size_id','=','s.id')
        ->join('units as u','s.unit_id','=','u.id')
        ->groupBy('pfg.finish_goods_id')
        ->where('pfg.total_coupon','<>',null)->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/
}
