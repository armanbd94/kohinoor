<?php

namespace Modules\Transfer\Entities;

use App\Models\BaseModel;
use Modules\Product\Entities\Product;
use Modules\Setting\Entities\Warehouse;
use Modules\Production\Entities\Production;

class Transfer extends BaseModel
{
    protected $fillable = [ 'production_id', 'chalan_no', 'warehouse_id', 'item', 'total_unit_qty', 'total_base_unit_qty', 
    'total_tax', 'total', 'shipping_cost', 'labor_cost', 'grand_total', 'received_by', 'carried_by', 'transfer_date', 'remarks', 'created_by'];

    public function production()
    {
        return $this->belongsTo(Production::class,'production_id','id');
    }
    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class,'warehouse_id','id');
    }
    public function products(){
        return $this->belongsToMany(Product::class,'transfer_products','transfer_id','product_id','id','id')
                    ->withPivot('id','unit_qty', 'base_unit_qty', 'net_unit_price', 
                    'base_unit_price', 'tax_rate', 'tax', 'total')
                    ->withTimestamps();
    }

     /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $_chalan_no; 
    protected $_warehouse_id; 
    protected $_start_date;  
    protected $_end_date;  

    //methods to set custom search property value
    public function setChalanNo($chalan_no)
    {
        $this->_chalan_no = $chalan_no;
    }

    public function setStartDate($start_date)
    {
        $this->_start_date = $start_date;
    }

    public function setEndDate($end_date)
    {
        $this->_end_date = $end_date;
    }

    public function setWarehouseID($warehouse_id)
    {
        $this->_warehouse_id = $warehouse_id;
    }

    private function get_datatable_query()
    {

        $this->column_order = ['id', 'batch_no','chalan_no', 'warehouse_id', 'transfer_date', 'item','grand_total', 'received_by', 'carried_by', null];
        
        
        $query = self::with(['warehouse:id,name','production:id,batch_no']);

        //search query
        if (!empty($this->_chalan_no)) {
            $query->where('chalan_no', $this->_chalan_no);
        }
        if (!empty($this->_start_date) && !empty($this->_end_date)) {
            $query->whereDate('transfer_date','>=', $this->_start_date)->whereDate('transfer_date','<=', $this->_end_date);
        }
        if (!empty($this->_warehouse_id)) {
            $query->where('warehouse_id', $this->_warehouse_id);
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
