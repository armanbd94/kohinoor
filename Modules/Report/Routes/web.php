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
    //Closing Route
    Route::get('closing', 'ClosingReportController@index')->name('closing');
    Route::post('closing-data', 'ClosingReportController@closing_data')->name('closing.data');
    Route::post('closing/store', 'ClosingReportController@store')->name('closing.store');

    //Closing Report Route
    Route::get('closing-report', 'ClosingReportController@report')->name('closing.report');
    Route::post('closing-report/datatable-data', 'ClosingReportController@get_datatable_data')->name('closing.report.datatable.data');
    
    //Todays Report Route
    Route::get('todays-sales-report', 'TodaysSalesReportController@index')->name('todays.sales.report');
    Route::post('todays-sales-report/datatable-data', 'TodaysSalesReportController@get_datatable_data')->name('todays.sales.report.datatable.data');
    
    //Todays Customer Receipt Route
    Route::get('todays-customer-receipt', 'TodaysCustomerReceiptController@index')->name('todays.customer.receipt');
    Route::post('todays-customer-receipt/datatable-data', 'TodaysCustomerReceiptController@get_datatable_data')->name('todays.customer.receipt.datatable.data');

    //Salesmen Wise Sales Report Route
    Route::get('salesmen-wise-sales-report', 'SalesmenWiseSalesReportController@index')->name('salesmen.wise.sales.report');
    Route::post('salesmen-wise-sales-report/datatable-data', 'SalesmenWiseSalesReportController@get_datatable_data')->name('salesmen.wise.sales.report.datatable.data');
    //Due Report Route
    Route::get('due-report', 'DueReportController@index')->name('due.report');
    Route::post('due-report/datatable-data', 'DueReportController@get_datatable_data')->name('due.report.datatable.data');

    //Shipping Cost Report Route
    Route::get('shipping-cost-report', 'ShippingCostReportController@index')->name('shipping.cost.report');
    Route::post('shipping-cost-report/datatable-data', 'ShippingCostReportController@get_datatable_data')->name('shipping.cost.report.datatable.data');

    //Product Wise Sales Report Route
    Route::get('product-wise-sales-report', 'ProductWiseSalesReportController@index')->name('product.wise.sales.report');
    Route::post('product-wise-sales-report/datatable-data', 'ProductWiseSalesReportController@get_datatable_data')->name('product.wise.sales.report.datatable.data');
    
    //Production Report Route
    Route::get('production-report', 'ProductionReportController@index')->name('production.report');
    Route::post('production-report/datatable-data', 'ProductionReportController@get_datatable_data')->name('production.report.datatable.data');
    
    //Warehouse Report Route
    Route::get('warehouse-report', 'WarehouseReportController@index')->name('warehouse.report');
    Route::post('warehouse-report/datatable-data', 'WarehouseReportController@get_datatable_data')->name('warehouse.report.datatable.data');

    //Product Coupon Report Route
    Route::get('product-coupon-report', 'ProductCouponReportController@index')->name('product.coupon.report');
    Route::post('product-coupon-report/data', 'ProductCouponReportController@get_datatable_data')->name('product.coupon.report.data');

    //Warehouse Coupon Report Route
    Route::get('warehouse-coupon-report', 'WarehouseCouponReportController@index')->name('warehouse.coupon.report');
    Route::post('warehouse-coupon-report/data', 'WarehouseCouponReportController@report')->name('warehouse.coupon.report.data');

});