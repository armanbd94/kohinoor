<?php

namespace Modules\Production\Entities;

use Illuminate\Database\Eloquent\Model;
use Modules\Production\Entities\ProductionProduct;
use Modules\SalesMen\Entities\Salesmen;

class ProductionCoupon extends Model
{
    protected $fillable = ['production_product_id', 'batch_no', 'coupon_code', 'status', 'salesmen_id', 'receive_date'];

    public function production_product()
    {
        return $this->belongsTo(ProductionProduct::class,'production_product_id','id');
    }

    public function salesmen()
    {
        return $this->belongsTo(Salesmen::class,'salesmen_id','id');
    }
}
