<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::post('salesmen/login', 'API\SalesmenLoginController@login');

Route::group(['prefix' => 'salesmen','middleware' => ['jwt.verify']],function ()
{
    Route::post('coupon-validation-check', 'API\CouponValidationController@index');
    Route::get('daily-route-list/{salesmen_id}', 'API\SalesmenController@daily_route_list');
    Route::get('area-list/{route_id}', 'API\SalesmenController@route_area_list');
    Route::get('customer-list/{area_id}', 'API\SalesmenController@area_customer_list');
    Route::post('store/coupon', 'API\CouponReceivedController@store_received_coupon');
    Route::post('change-password', 'API\SalesmenPasswordChangeController@change_password');
});
