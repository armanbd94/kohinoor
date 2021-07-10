<?php

namespace Modules\HRM\Entities;

use App\Models\BaseModel;
use App\Models\Warehouse;
use Modules\Location\Entities\Upazila;
use Modules\Location\Entities\District;

class Employee extends BaseModel
{

    protected $fillable = ['warehouse_id', 'name', 'email', 'phone', 'photograph', 'alternative_phone', 'district_id', 
    'upazila_id', 'zipcode', 'address', 'employee_id', 'department_id', 'division_id', 'job_status', 'duty_type', 
    'joining_designation_id', 'current_designation_id', 'joining_date', 'probation_start', 'probation_end', 'contract_start', 
    'contract_end', 'confirmation_date', 'termination_date', 'termination_reason', 'rate_type', 'rate', 'joining_rate',
    'overtime', 'pay_freequency', 'bank_name', 'account_no', 'is_supervisor', 'supervisor_id', 'father_name',
    'mother_name', 'dob', 'gender', 'marital_status', 'blood_group', 'religion', 'nid_no', 'nid_photo', 'residential_status',
    'emergency_contact_name', 'emergency_contact_phone', 'emergency_contact_relation', 'emergency_contact_address',
    'alternative_emergency_contact_name', 'alternative_emergency_contact_phone', 'alternative_emergency_contact_relation',
    'alternative_emergency_contact_address','status', 'created_by', 'modified_by'];

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class);
    }
    public function department()
    {
        return $this->belongsTo(Department::class);
    }
    public function division()
    {
        return $this->belongsTo(Division::class);
    }
    public function current_designation()
    {
        return $this->belongsTo(Designation::class,'current_designation_id','id');
    }
    public function joining_designation()
    {
        return $this->belongsTo(Designation::class,'joining_designation_id','id');
    }
    public function district()
    {
        return $this->belongsTo(District::class);
    }
    public function upazila()
    {
        return $this->belongsTo(Upazila::class);
    }

    public function educations()
    {
        return $this->hasMany(EmployeeEducation::class);
    }

    public function professional_informations()
    {
        return $this->hasMany(EmployeeProfessionalInformation::class);
    }

    public function supervisor()
    {
        return $this->belongsTo(Employee::class,'supervisor_id','id')->withDefault(['name'=>'Self']);
    }

    /******************************************
     * * * Begin :: Custom Datatable Code * * *
    *******************************************/
    //custom search column property
    protected $_warehouse_id; 
    protected $_employee_id; 
    protected $_name; 
    protected $_email; 
    protected $_phone; 
    protected $_department_id; 
    protected $_division_id; 
    protected $_designation_id; 
    protected $_job_status; 
    protected $_duty_type; 
    protected $_supervisor_id; 
    protected $_blood_group; 

    //methods to set custom search property value
    public function setWarehouseID($warehouse_id)
    {
        $this->_warehouse_id = $warehouse_id;
    }
    public function setEmployeeID($employee_id)
    {
        $this->_employee_id = $employee_id;
    }
    public function setName($name)
    {
        $this->_name = $name;
    }
    public function setEmail($email)
    {
        $this->_email = $email;
    }
    public function setPhone($phone)
    {
        $this->_phone = $phone;
    }
    public function setDepartmentID($department_id)
    {
        $this->_department_id = $department_id;
    }
    public function setDivisionID($division_id)
    {
        $this->_division_id = $division_id;
    }
    public function setDesignationID($designation_id)
    {
        $this->_designation_id = $designation_id;
    }
    public function setJobStatus($job_status)
    {
        $this->_job_status = $job_status;
    }
    public function setDutyType($duty_type)
    {
        $this->_duty_type = $duty_type;
    }
    public function setSupervisorID($supervisor_id)
    {
        
        $this->_supervisor_id = $supervisor_id;
    }
    public function setBloodGroup($blood_group)
    {
        $this->_blood_group = $blood_group;
    }

    private function get_datatable_query()
    {
        //set column sorting index table column name wise (should match with frontend table header)
        if (permission('employee-bulk-delete')){
            $this->column_order = [null,'id','photograph','employee_id','name','phone','email','warehouse_id','current_designation_id','department_id','division_id','supervisor_id','rate','job_status','duty_type','blood_group','status',null];
        }else{
            $this->column_order = ['id','photograph','employee_id','name','phone','email','warehouse_id','current_designation_id','department_id','division_id','supervisor_id','rate','job_status','duty_type','blood_group','status',null];
        }
        
        $query = self::with(['warehouse','department','division','current_designation','supervisor']);

        //search query
        if (!empty($this->_warehouse_id)) {
            $query->where('warehouse_id',  $this->_warehouse_id);
        }
        if (!empty($this->_employee_id)) {
            $query->where('employee_id', 'like', '%' . $this->_employee_id . '%');
        }
        if (!empty($this->_name)) {
            $query->where('name', 'like', '%' . $this->_name . '%');
        }
        if (!empty($this->_phone)) {
            $query->where('phone', 'like', '%' . $this->_phone . '%');
        }
        if (!empty($this->_email)) {
            $query->where('email', 'like', '%' . $this->_email . '%');
        }
        if (!empty($this->_department_id)) {
            $query->where('department_id',  $this->_department_id);
        }
        if (!empty($this->_division_id)) {
            $query->where('division_id',  $this->_division_id);
        }
        if (!empty($this->_designation_id)) {
            $query->where('current_designation_id',  $this->_designation_id);
        }
        if (!empty($this->_job_status)) {
            $query->where('job_status',  $this->_job_status);
        }
        if (!empty($this->_duty_type)) {
            $query->where('duty_type',  $this->_duty_type);
        }
        if (!empty($this->_supervisor_id)) {
            
            $query->where('supervisor_id',  $this->_supervisor_id);
        }
        if (!empty($this->_blood_group)) {
            $query->where('blood_group',  $this->_blood_group);
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
