<?php

namespace Modules\Transfer\Entities;

use App\Models\ASM;
use App\Models\BaseModel;
use App\Models\Warehouse;
use Modules\FinishGoods\Entities\FinishGood;

class Transfer extends BaseModel
{
    protected $fillable = ['chalan_no', 'from_warehouse_id', 'to_warehouse_id', 'item', 'total_qty', 'total_tax','total_labor_cost', 'total_cost',
    'shipping_cost', 'grand_total', 'document', 'note', 'transfer_date', 'transfer_status', 'carried_by', 'received_by', 'created_by', 'modified_by'];



    public function from_warehouse()
    {
        return $this->belongsTo(Warehouse::class,'from_warehouse_id','id');
    }

    public function to_warehouse()
    {
        return $this->belongsTo(Warehouse::class,'to_warehouse_id','id');
    }

    public function asm()
    {
        return $this->belongsTo(ASM::class,'received_by','id');
    }

    public function  transfer_products()
    {
        return $this->belongsToMany(FinishGood::class,'finish_goods_transfers','transfer_id',
        'finish_goods_id','id','id')
        ->withTimeStamps()->withPivot( 'qty', 'unit_id', 'net_unit_cost', 'tax_rate','tax','total'); 
    }


    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $_chalan_no; 
    protected $_from_date; 
    protected $_to_date; 
    protected $_from_warehouse_id; 
    protected $_to_warehouse_id; 
    protected $_transfer_status; 

    //methods to set custom search property value
    public function setChalanNo($chalan_no)
    {
        $this->_chalan_no = $chalan_no;
    }

    public function setFromDate($from_date)
    {
        $this->_from_date = $from_date;
    }
    public function setToDate($to_date)
    {
        $this->_to_date = $to_date;
    }
    public function setFromWarehouseID($from_warehouse_id)
    {
        $this->_from_warehouse_id = $from_warehouse_id;
    }
    public function setToWarehouseID($to_warehouse_id)
    {
        $this->_to_warehouse_id = $to_warehouse_id;
    }

    public function setTransferStatus($transfer_status)
    {
        $this->_transfer_status = $transfer_status;
    }


    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)
        if (permission('transfer-bulk-delete')){
            $this->column_order = ['id','id','chalan_no','from_warehouse_id',  'to_warehouse_id', 'total_item', 'total_price', 'total_labor_cost',
            'shipping_cost', 'grand_total', 'transfer_date', 'transfer_status', null];
        }else{
            $this->column_order = ['id','chalan_no','from_warehouse_id',  'to_warehouse_id', 'total_item', 'total_price', 'total_labor_cost',
            'shipping_cost', 'grand_total', 'transfer_date', 'transfer_status', null];
        }
        
        $query = self::with('from_warehouse','to_warehouse');

        //search query
        if (!empty($this->_chalan_no)) {
            $query->where('chalan_no', 'like', '%' . $this->_chalan_no . '%');
        }

        if (!empty($this->_from_date)) {
            $query->where('transfer_date', '>=',$this->_from_date);
        }
        if (!empty($this->_to_date)) {
            $query->where('transfer_date', '<=',$this->_to_date);
        }
        if (!empty($this->_from_warehouse_id)) {
            $query->where('from_warehouse_id', $this->_from_warehouse_id);
        }
        if (!empty($this->_to_warehouse_id)) {
            $query->where('to_warehouse_id', $this->_to_warehouse_id);
        }
        
        if (!empty($this->_transfer_status)) {
            $query->where('transfer_status', $this->_transfer_status);
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
