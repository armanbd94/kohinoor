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
// Route::view('qrcode','production::qrcode-demo');
Route::group(['middleware' => ['auth','xss']], function () {
    //Product Routes
    Route::get('production', 'ProductionController@index')->name('production');
    Route::group(['prefix' => 'production', 'as'=>'production.'], function () {
        Route::get('add', 'ProductionController@create')->name('add');
        Route::post('datatable-data', 'ProductionController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'ProductionController@store_or_update_data')->name('store.or.update');
        Route::get('edit/{id}', 'ProductionController@edit')->name('edit');
        Route::get('view/{id}', 'ProductionController@show')->name('view');
        Route::post('delete', 'ProductionController@delete')->name('delete');
        Route::post('bulk-delete', 'ProductionController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'ProductionController@change_status')->name('change.status');
        Route::get('generate-coupon-code', 'ProductionController@generateCouponCode')->name('generate.coupon.code');
        Route::post('product-variants', 'ProductionController@product_variants')->name('product.variants');
        
    });
    Route::post('generate-qrcode', 'ProductionController@generateQRCode')->name('generate.qrcode');
    Route::post('update-finished-goods', 'ProductionFinishedGoodsController@updateFinishedGoods')->name('update.finished.goods');
    Route::post('production-material-list', 'ProductionMaterialController@index')->name('production.material.list');
    Route::post('production-material-delivery-list', 'ProductionMaterialController@materialDeliveryList')->name('production.material.delivery.list');
    Route::post('production-material-delivered', 'ProductionMaterialController@materialDelivered')->name('production.material.delivered');
    Route::post('production-material-received', 'ProductionMaterialController@materialReceived')->name('production.material.received');
    Route::post('production-material-return-list', 'ProductionMaterialController@materialReturnList')->name('production.material.return.list');
    Route::post('production-material-returned', 'ProductionMaterialController@materialReturned')->name('production.material.returned');
    // Route::get('print-qrcode', 'ProductionController@qrcode')->name('print.qrcode');
    Route::post('production-finished-goods-list', 'ProductionFinishedGoodsController@production_finished_goods_list')->name('production.finished.goods.list');
    Route::post('production-finished-goods-material-list', 'ProductionFinishedGoodsController@production_finished_goods_material_list')->name('production.finished.goods.material.list');
    Route::post('production-finished-goods-material-update', 'ProductionFinishedGoodsController@production_finished_goods_material_update')->name('production.finished.goods.material.update');

    Route::get('production-finished', 'ProductionFinishedController@index')->name('production.finished');
    Route::post('production-finished/datatable-data', 'ProductionFinishedController@get_datatable_data')->name('production.finished.datatable.data');
    Route::post('production-finished/details', 'ProductionFinishedController@show')->name('production.finished.details');
});
