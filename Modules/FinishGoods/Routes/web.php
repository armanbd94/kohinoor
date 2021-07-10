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
    //Material Routes
    Route::get('finished-goods', 'FinishGoodsController@index')->name('finished.goods');
    Route::group(['prefix' => 'finished-goods', 'as'=>'finished.goods.'], function () {
        Route::post('datatable-data', 'FinishGoodsController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'FinishGoodsController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'FinishGoodsController@edit')->name('edit');
        Route::post('view', 'FinishGoodsController@show')->name('view');
        Route::post('delete', 'FinishGoodsController@delete')->name('delete');
        Route::post('bulk-delete', 'FinishGoodsController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'FinishGoodsController@change_status')->name('change.status');
    });


});