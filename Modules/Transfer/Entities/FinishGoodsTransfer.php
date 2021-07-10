<?php

namespace Modules\Transfer\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class FinishGoodsTransfer extends Model
{

    protected $fillable = ['transfer_id', 'finish_goods_id', 'qty', 'unit_id', 'net_unit_cost', 'tax_rate','tax','total'];

}
