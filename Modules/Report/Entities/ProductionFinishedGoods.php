<?php

namespace Modules\Report\Entities;

use App\Models\BaseModel;
use Modules\Production\Entities\Production;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\Production\Entities\FinishedGoodsMaterial;


class ProductionFinishedGoods extends BaseModel
{
    protected $table    = 'production_finished_goods';
    
    protected $fillable = [ 'production_id', 'batch_no', 'finish_goods_id', 'qty', 'unit_id', 'direct_cost','total_coupon', 'coupon_price',
     'coupon_exp_date', 'status', 'created_by', 'modified_by'];

    public function finished_goods()
    {
        return $this->belongsTo(FinishGood::class,'finish_goods_id','id');
    }
    public function production()
    {
        return $this->belongsTo(Production::class,'production_id','id');
    }
    public function finished_goods_materials()
    {
        return $this->hasMany(FinishedGoodsMaterial::class,'production_finished_good_id','id');
    }


    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $_batchNo; 
    protected $_finishGoodsID; 
    protected $_start_date; 
    protected $_end_date; 


    //methods to set custom search property value
    public function setBatchNo($batchNo)
    {
        $this->_batchNo = $batchNo;
    }

    public function setFinishGoodsID($finishGoodsID)
    {
        $this->_finishGoodsID = $finishGoodsID;
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

        $this->column_order = ['id','batch_no', 'finish_goods_id', 'qty', null, null, null, 'total_coupon', 'coupon_price',
        'coupon_exp_date', null];
        
        
        $query = self::with('finished_goods','production')
        ->where('qty','<>',null);

        //search query
        if (!empty($this->_batchNo)) {
            $query->where('batch_no', 'like', '%' . $this->_batchNo . '%');
        }

        if (!empty($this->_finishGoodsID)) {
            $query->where('finish_goods_id', $this->_finishGoodsID);
        }
        if (!empty($this->_start_date)) {
            $start_date = $this->_start_date;
            $query->whereHas('production', function($q) use ($start_date){
                $q->where('start_date','>=',$start_date);
            });
        }
        if (!empty($this->_end_date)) {
            $end_date = $this->_end_date;
            $query->whereHas('production', function($q) use ($end_date){
                $q->where('start_date','<=',$end_date);
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
        return self::toBase()->where('qty','<>',null)->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/
}
