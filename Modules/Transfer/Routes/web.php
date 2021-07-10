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
    Route::get('transfer', 'TransferController@index')->name('transfer');
    Route::group(['prefix' => 'transfer', 'as'=>'transfer.'], function () {
        Route::post('datatable-data', 'TransferController@get_datatable_data')->name('datatable.data');
        Route::get('add', 'TransferController@create')->name('add');
        Route::post('store', 'TransferController@store')->name('store');
        Route::get('details/{id}', 'TransferController@show')->name('show');
        Route::get('edit/{id}', 'TransferController@edit')->name('edit');
        Route::post('update', 'TransferController@update')->name('update');
        Route::post('delete', 'TransferController@delete')->name('delete');
        Route::post('bulk-delete', 'TransferController@bulk_delete')->name('bulk.delete');
        Route::post('invoice', 'TransferController@invoice')->name('invoice');
        Route::post('delivery-status-update', 'TransferController@delivery_status_update')->name('delivery.update');
        Route::post('product-autocomplete-search', 'TransferController@product_autocomplete_search');
        Route::post('product-search', 'TransferController@product_search')->name('product.search');
    });
});
