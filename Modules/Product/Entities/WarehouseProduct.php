<?php

namespace Modules\Product\Entities;

use Modules\Product\Entities\Product;
use Illuminate\Database\Eloquent\Model;
use Modules\Setting\Entities\Warehouse;

class WarehouseProduct extends Model
{
    protected $fillable = ['batch_no', 'warehouse_id', 'product_id', 'qty'];
    
    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}
