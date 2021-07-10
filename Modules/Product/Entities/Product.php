<?php

namespace Modules\Product\Entities;

use App\Models\BaseModel;

class Product extends BaseModel
{
    protected $fillable = [
        'category_id', 'product_image', 'product_name', 'tax_id', 'tax_method', 
        'type', 'status', 'description', 'created_by', 'modified_by'
    ];

    /***************************************
     * * * Begin :: Model Relationship * * *
    ****************************************/
    public function category()
    {
        return $this->belongsTo(\App\Models\Category::class)->orderBy('name','asc');
    }
    public function tax()
    {
        return $this->belongsTo(\App\Models\Tax::class)->withDefault(['name'=>'No Tax','rate' => 0]);
    }

    public function product_material(){
        return $this->belongsToMany(\Modules\Material\Entities\Material::class,'product_material','product_id','material_id','id','id')
                    ->withTimestamps();
    }

    public function product_size(){
        return $this->belongsToMany(Size::class,'finish_goods','product_id','size_id','id','id')
                    ->withTimestamps()->withPivot('id','code', 'unit_id', 'sale_unit_id', 'cost', 'price', 'qty',
                    'opening_stock_qty', 'alert_qty', 'status', 'created_by', 'modified_by');
    }

    public function finish_goods(){
        return $this->hasMany(\Modules\FinishGoods\Entities\FinishGood::class,'product_id','id');
    }
    /***************************************
     * * * End :: Model Relationship * * *
    ****************************************/

    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $product_name; 
    protected $category_id; 
    protected $type; 
    protected $status; 

    //methods to set custom search property value
    public function setProductName($product_name)
    {
        $this->product_name = $product_name;
    }

    public function setCategoryID($category_id)
    {
        $this->category_id = $category_id;
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
        if (permission('product-bulk-delete')){
            $this->column_order = [null,'id','id','product_name','category_id','type','qty', 'opening_stock_qty','stock_unit','production_unit', 'sku','tax_id','tax_method','status',null];
        }else{
            $this->column_order = ['id','id','product_name','category_id','type','qty', 'opening_stock_qty','stock_unit','production_unit', 'sku','tax_id','tax_method', 'status',null];
        }
        
        $query = self::with('category:id,name','tax:id,name,rate');

        //search query
        if (!empty($this->product_name)) {
            $query->where('product_name', 'like', '%' . $this->product_name . '%');
        }

        if (!empty($this->category_id)) {
            $query->where('category_id', $this->category_id);
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
