<?php

namespace Modules\Production\Entities;

use Modules\Product\Entities\Product;
use Illuminate\Database\Eloquent\Model;
use Modules\Material\Entities\Material;
use Modules\Production\Entities\Production;
use Modules\Production\Entities\ProductionCoupon;

class ProductionProduct extends Model
{
    protected $fillable = ['production_id', 'product_id', 'year', 'mfg_date', 'exp_date', 'has_coupon', 'total_coupon',
     'coupon_price', 'coupon_exp_date', 'base_unit_qty', 'per_unit_cost'];

    public function production()
    {
        return $this->belongsTo(Production::class,'production_id','id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class,'product_id','id');
    }

    public function materials()
    {
        return $this->belongsToMany(Material::class,'production_product_materials','production_product_id',
        'material_id','id','id')
        ->withPivot('id', 'unit_id','qty','cost','total','used_qty', 'damaged_qty', 'odd_qty')
        ->withTimeStamps(); 
    }

    public function coupons()
    {
        return $this->hasMany(ProductionCoupon::class,'production_product_id','id');
    }
}
