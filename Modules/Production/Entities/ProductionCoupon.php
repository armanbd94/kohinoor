<?php

namespace Modules\Production\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Production\Entities\ProductionFinishedGoods;

class ProductionCoupon extends Model
{

    protected $fillable = ['production_id','production_finished_good_id', 'batch_no', 'coupon_code', 'status'];

    public function production()
    {
        return $this->belongsTo(Production::class,'production_id','id');
    }
    public function production_finished_good()
    {
        return $this->belongsTo(ProductionFinishedGoods::class,'production_finished_good_id','id');
    }
    
}
