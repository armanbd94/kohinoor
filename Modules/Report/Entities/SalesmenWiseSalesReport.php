<?php

namespace Modules\Report\Entities;

use App\Models\BaseModel;
use Illuminate\Support\Facades\DB;

class SalesmenWiseSalesReport extends BaseModel
{
    protected $table = 'sales';

    protected $fillable = ['memo_no', 'warehouse_id', 'asm_id', 'salesmen_id', 'customer_id', 'item', 'total_qty',
    'total_discount', 'total_tax', 'total_labor_cost', 'total_price', 'order_tax_rate', 'order_tax', 'order_discount', 
    'shipping_cost', 'grand_total', 'paid_amount', 'due_amount', 'previous_due', 'sales_status', 'payment_status',
    'payment_method', 'account_id','document', 'note', 'sale_date', 'delivery_status', 'delivery_date', 'received_by', 'authorized_by',
    'created_by', 'modified_by'];
    

    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $order = ['sm.id' => 'asc'];
    protected $_warehouse_id; 
    protected $_salesmen_id; 
    protected $_start_date; 
    protected $_end_date; 

    //methods to set custom search property value
    public function setWarehouseID($warehouse_id)
    {
        $this->_warehouse_id = $warehouse_id;
    }
    public function setSalesmenID($salesmen_id)
    {
        $this->_salesmen_id = $salesmen_id;
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

        $this->column_order = [null,'s.warehouse_id','sm.name', null, null];
        
        
        $query = DB::table('sales as s')
                ->selectRaw("SUM(s.grand_total) as total_amount, COUNT(s.memo_no) as total_invoice, sm.name, sm.phone, w.name as warehouse_name")
                ->leftjoin('salesmen as sm','s.salesmen_id','=','sm.id')
                ->leftjoin('warehouses as w','s.warehouse_id','=','w.id')
                ->groupBy('s.salesmen_id','sm.id');

        //search query
        if (!empty($this->_warehouse_id)) {
            $query->where('s.warehouse_id', $this->_warehouse_id);
        }
        if (!empty($this->_salesmen_id)) {
            $query->where('s.salesmen_id', $this->_salesmen_id);
        }
        if (!empty($this->_start_date)) {
            $query->where('s.sale_date', '>=',$this->_start_date);
        }
        if (!empty($this->_end_date)) {
            $query->where('s.sale_date', '<=',$this->_end_date);
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
        return DB::table('sales as s')
        ->selectRaw("SUM(s.grand_total) as total_amount, COUNT(s.memo_no) as total_invoice, sm.name, sm.phone")
        ->leftjoin('salesmen as sm','s.salesmen_id','=','sm.id')
        ->groupBy('s.salesmen_id','sm.id')->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/
}
