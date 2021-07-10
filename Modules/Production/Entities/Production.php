<?php

namespace Modules\Production\Entities;

use App\Models\BaseModel;


class Production extends BaseModel
{
    protected $fillable = ['batch_no', 'warehouse_id', 'start_date', 'end_date', 'product_id', 'mfg_date', 'exp_date',
    'product_return_qty', 'production_status', 'material_delivered_status', 'material_received_status', 'description',
     'status', 'created_by', 'modified_by', 'material_delivered_by', 'material_delivered_datetime', 'material_received_by', 'material_received_datetime'
    ];

    public function product()
    {
        return $this->belongsTo(\Modules\Product\Entities\Product::class);
    }
    public function warehouse()
    {
        return $this->belongsTo(\App\Models\Warehouse::class);
    }
    
    public function production_materials()
    {
        return $this->belongsToMany(\Modules\Material\Entities\Material::class,'production_materials','production_id','material_id','id','id')
        ->withTimestamps()->withPivot('batch_no', 'required_qty', 'received_qty', 'used_qty', 'damaged_qty');
    }

    public function production_finished_goods(){
        return $this->belongsToMany(\Modules\FinishGoods\Entities\FinishGood::class,'production_finished_goods','production_id','finish_goods_id','id','id')
                    ->withTimestamps()->withPivot('id','batch_no', 'qty', 'unit_id', 'direct_cost','total_coupon', 'coupon_price',
                    'coupon_exp_date', 'status', 'created_by', 'modified_by');
    }

     /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $batch_no; 
    protected $start_date; 
    protected $end_date; 
    protected $product_id; 
    protected $production_status; 
    protected $material_delivered_status; 
    protected $material_received_status; 

    //methods to set custom search property value
    public function setBatchNo($batch_no)
    {
        $this->batch_no = $batch_no;
    }

    public function setStartDate($start_date)
    {
        $this->start_date = $start_date;
    }
    public function setEndDate($end_date)
    {
        $this->end_date = $end_date;
    }
    public function setProductID($product_id)
    {
        $this->product_id = $product_id;
    }
    public function setProductionStatus($production_status)
    {
        $this->production_status = $production_status;
    }
    public function setMaterialDeliveredStatus($material_delivered_status)
    {
        $this->material_delivered_status = $material_delivered_status;
    }
    public function setMarialReceivedStatus($material_received_status)
    {
        $this->material_received_status = $material_received_status;
    }


    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)
        if (permission('production-bulk-delete')){
            $this->column_order = [null,'id','id','batch_no','product_id','start_date','end_date','production_status', 'material_delivered_status', 'material_received_status',null];
        }else{
            $this->column_order = ['id','id','batch_no','product_id','start_date','end_date','production_status', 'material_delivered_status', 'material_received_status',null];
        }
        
        $query = self::with('product');

        //search query
        if (!empty($this->batch_no)) {
            $query->where('batch_no', 'like', '%' . $this->batch_no . '%');
        }

        if (!empty($this->start_date)) {
            $query->where('start_date', $this->start_date);
        }
        if (!empty($this->end_date)) {
            $query->where('end_date', $this->end_date);
        }
        if (!empty($this->product_id)) {
            $query->where('product_id', $this->product_id);
        }
        if (!empty($this->production_status)) {
            $query->where('production_status', $this->production_status);
        }
        if (!empty($this->material_delivered_status)) {
            $query->where('material_delivered_status', $this->material_delivered_status);
        }
        if (!empty($this->material_received_status)) {
            $query->where('material_received_status', $this->material_received_status);
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
