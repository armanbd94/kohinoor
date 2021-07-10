<?php

namespace Modules\SalesMen\Entities;

use App\Models\BaseModel;

class ReceivedCoupon extends BaseModel
{

    protected $fillable = ['asm_id', 'salesmen_id', 'customer_id', 'coupon_id', 'coupon_price'];
    

}
