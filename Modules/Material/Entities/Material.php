<?php

namespace Modules\Material\Entities;

use App\Models\BaseModel;
use App\Models\Unit;

class Material extends BaseModel
{
    protected $fillable = [ 'category_id', 'material_image', 'material_name', 'material_code', 'unit_id', 
    'purchase_unit_id', 'purchase_price', 'qty', 'alert_qty', 'type', 'tax_id', 'tax_method', 'status', 
    'created_by', 'modified_by'];
    

    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $material_name; 
    protected $material_code; 
    protected $category_id; 
    protected $type; 
    protected $status; 

    //methods to set custom search property value
    public function setMaterialName($material_name)
    {
        $this->material_name = $material_name;
    }
    public function setMaterialCode($material_code)
    {
        $this->material_code = $material_code;
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
        if (permission('material-bulk-delete')){
            $this->column_order = [null,'id','id','material_name','material_code','category_id','purchase_price','unit_id','qty', 'alert_qty', 'tax_id','tax_method','type','status',null];
        }else{
            $this->column_order = ['id','id','material_name','material_code','category_id','purchase_price','unit_id','qty', 'alert_qty', 'tax_id','tax_method','type','status',null];
        }
        
        $query = self::with('category:id,name','unit:id,unit_name,unit_code');

        //search query
        if (!empty($this->material_name)) {
            $query->where('material_name', 'like', '%' . $this->material_name . '%');
        }
        if (!empty($this->material_code)) {
            $query->where('material_code', 'like', '%' . $this->material_code . '%');
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

    /***************************************
     * * * Begin :: Model Relationship * * *
    ****************************************/
    public function category()
    {
        return $this->belongsTo(\App\Models\Category::class);
    }
    public function unit()
    {
        return $this->belongsTo(Unit::class,'unit_id','id');
    }
    public function purchase_unit()
    {
        return $this->belongsTo(Unit::class,'purchase_unit_id','id');
    }
    public function tax()
    {
        return $this->belongsTo(\App\Models\Tax::class)->orderBy('name','asc')->withDefault(['name'=>'No Tax','rate'=>0]);
    }
    /***************************************
     * * * End :: Model Relationship * * *
    ****************************************/


}
