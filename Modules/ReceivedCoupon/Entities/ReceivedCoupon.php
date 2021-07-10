<?php

namespace Modules\ReceivedCoupon\Entities;

use App\Models\ASM;
use App\Models\Salesmen;
use App\Models\BaseModel;
use Modules\Customer\Entities\Customer;
use Modules\Production\Entities\ProductionCoupon;

class ReceivedCoupon extends BaseModel
{
    protected $fillable = ['asm_id', 'salesmen_id', 'customer_id', 'coupon_id', 'coupon_price'];

    public function asm()
    {
        return $this->belongsTo(ASM::class,'asm','id');
    }
    public function salesmen()
    {
        return $this->belongsTo(Salesmen::class,'salesmen_id','id');
    }
    public function customer()
    {
        return $this->belongsTo(Customer::class,'customer_id','id');
    }
    public function coupon()
    {
        return $this->belongsTo(ProductionCoupon::class,'coupon_id','id');
    }

    /******************************************
    * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property

    protected $_from_date; 
    protected $_to_date; 
    protected $_salesmen_id; 
    protected $_customer_id; 
    protected $_district_id; 
    protected $_upazila_id; 
    protected $_route_id; 

    //methods to set custom search property value
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

    public function setDistrictID($district_id)
    {
        $this->_district_id = $district_id;
    }

    public function setUpazilaID($upazila_id)
    {
        $this->_upazila_id = $upazila_id;
    }
    
    public function setRouteID($route_id)
    {
        $this->_route_id = $route_id;
    }

    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)
        $this->column_order = ['id',null, 'customer_id', 'salesmen_id', null,null, null, 'created_at','coupon_price'];
        
        $query = self::with('salesmen','customer','coupon');

        //search query
        if (!empty($this->_from_date)) {
            $query->whereDate('created_at', '>=',$this->_from_date);
        }
        if (!empty($this->_to_date)) {
            $query->whereDate('created_at', '<=',$this->_to_date);
        }
        if (!empty($this->_salesmen_id)) {
            $query->where('salesmen_id', $this->_salesmen_id);
        }
        if (!empty($this->_customer_id)) {
            $query->where('customer_id', $this->_customer_id);
        }
        if (!empty($this->_district_id)) {
            $district_id = $this->_district_id;
            $query->whereHas('customer', function($q) use ($district_id){
                $q->where('district_id',$district_id);
            });
        }
        if (!empty($this->_upazila_id)) {
            $upazila_id = $this->_upazila_id;
            $query->whereHas('customer', function($q) use ($upazila_id){
                $q->where('upazila_id',$upazila_id);
            });
        }
        if (!empty($this->_route_id)) {
            $route_id = $this->_route_id;
            $query->whereHas('customer', function($q) use ($route_id){
                $q->where('route_id',$route_id);
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
        return self::toBase()->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/
}
