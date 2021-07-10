<?php

namespace Modules\Production\Entities;

use App\Models\BaseModel;
use Modules\Material\Entities\Material;
use Modules\Production\Entities\Production;

class ProductionMaterial extends BaseModel
{
    protected $fillable = ['production_id', 'batch_no', 'material_id', 'required_qty', 'delivered_qty','received_qty', 'used_qty','damaged_qty'];

    public function material()
    {
        return $this->belongsTo(Material::class);
    }
    public function production()
    {
        return $this->belongsTo(Production::class,'production_id','id');
    }

}
