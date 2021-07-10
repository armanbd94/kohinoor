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

    //Department Routes
    Route::get('department', 'DepartmentController@index')->name('department');
    Route::group(['prefix' => 'department', 'as'=>'department.'], function () {
        Route::post('datatable-data', 'DepartmentController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'DepartmentController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'DepartmentController@edit')->name('edit');
        Route::post('delete', 'DepartmentController@delete')->name('delete');
        Route::post('bulk-delete', 'DepartmentController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'DepartmentController@change_status')->name('change.status');
    });

    //Division Routes
    Route::get('division', 'DivisionController@index')->name('division');
    Route::group(['prefix' => 'division', 'as'=>'division.'], function () {
        Route::post('datatable-data', 'DivisionController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'DivisionController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'DivisionController@edit')->name('edit');
        Route::post('delete', 'DivisionController@delete')->name('delete');
        Route::post('bulk-delete', 'DivisionController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'DivisionController@change_status')->name('change.status');
    });
    Route::get('department-id-wise-division-list/{id}','DivisionController@department_id_wise_division_list');

    //Designation Routes
    Route::get('designation', 'DesignationController@index')->name('designation');
    Route::group(['prefix' => 'designation', 'as'=>'designation.'], function () {
        Route::post('datatable-data', 'DesignationController@get_datatable_data')->name('datatable.data');
        Route::post('store-or-update', 'DesignationController@store_or_update_data')->name('store.or.update');
        Route::post('edit', 'DesignationController@edit')->name('edit');
        Route::post('delete', 'DesignationController@delete')->name('delete');
        Route::post('bulk-delete', 'DesignationController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'DesignationController@change_status')->name('change.status');
    });

    //Employee Routes
    Route::get('employee', 'EmployeeController@index')->name('employee');
    Route::group(['prefix' => 'employee', 'as'=>'employee.'], function () {
        Route::post('datatable-data', 'EmployeeController@get_datatable_data')->name('datatable.data');
        Route::get('add', 'EmployeeController@create')->name('add');
        Route::post('store-or-update', 'EmployeeController@store_or_update_data')->name('store.or.update');
        Route::get('details/{id}', 'EmployeeController@show')->name('details');
        Route::get('edit/{id}', 'EmployeeController@edit')->name('edit');
        Route::post('delete', 'EmployeeController@delete')->name('delete');
        Route::post('bulk-delete', 'EmployeeController@bulk_delete')->name('bulk.delete');
        Route::post('change-status', 'EmployeeController@change_status')->name('change.status');
    });
});
