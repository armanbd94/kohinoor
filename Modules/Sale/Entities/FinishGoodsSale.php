<?php

namespace Modules\Sale\Entities;

use App\Models\BaseModel;

class FinishGoodsSale extends BaseModel
{
    protected $fillable = ['sale_id', 'finish_goods_id', 'qty', 'sale_unit_id', 'net_unit_price', 'discount',
     'tax_rate', 'tax', 'total'];

     

}
