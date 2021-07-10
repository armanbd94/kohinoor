<?php

namespace Modules\ASM\Entities;

use App\Models\BaseModel;
use Illuminate\Support\Facades\Auth;

class TodaysSalesReport extends BaseModel
{
    protected $table = 'sales';
    protected $fillable = ['memo_no', 'warehouse_id', 'asm_id', 'salesmen_id', 'customer_id', 'item', 'total_qty',
    'total_discount', 'total_tax', 'total_labor_cost', 'total_price', 'order_tax_rate', 'order_tax', 'order_discount', 
    'shipping_cost', 'grand_total', 'paid_amount', 'due_amount', 'previous_due', 'sales_status', 'payment_status',
    'payment_method', 'account_id','document', 'note', 'sale_date', 'delivery_status', 'delivery_date', 'received_by', 'authorized_by',
    'created_by', 'modified_by'];

    public function salesmen()
    {
        return $this->belongsTo(SalesPerson::class,'salesmen_id','id');
    }
    public function customer()
    {
        return $this->belongsTo(Customer::class,'customer_id','id');
    }
    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)

        $this->column_order = ['id','sale_date','memo_no','salesmen_id',  'custoemr_id', 'grand_total'];
        
        
        $query = self::with('salesmen:id,name','customer:id,name,shop_name')
        ->where([
            'warehouse_id' => Auth::guard('asm')->user()->warehouse_id,
            'asm_id' => Auth::guard('asm')->user()->id,
            'sale_date' => date('Y-m-d')
            ]);


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
        return self::toBase()->where([
            'warehouse_id' => Auth::guard('asm')->user()->warehouse_id,
            'asm_id' => Auth::guard('asm')->user()->id,
            'sale_date' => date('Y-m-d')
            ])->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/
}
