<?php

namespace Modules\Material\Entities;

use App\Models\BaseModel;

class WarehouseMaterial extends BaseModel
{

    protected $fillable = ['warehouse_id','material_id','qty','rack_no'];
    
}
