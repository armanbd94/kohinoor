<?php

namespace Modules\FinishGoods\Entities;

use App\Models\Warehouse;
use Illuminate\Database\Eloquent\Model;
use Modules\Product\Entities\Product;

class WarehouseFinishGoods extends Model
{
    protected $fillable = ['warehouse_id','product_id','finish_goods_id','qty','rack_no'];

    public function warehouse()
    {
        return $this->belongsTo(Warehouse::class,'warehouse_id','id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class,'product_id','id');
    }

    public function finish_goods()
    {
        return $this->belongsTo(FinishGood::class,'finish_goods_id','id');
    }
}
