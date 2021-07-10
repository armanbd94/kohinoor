<?php

namespace Modules\Report\Entities;

use App\Models\BaseModel;
use App\Models\Salesmen;
use App\Models\Warehouse;
use Illuminate\Support\Facades\Auth;
use Modules\Customer\Entities\Customer;

class TodaysSalesReport extends BaseModel
{
    protected $table = 'sales';
    protected $fillable = ['memo_no', 'warehouse_id', 'asm_id', 'salesmen_id', 'customer_id', 'item', 'total_qty',
    'total_discount', 'total_tax', 'total_labor_cost', 'total_price', 'order_tax_rate', 'order_tax', 'order_discount', 
    'shipping_cost', 'grand_total', 'paid_amount', 'due_amount', 'previous_due', 'sales_status', 'payment_status',
    'payment_method', 'account_id','document', 'note', 'sale_date', 'delivery_status', 'delivery_date', 'received_by', 'authorized_by',
    'created_by', 'modified_by'];

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class,'warehouse_id','id');
    }
    public function salesmen()
    {
        return $this->belongsTo(Salesmen::class,'salesmen_id','id');
    }
    public function customer()
    {
        return $this->belongsTo(Customer::class,'customer_id','id');
    }

    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $_warehouse_id; 

    //methods to set custom search property value
    public function setWarehouseID($warehouse_id)
    {
        $this->_warehouse_id = $warehouse_id;
    }

    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)

        $this->column_order = ['id','warehouse_id','sale_date','memo_no','salesmen_id',  'custoemr_id', 'grand_total'];
        
        
        $query = self::with('salesmen:id,name','customer:id,name,shop_name','warehouse:id,name')
        ->where('sale_date', date('Y-m-d'));

        //search query
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
        return self::toBase()->where('sale_date', date('Y-m-d'))->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/
}
