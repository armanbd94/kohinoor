<?php

namespace App\Models;

use App\Models\ASM;
use Illuminate\Support\Facades\Hash;
use Modules\Location\Entities\Upazila;
use Modules\Location\Entities\District;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Modules\Location\Entities\Route;

class Salesmen extends Authenticatable implements JWTSubject
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


    /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }

    public function setPasswordAttribute($value){
        $this->attributes['password'] = Hash::make($value);
    }

    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    protected $order = ['id' => 'desc'];
    protected $column_order;

    protected $orderValue;
    protected $dirValue;
    protected $startVlaue;
    protected $lengthVlaue;

    public function setOrderValue($orderValue)
    {
        $this->orderValue = $orderValue;
    }
    public function setDirValue($dirValue)
    {
        $this->dirValue = $dirValue;
    }
    public function setStartValue($startVlaue)
    {
        $this->startVlaue = $startVlaue;
    }
    public function setLengthValue($lengthVlaue)
    {
        $this->lengthVlaue = $lengthVlaue;
    }

    protected $_name;
    protected $_username;
    protected $_phone;
    protected $_email;
    protected $_asm_id;
    protected $_district_id;
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

    public function setASMID($asm_id)
    {
        $this->_asm_id = $asm_id;
    }

    public function setDistrictID($district_id)
    {
        $this->_district_id = $district_id;
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
        if (permission('sales-representative-bulk-delete')){
            $this->column_order = [null,'id','id','name','username','phone','asm_id','district_id','upazila_id','email','status',null];
        }else{
            $this->column_order = ['id','id','name','username','phone','asm_id','district_id','upazila_id','email','status',null];
        }
        

        $query = self::with('asm','district','upazila');

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
        if (!empty($this->_asm_id)) {
            $query->where('asm_id', $this->_asm_id );
        }
        if (!empty($this->_district_id)) {
            $query->where('district_id', $this->_district_id );
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
        return self::toBase()->get()->count();
    }
    /******************************************
     * * * End :: Custom Datatable Code * * *
    *******************************************/
}
