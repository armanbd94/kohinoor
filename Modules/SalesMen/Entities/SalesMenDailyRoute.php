<?php

namespace Modules\SalesMen\Entities;

use App\Models\BaseModel;
use App\Models\Salesmen;
use Modules\Location\Entities\Route;

class SalesMenDailyRoute extends BaseModel
{
    protected $table = 'sales_men_daily_routes';
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['salesmen_id','route_id','day'];

    public function salesmen()
    {
        return $this->belongsTo(Salesmen::class);
    }
    public function route()
    {
        return $this->belongsTo(Route::class);
    }
}
