<?php

namespace Modules\Product\Entities;

use Modules\Product\Entities\Product;
use Illuminate\Database\Eloquent\Model;
use Modules\Product\Entities\ProductVariant;

class AdjustmentProduct extends Model
{
    protected $fillable = ['adjustment_id', 'product_id', 'unit_qty', 'base_unit_qty', 'unit_cost', 'base_unit_cost'];
    
    public function product()
    {
        return $this->belongsTo(Product::class);
    }

}
