<?php

namespace Modules\Sale\Entities;

use App\Models\ASM;
use App\Models\Salesmen;
use App\Models\BaseModel;
use App\Models\Warehouse;
use Modules\Customer\Entities\Customer;
use Modules\FinishGoods\Entities\FinishGood;

class Sale extends BaseModel
{
    protected $fillable = ['memo_no', 'warehouse_id', 'asm_id', 'salesmen_id', 'customer_id', 'item', 'total_qty',
    'total_discount', 'total_tax', 'total_labor_cost', 'total_price', 'order_tax_rate', 'order_tax', 'order_discount', 
    'shipping_cost', 'grand_total', 'paid_amount', 'due_amount', 'previous_due', 'sales_status', 'payment_status',
    'payment_method', 'account_id','document', 'note', 'sale_date', 'delivery_status', 'delivery_date', 'received_by', 'authorized_by',
    'created_by', 'modified_by'];

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class);
    }

    public function asm()
    {
        return $this->belongsTo(ASM::class,'asm_id','id');
    }
    public function salesmen()
    {
        return $this->belongsTo(Salesmen::class,'salesmen_id','id');
    }
    public function customer()
    {
        return $this->belongsTo(Customer::class,'customer_id','id');
    }

    public function  sale_products()
    {
        return $this->belongsToMany(FinishGood::class,'finish_goods_sales','sale_id',
        'finish_goods_id','id','id')
        ->withTimeStamps()->withPivot('qty',  'sale_unit_id', 'net_unit_price', 
        'discount', 'tax_rate', 'tax', 'total'); 
    }

     /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $_memo_no; 
    protected $_warehouse_id; 
    protected $_from_date; 
    protected $_to_date; 
    protected $_salesmen_id; 
    protected $_customer_id; 
    protected $_payment_status; 
    protected $_delivery_status; 

    //methods to set custom search property value
    public function setMemoNo($memo_no)
    {
        $this->_memo_no = $memo_no;
    }
    public function setWarehouseID($warehouse_id)
    {
        $this->_warehouse_id = $warehouse_id;
    }

    public function setFromDate($from_date)
    {
        $this->_from_date = $from_date;
    }
    public function setToDate($to_date)
    {
        $this->_to_date = $to_date;
    }
    public function setSalesmenID($salesmen_id)
    {
        $this->_salesmen_id = $salesmen_id;
    }
    public function setCustomerID($customer_id)
    {
        $this->_customer_id = $customer_id;
    }
    public function setDeliveryStatus($delivery_status)
    {
        $this->_delivery_status = $delivery_status;
    }
    public function setPaymentStatus($payment_status)
    {
        $this->_payment_status = $payment_status;
    }


    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)
        if(permission('sale-bulk-delete')){
            $this->column_order = ['id','id','memo_no','warehouse_id','salesmen_id',  'custoemr_id', 'total_item', 'total_price', 'order_discount','total_labor_cost','order_tax_rate', 'order_tax',
            'shipping_cost', 'grand_total','previous_due',null, 'paid_amount', 'due_amount', 'sale_date', 'payment_status','payment_method','delivery_status', 'delivery_date', null];
        
        }else{
            $this->column_order = ['id','memo_no','warehouse_id','salesmen_id',  'custoemr_id', 'total_item', 'total_price', 'order_discount','total_labor_cost','order_tax_rate', 'order_tax',
            'shipping_cost', 'grand_total','previous_due',null, 'paid_amount', 'due_amount', 'sale_date', 'payment_status','payment_method','delivery_status', 'delivery_date', null];
        }
        
        $query = self::with('salesmen','customer','warehouse');

        //search query
        if (!empty($this->_memo_no)) {
            $query->where('memo_no', 'like', '%' . $this->_memo_no . '%');
        }

        if (!empty($this->_from_date)) {
            $query->where('sale_date', '>=',$this->_from_date);
        }
        if (!empty($this->_to_date)) {
            $query->where('sale_date', '<=',$this->_to_date);
        }
        if (!empty($this->_warehouse_id)) {
            $query->where('warehouse_id', $this->_warehouse_id);
        }
        if (!empty($this->_salesmen_id)) {
            $query->where('salesmen_id', $this->_salesmen_id);
        }
        if (!empty($this->_customer_id)) {
            $query->where('customer_id', $this->_customer_id);
        }
        
        if (!empty($this->_payment_status)) {
            $query->where('payment_status', $this->_payment_status);
        }
        if (!empty($this->_delivery_status)) {
            $query->where('delivery_status', $this->_delivery_status);
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
