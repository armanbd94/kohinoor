<?php

namespace Modules\ASM\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ProductWiseSalesReport extends Model
{
    use HasFactory;

    protected $fillable = [];
    
    protected static function newFactory()
    {
        return \Modules\ASM\Database\factories\ProductWiseSalesReportFactory::new();
    }
}
