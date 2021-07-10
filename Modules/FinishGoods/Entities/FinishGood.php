<?php

namespace Modules\FinishGoods\Entities;

use App\Models\BaseModel;
use App\Models\Unit;

class FinishGood extends BaseModel
{
    protected $table = 'finish_goods';
    protected $fillable = ['product_id', 'size_id', 'code', 'unit_id', 'sale_unit_id', 'cost', 'price', 'qty',
     'opening_stock_qty', 'alert_qty', 'status', 'created_by', 'modified_by'];

    public function product()
    {
        return $this->belongsTo(\Modules\Product\Entities\Product::class,'product_id','id');
    }
    public function size()
    {
        return $this->belongsTo(\Modules\Product\Entities\Size::class,'size_id','id');
    }
    public function unit()
    {
        return $this->belongsTo(Unit::class,'unit_id','id');
    }
    public function sale_unit()
    {
        return $this->belongsTo(Unit::class,'sale_unit_id','id');
    }

    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $product_id; 
    protected $size_id;
    protected $code;
    protected $type; 
    protected $status; 

    //methods to set custom search property value
    public function setProductID($product_id)
    {
        $this->product_id = $product_id;
    }
    public function setSizeID($size_id)
    {
        $this->size_id = $size_id;
    }
    public function setCode($code)
    {
        $this->code = $code;
    }
    public function setType($type)
    {
        $this->type = $type;
    }
    public function setStatus($status)
    {
        $this->status = $status;
    }


    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)
        if (permission('inventory-bulk-delete')){
            $this->column_order = [null,'id','id','product_id','size_id','code','type','cost','price','unit_id','sale_unit_id','qty','alert_qty','status',null];
        }else{
            $this->column_order = ['id','id','product_id','size_id','code','type','cost','price', 'unit_id','sale_unit_id','qty','alert_qty', 'status',null];
        }
        
        $query = self::with('product','size','unit','sale_unit');

        //search query
        if (!empty($this->product_id)) {
            $query->where('product_id', $this->product_id);
        }
        if (!empty($this->size_id)) {
            $query->where('size_id', $this->size_id);
        }
        if (!empty($this->code)) {
            $query->where('code', 'like', '%' . $this->code . '%');
        }
        if (!empty($this->type)) {
            $query->where('type', $this->type);
        }
        if (!empty($this->status)) {
            $query->where('status', $this->status);
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
        return self::toBase()->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/
    
}
