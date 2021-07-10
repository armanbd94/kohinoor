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
    //Product Routes
    Route::get('product', 'ProductController@index')->name('product');
    Route::group(['prefix' => 'product', 'as'=>'product.'], function () {
        Route::get('add', 'ProductController@create')->name('add');
        Route::post('datatable-data', 'ProductController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'ProductController@store_or_update_data')->name('store.or.update');
        Route::get('edit/{id}', 'ProductController@edit')->name('edit');
        Route::get('view/{id}', 'ProductController@show');
        Route::post('delete', 'ProductController@delete')->name('delete');
        Route::post('bulk-delete', 'ProductController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'ProductController@change_status')->name('change.status');
        // Route::post('generate-code', 'ProductController@generateProductCode')->name('generate.code');
    });

    //Size Routes
    Route::get('size', 'SizeController@index')->name('size');
    Route::group(['prefix' => 'size', 'as'=>'size.'], function () {
        Route::post('datatable-data', 'SizeController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'SizeController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'SizeController@edit')->name('edit');
        Route::post('delete', 'SizeController@delete')->name('delete');
        Route::post('bulk-delete', 'SizeController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'SizeController@change_status')->name('change.status');
    });

    Route::get('print-barcode', 'BarcodeController@index')->name('print.barcode');
    Route::post('generate-barcode', 'BarcodeController@generateBarcode')->name('generate.barcode');

});