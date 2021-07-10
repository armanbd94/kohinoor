<?php

namespace Modules\Production\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Material\Entities\Material;

class FinishedGoodsMaterial extends Model
{

    protected $fillable = ['production_id', 'production_finished_good_id', 'material_id', 'total_qty','used_qty',
     'damaged_qty', 'odd_qty', 'direct_cost', 'created_by', 'modified_by'];
    
     public function production()
     {
         return $this->belongsTo(Production::class,'production_id','id');
     }
     public function production_finished_good()
     {
         return $this->belongsTo(ProductionFinishedGoods::class,'production_finished_good_id','id');
     }
     public function material()
     {
         return $this->belongsTo(Material::class,'material_id','id');
     }

}
