<?php

namespace Modules\Product\Entities;

use App\Models\Unit;
// use Modules\Sale\Entities\SaleProduct;
use Modules\Product\Entities\Product;
use Illuminate\Database\Eloquent\Model;
// use Modules\Purchase\Entities\PurchaseProduct;
// use Modules\Product\Entities\AdjustmentProduct;
// use Modules\Quotation\Entities\QuotationProduct;

class ProductVariant extends Model
{
    protected $table = 'product_variants';
    protected $fillable = ['product_id', 'item_name', 'item_code','item_base_unit_id', 'item_unit_id', 'item_base_unit_mrp', 
    'item_base_unit_price', 'item_unit_mrp', 'item_unit_price', 'item_base_unit_qty', 'item_unit_qty', 'alert_qty'];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
    public function unit()
    {
        return $this->belongsTo(Unit::class,'item_unit_id','id');
    }

    public function base_unit()
    {
        return $this->belongsTo(Unit::class,'item_base_unit_id','id');
    }

    public function scopeFindExactProductWithCode($query, $product_id, $item_code)
    {
    	return $query->where([
            ['product_id', $product_id],
            ['item_code', $item_code],
        ]);
    }

    // public function sales()
    // {
    //     return $this->hasMany(SaleProduct::class,'product_variant_id','id');
    // }
    // public function purchases()
    // {
    //     return $this->hasMany(PurchaseProduct::class,'product_variant_id','id');
    // }
    // public function adjustments()
    // {
    //     return $this->hasMany(AdjustmentProduct::class,'product_variant_id','id');
    // }
    // public function quotations()
    // {
    //     return $this->hasMany(QuotationProduct::class,'product_variant_id','id');
    // }


}
