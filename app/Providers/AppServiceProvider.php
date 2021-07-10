<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\View;
use Modules\Production\Entities\Production;
use Carbon\Carbon;
class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        $data = [
            'production_materials_not_delivered' => Production::where('material_delivered_status','!=',2)->get(),
            'production_materials_not_received' => Production::where('material_received_status','!=',2)->get(),
        ];
        View::share('production_material_notification', $data);

        //Set Week Start and End Day
        Carbon::setWeekStartsAt(Carbon::SATURDAY);
        Carbon::setWeekEndsAt(Carbon::FRIDAY);
    }
}
