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

Route::group(['middleware' => ['auth']], function () {
    Route::get('purchase-return', 'StockReturnController@index')->name('return');
    Route::group(['prefix' => 'return', 'as'=>'return.'], function () {
        // Route::get('sale', 'StockReturnController@return_sale')->name('sale');
        Route::get('purchase', 'StockReturnController@return_purchase')->name('purchase');
    });
   
    //Sale Return Routes
    Route::get('sale-return-list', 'SaleReturnController@index')->name('sale.return.list');
    Route::group(['prefix' => 'sale-return-list', 'as'=>'sale.return.list.'], function () {
        Route::post('datatable-data', 'SaleReturnController@get_datatable_data')->name('datatable.data');
        Route::post('store', 'SaleReturnController@store')->name('store');
        Route::get('{id}/show', 'SaleReturnController@show')->name('show');
        Route::post('delete', 'SaleReturnController@delete')->name('delete');
        Route::post('bulk-delete', 'SaleReturnController@bulk_delete')->name('bulk.delete');
    });

    //Purchase Return Routes
    Route::get('purchase-return-list', 'PurchaseReturnController@index')->name('purchase.return.list');
    Route::group(['prefix' => 'purchase-return-list', 'as'=>'purchase.return.list.'], function () {
        Route::post('datatable-data', 'PurchaseReturnController@get_datatable_data')->name('datatable.data');
        Route::post('store', 'PurchaseReturnController@store')->name('store');
        Route::get('{id}/show', 'PurchaseReturnController@show')->name('show');
        Route::post('delete', 'PurchaseReturnController@delete')->name('delete');
        Route::post('bulk-delete', 'PurchaseReturnController@bulk_delete')->name('bulk.delete');
    });
       
});
