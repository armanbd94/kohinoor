<?php

namespace Modules\ASM\Entities;

use App\Models\ASM;
use App\Models\BaseModel;
use Modules\ASM\Entities\Route;
use Modules\ASM\Entities\Upazila;
use Illuminate\Support\Facades\Auth;
use Modules\Location\Entities\District;

class SalesPerson extends BaseModel
{
    protected $table= 'salesmen';

    protected $fillable = [ 'name', 'username', 'phone','email', 'avatar', 'password',
     'asm_id', 'district_id', 'upazila_id', 'address', 'status', 'created_by', 'modified_by'];

    protected $hidden = [
        'password',
        'remember_token',  
    ];

    public function asm()
    {
        return $this->belongsTo(ASM::class,'asm_id','id');
    }
    public function district()
    {
        return $this->belongsTo(District::class,'district_id','id');
    }
    public function upazila()
    {
        return $this->belongsTo(Upazila::class,'upazila_id','id');
    }
    public function routes()
    {
        return $this->belongsToMany(Route::class,'sales_men_daily_routes','salesmen_id','route_id','id','id')
        ->withPivot('id','day')            
        ->withTimestamps();
    }

     /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/

    protected $_name;
    protected $_username;
    protected $_phone;
    protected $_email;
    protected $_upazila_id;
    protected $_status;

    public function setName($name)
    {
        $this->_name = $name;
    }

    public function setUsername($username)
    {
        $this->_username = $username;
    }

    public function setPhone($phone)
    {
        $this->_phone = $phone;
    }

    public function setEmail($email)
    {
        $this->_email = $email;
    }

    public function setUpazilaID($upazila_id)
    {
        $this->_upazila_id = $upazila_id;
    }

    public function setStatus($status)
    {
        $this->_status = $status;
    }

    private function get_datatable_query()
    { 

        $this->column_order = ['id','id','name','username','phone','upazila_id','email','status',null];

        
        $query = self::with('upazila')->where('asm_id', Auth::guard('asm')->user()->id );

        if (!empty($this->name)) {
            $query->where('name', 'like', '%' . $this->name . '%');
        }
        if (!empty($this->username)) {
            $query->where('username', 'like', '%' . $this->username . '%');
        }
        if (!empty($this->phone)) {
            $query->where('phone', 'like', '%' . $this->phone . '%');
        }
        if (!empty($this->email)) {
            $query->where('email', 'like', '%' . $this->email . '%');
        }
        if (!empty($this->_upazila_id)) {
            $query->where('upazila_id', $this->_upazila_id );
        }
        if (!empty($this->status)) {
            $query->where('status', $this->status );
        }

        if (isset($this->orderValue) && isset($this->dirValue)) {
            $query->orderBy($this->column_order[$this->orderValue], $this->dirValue);
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
        return self::toBase()->where('asm_id', Auth::guard('asm')->user()->id )->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/

}
