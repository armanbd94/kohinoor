<?php

namespace Modules\Product\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ProductAttributeOption extends Model
{
    protected $fillable = ['product_id', 'product_attribute_id', 'name'];

}
