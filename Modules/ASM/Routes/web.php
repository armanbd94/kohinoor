<?php

use Illuminate\Support\Facades\Route;

/*********************************
 * Begin :: ASM Panel ALL Routes *
**********************************/
Route::get('asm/login', 'LoginController@showLoginForm')->name('asm.login')->middleware('xss');
Route::post('asm-login', 'LoginController@login')->middleware('xss');

Route::group(['middleware' => ['auth:asm','xss'],'prefix'=>'asm','as'=>'asm.'], function () {

    Route::get('dashboard', 'DashboardController@index');
    Route::post('dashboard-data', 'DashboardController@dashboard_data')->name('dashboard.data');
    Route::post('logout', 'LoginController@logout')->name('logout');
    Route::get('my-profile', 'MyProfileController@index')->name('my.profile');
    Route::post('update-profile', 'MyProfileController@updateProfile')->name('update.profile');
    Route::post('update-password', 'MyProfileController@updatePassword')->name('update.password');

    //Salesmen Routes
    Route::get('sales-representative', 'SalesmenController@index')->name('sales.representative');
    Route::group(['prefix' => 'sales-representative', 'as'=>'sales.representative.'], function () {
        Route::post('datatable-data', 'SalesmenController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'SalesmenController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'SalesmenController@edit')->name('edit');
        Route::post('view', 'SalesmenController@show')->name('view');
        Route::post('delete', 'SalesmenController@delete')->name('delete');
        Route::post('bulk-delete', 'SalesmenController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'SalesmenController@change_status')->name('change.status');
        Route::post('upazila-route-list', 'SalesmenController@upazila_route_list')->name('upazila.route.list');
        Route::post('daily-route-list', 'SalesmenController@daily_route_list')->name('daily.route.list');
    });

    //Upazila Routes
    Route::get('upazila', 'UpazilaController@index')->name('upazila');
    Route::post('upazila/datatable-data', 'UpazilaController@get_datatable_data')->name('upazila.datatable.data');

    //Salesmen Daily Visiting Route Routes
    Route::get('route', 'RoutesController@index')->name('route');
    Route::group(['prefix' => 'route', 'as'=>'route.'], function () {
        Route::post('datatable-data', 'RoutesController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'RoutesController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'RoutesController@edit')->name('edit');
        Route::post('delete', 'RoutesController@delete')->name('delete');
        Route::post('bulk-delete', 'RoutesController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'RoutesController@change_status')->name('change.status');
    });
    Route::get('upazila-id-wise-route-list/{id}','RoutesController@upazila_id_wise_route_list');

    //Customer Routes
    Route::get('customer', 'CustomerController@index')->name('customer');
    Route::group(['prefix' => 'customer', 'as'=>'customer.'], function () {
        Route::post('datatable-data', 'CustomerController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'CustomerController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'CustomerController@edit')->name('edit');
        Route::post('view', 'CustomerController@show')->name('view');
        Route::post('delete', 'CustomerController@delete')->name('delete');
        Route::post('bulk-delete', 'CustomerController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'CustomerController@change_status')->name('change.status');
        Route::get('group-data/{id}','CustomerController@groupData');
        Route::get('previous-balance/{id}', 'CustomerController@previous_balance');
    });
    Route::post('route-id-wise-customer-list','CustomerController@route_id_wise_customer_list');

    //Customer Ledger Routes
    Route::get('customer-ledger', 'CustomerLedgerController@index')->name('customer.ledger');
    Route::post('customer-ledger/datatable-data', 'CustomerLedgerController@get_datatable_data')->name('customer.ledger.datatable.data');

    //Credit Customer Routes
    Route::get('credit-customer', 'CreditCustomerController@index')->name('credit.customer');
    Route::post('credit-customer/datatable-data', 'CreditCustomerController@get_datatable_data')->name('credit.customer.datatable.data');

    //Paid Customer Routes
    Route::get('paid-customer', 'PaidCustomerController@index')->name('paid.customer');
    Route::post('paid-customer/datatable-data', 'PaidCustomerController@get_datatable_data')->name('paid.customer.datatable.data');
    
    //Customer Advance Routes
    Route::get('customer-advance', 'CustomerAdvanceController@index')->name('customer.advance');
    Route::group(['prefix' => 'customer-advance', 'as'=>'customer.advance.'], function () {
        Route::post('datatable-data', 'CustomerAdvanceController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'CustomerAdvanceController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'CustomerAdvanceController@edit')->name('edit');
        Route::post('view', 'CustomerAdvanceController@show')->name('view');
        Route::post('delete', 'CustomerAdvanceController@delete')->name('delete');
        Route::post('bulk-delete', 'CustomerAdvanceController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'CustomerAdvanceController@change_status')->name('change.status');
    });

    //Upazila Routes
    Route::get('coupon-received', 'ReceivedCouponController@index')->name('coupon.received');
    Route::post('coupon-received/datatable-data', 'ReceivedCouponController@get_datatable_data')->name('coupon.received.datatable.data');

    //Inventory Routes
    Route::get('inventory', 'InventoryController@index')->name('inventory');
    Route::post('inventory/datatable-data', 'InventoryController@get_datatable_data')->name('inventory.datatable.data');

    //Sale Routes
    Route::get('sale', 'SaleController@index')->name('sale');
    Route::group(['prefix' => 'sale', 'as'=>'sale.'], function () {
        Route::post('datatable-data', 'SaleController@get_datatable_data')->name('datatable.data');
        Route::get('add', 'SaleController@create')->name('add');
        Route::post('store', 'SaleController@store')->name('store');
        Route::get('details/{id}', 'SaleController@show')->name('show');
        Route::get('edit/{id}', 'SaleController@edit')->name('edit');
        Route::post('update', 'SaleController@update')->name('update');
        Route::post('delete', 'SaleController@delete')->name('delete');
        Route::post('bulk-delete', 'SaleController@bulk_delete')->name('bulk.delete');
        Route::post('invoice', 'SaleController@invoice')->name('invoice');
        Route::post('delivery-status-update', 'SaleController@delivery_status_update')->name('delivery.update');
    });

    //Sale Product Search Routes
    Route::post('product-autocomplete-search', 'ProductController@product_autocomplete_search');
    Route::post('product-search', 'ProductController@product_search')->name('product.search');

    //Account List Routest
    Route::post('account/list', 'AccountController@account_list')->name('account.list');

    /***********************************
    * * Begin :: Report All Routes * *
    ***********************************/

    //Closing Route
    Route::get('closing', 'Report\ClosingReportController@index')->name('closing');
    Route::post('closing/store', 'Report\ClosingReportController@store')->name('closing.store');

    //Closing Report Route
    Route::get('closing-report', 'Report\ClosingReportController@report')->name('closing.report');
    Route::post('closing-report/datatable-data', 'Report\ClosingReportController@get_datatable_data')->name('closing.report.datatable.data');
    
    //Todays Report Route
    Route::get('todays-sales-report', 'Report\TodaysReportController@index')->name('todays.sales.report');
    Route::post('todays-sales-report/datatable-data', 'Report\TodaysReportController@get_datatable_data')->name('todays.sales.report.datatable.data');
    
    //Todays Customer Receipt Route
    Route::get('todays-customer-receipt', 'Report\TodaysCustomerReceiptController@index')->name('todays.customer.receipt');
    Route::post('todays-customer-receipt/datatable-data', 'Report\TodaysCustomerReceiptController@get_datatable_data')->name('todays.customer.receipt.datatable.data');

    //Salesmen Wise Sales Report Route
    Route::get('salesmen-wise-sales-report', 'Report\SalesmenWiseSalesReportController@index')->name('salesmen.wise.sales.report');
    Route::post('salesmen-wise-sales-report/datatable-data', 'Report\SalesmenWiseSalesReportController@get_datatable_data')->name('salesmen.wise.sales.report.datatable.data');
    //Due Report Route
    Route::get('due-report', 'Report\DueReportController@index')->name('due.report');
    Route::post('due-report/datatable-data', 'Report\DueReportController@get_datatable_data')->name('due.report.datatable.data');

    //Shipping Cost Report Route
    Route::get('shipping-cost-report', 'Report\ShippingCostReportController@index')->name('shipping.cost.report');
    Route::post('shipping-cost-report/datatable-data', 'Report\ShippingCostReportController@get_datatable_data')->name('shipping.cost.report.datatable.data');

    //Product Wise Sales Report Route
    Route::get('product-wise-sales-report', 'Report\ProductWiseSalesReportController@index')->name('product.wise.sales.report');
    Route::post('product-wise-sales-report/datatable-data', 'Report\ProductWiseSalesReportController@get_datatable_data')->name('product.wise.sales.report.datatable.data');

    //Opening Balance Routes
    Route::resource('opening-balance', 'Accounts\OpeningBalanceController')->only(['index','store']);

    //Customer Receive Route
    Route::resource('customer-receive', 'Accounts\CustomerReceiveController')->only(['index','store']);
    Route::get('customer-receive/{id}/{payment_type}', 'Accounts\CustomerReceiveController@show');
});
/*********************************
 * End :: ASM Panel ALL Routes *
**********************************/

/******************************************
 * Begin :: Admin Panel ASM Module Routes *
*******************************************/
Route::group(['middleware' => ['auth','xss']], function () {
    Route::get('asm', 'ASMController@index')->name('asm');
    Route::group(['prefix' => 'asm', 'as'=>'asm.'], function () {
        Route::post('datatable-data', 'ASMController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'ASMController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'ASMController@edit')->name('edit');
        Route::post('view', 'ASMController@show')->name('view');
        Route::post('delete', 'ASMController@delete')->name('delete');
        Route::post('bulk-delete', 'ASMController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'ASMController@change_status')->name('change.status');
    });
});
/******************************************
 * End :: Admin Panel ASM Module Routes *
*******************************************/