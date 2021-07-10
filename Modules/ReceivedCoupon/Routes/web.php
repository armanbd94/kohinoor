<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::group(['middleware' => ['auth','xss']], function () {
    Route::get('coupon-received', 'ReceivedCouponController@index')->name('coupon.received');
    Route::post('coupon-received/datatable-data', 'ReceivedCouponController@get_datatable_data')->name('coupon.received.datatable.data');
});