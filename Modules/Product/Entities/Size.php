<?php

namespace Modules\Product\Entities;

use App\Models\Unit;
use App\Models\BaseModel;
use Illuminate\Support\Facades\Cache;


class Size extends BaseModel
{

    protected $fillable = ['size','unit_id','status', 'created_by', 'modified_by'];

    public function unit()
    {
        return $this->belongsTo(Unit::class,'unit_id','id');
    }
    
    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $size; 

    //methods to set custom search property value
    public function setSize($size)
    {
        $this->size = $size;
    }


    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)
        if (permission('size-bulk-delete')){
            $this->column_order = [null,'id','size','unit_id','status','created_by','modified_by','created_at','updated_at',null];
        }else{
            $this->column_order = ['id','size','unit_id','status','created_by','modified_by','created_at','updated_at',null];
        }
        
        $query = self::with('unit');

        //search query
        if (!empty($this->size)) {
            $query->where('size', 'like', '%' . $this->size . '%');
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

        /*************************************
    * * *  Begin :: Cache Data * * *
    **************************************/
    protected const ALL_SIZES    = '_sizes';
    protected const ACTIVE_SIZES = '_active_sizes';

    public static function allSizes(){
        return Cache::rememberForever(self::ALL_SIZES, function () {
            return self::toBase()->get();
        });
    }
    public static function activeSizes(){
        return Cache::rememberForever(self::ACTIVE_SIZES, function () {
            return self::toBase()->where('status',1)->get();
        });
    }


    public static function flushCache(){
        Cache::forget(self::ALL_SIZES);
        Cache::forget(self::ACTIVE_SIZES);
    }


    public static function boot(){
        parent::boot();

        static::updated(function () {
            self::flushCache();
        });

        static::created(function() {
            self::flushCache();
        });

        static::deleted(function() {
            self::flushCache();
        });
    }
    /***********************************
    * * *  Begin :: Cache Data * * *
    ************************************/

}
