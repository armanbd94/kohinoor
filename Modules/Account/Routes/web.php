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
    Route::get('account', 'AccountController@index')->name('account');
    Route::group(['prefix' => 'account', 'as'=>'account.'], function () {
        Route::post('list', 'AccountController@account_list')->name('list');
    });

    //COA Routes
    Route::get('coa', 'COAController@index')->name('coa');
    Route::group(['prefix' => 'coa', 'as'=>'coa.'], function () {
        Route::post('datatable-data', 'COAController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'COAController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'COAController@edit')->name('edit');
        Route::post('delete', 'COAController@delete')->name('delete');
        Route::post('change-status', 'COAController@change_status')->name('change.status');
        
    });

    //Opening Balance Routes
    Route::resource('opening-balance', 'OpeningBalanceController')->only(['index','store']);

    //Cash Adjustment Routes
    Route::resource('cash-adjustment', 'CashAdjustmentController')->only(['index','store']);

    //Supplier Payment Route
    Route::resource('supplier-payment', 'SupplierPaymentController')->only(['index','store']);
    Route::get('supplier-payment/{id}/{payment_type}', 'SupplierPaymentController@show');

    //Customer Receive Route
    Route::resource('customer-receive', 'CustomerReceiveController')->only(['index','store']);
    Route::get('customer-receive/{id}/{payment_type}', 'CustomerReceiveController@show');

    //Debit Voucher Route
    Route::resource('debit-voucher', 'DebitVoucherController')->only(['index','store']);
    Route::post('debit-voucher/update', 'DebitVoucherController@update');

    //Credit Voucher Route
    Route::resource('credit-voucher', 'CreditVoucherController')->only(['index','store']);
    Route::post('credit-voucher/update', 'CreditVoucherController@update');

    //Contra Voucher Route
    Route::resource('contra-voucher', 'ContraVoucherController')->only(['index','store']);
    Route::post('contra-voucher/update', 'ContraVoucherController@update');

    //Journal Voucher Route
    Route::resource('journal-voucher', 'JournalVoucherController')->only(['index','store']);
    Route::post('journal-voucher/update', 'JournalVoucherController@update');

    //Journal Voucher Route
    Route::get('voucher-approval', 'VoucherApprovalController@index')->name('voucher.approval');
    Route::get('voucher-update/{voucher_no}', 'VoucherApprovalController@edit')->name('voucher.update');
    Route::post('voucher-approval/datatable-data', 'VoucherApprovalController@get_datatable_data')->name('voucher.approval.datatable.data');
    Route::post('voucher-approval/delete', 'VoucherApprovalController@delete')->name('voucher.approval.delete');
    Route::post('voucher-approval/approve', 'VoucherApprovalController@approve')->name('voucher.approval.approve');

    //Cash Book Route
    Route::get('cash-book', 'Report\CashBookController@index');
    Route::post('cash-book/report', 'Report\CashBookController@report');

    //Inventory Ledger Route
    Route::get('inventory-ledger', 'Report\InventoryLedgerController@index');
    Route::post('inventory-ledger/report', 'Report\InventoryLedgerController@report');

    //Bank Book Route
    Route::get('bank-book', 'Report\BankBookController@index');
    Route::post('bank-book/report', 'Report\BankBookController@report');

    //Mobile Bank Book Route
    Route::get('mobile-bank-book', 'Report\MobileBankBookController@index');
    Route::post('mobile-bank-book/report', 'Report\MobileBankBookController@report');

    //General Ledger Route
    Route::get('general-ledger', 'Report\GeneralLedgerController@index');
    Route::post('general-ledger/report', 'Report\GeneralLedgerController@report');

    //Trial Balance Route
    Route::get('trial-balance', 'Report\TrialBalanceController@index');
    Route::post('trial-balance/report', 'Report\TrialBalanceController@report');

    //Profit Loss Route
    Route::get('profit-loss', 'Report\ProfitLossController@index');
    Route::post('profit-loss/report', 'Report\ProfitLossController@report');

    //Cash Flow Route
    Route::get('cash-flow', 'Report\CashFlowController@index');
    Route::post('cash-flow/report', 'Report\CashFlowController@report');

    //General Ledger Route
    Route::get('general-ledger', 'Report\GeneralLedgerController@index');
    Route::post('general-ledger/report', 'Report\GeneralLedgerController@report');
    Route::post('general-ledger/transaction-heads', 'Report\GeneralLedgerController@transaction_heads');


});