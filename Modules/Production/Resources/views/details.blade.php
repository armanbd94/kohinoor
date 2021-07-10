@extends('layouts.app')

@section('title', $page_title)

@push('styles')
<style>
.custom-input{
    border: 1px solid #ddd;
    border-radius:5px;
    width: 80px;
    text-align: center;
}
/* .custom-input:focus,.custom-input:active{
    border: 1px solid #ddd;
    border-radius:5px;
    width: 60px;
    text-align: center;
    outline: 0;
    box-shadow: none;
} */
#finished-goods{
    table-layout: fixed; 
    width: 100%:
}
</style>
@endpush

@section('content')
<div class="d-flex flex-column-fluid">
    <div class="container-fluid">
        <!--begin::Notice-->
        <div class="card card-custom gutter-b">
            <div class="card-header flex-wrap py-5">
                <div class="card-title">
                    <h3 class="card-label"><i class="{{ $page_icon }} text-primary"></i> {{ $sub_title }}</h3>
                </div>
                <div class="card-toolbar">
                    <!--begin::Button-->
                    @if(permission('production-edit'))
                    <button type="button" class="btn btn-primary btn-sm font-weight-bolder mr-3" id="production-status-btn">Change Production Status</button>
                    @endif
                    <a href="{{ route('production') }}" class="btn btn-warning btn-sm font-weight-bolder"> 
                        <i class="fas fa-arrow-left"></i> Back</a>
                    <!--end::Button-->
                </div>
            </div>
        </div>
        <!--end::Notice-->
        <!--begin::Card-->
        <div class="card card-custom" style="padding-bottom: 100px !important;">
            {{-- <div class="card-body" style="padding-bottom: 100px !important;"> --}}
                <!--begin: Datatable-->
                {{-- <div id="kt_datatable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer pb-5"> --}}
                    {{-- <div class="card card-custom gutter-b"> --}}
                        <div class="card-header card-header-tabs-line">
                            <div class="card-toolbar">
                                <ul class="nav nav-tabs nav-bold nav-tabs-line">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#kt_tab_general">
                                            <span class="nav-icon"><i class="fab fa-product-hunt"></i></span>
                                            <span class="nav-text">General</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" onclick="material_list()" href="#kt_tab_materials">
                                            <span class="nav-icon"><i class="fas fa-toolbox"></i></span>
                                            <span class="nav-text">Materials</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#kt_tab_variants">
                                            <span class="nav-icon"><i class="fas fa-box"></i></span>
                                            <span class="nav-text">Finished Goods</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="card-body">
                                <div class="tab-content">
                                    <div class="tab-pane fade show active" id="kt_tab_general" role="tabpanel" aria-labelledby="kt_tab_general">
                                        <div class="row">
                                            <div class="col-md-9">
                                                <table class="table table-borderless table-hover">
                                                    <tr><td width="25%"><b>Batch No.</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ $production->batch_no }}</td></tr>
                                                    <tr><td width="25%"><b>Start Date</b></td> <td width="2%" class="text-center"><b>:</b></td> <td>{{ date(config('settings.date_format'),strtotime($production->start_date)) }}</td></tr>
                                                    <tr><td width="25%"><b>End Date</b></td> <td width="2%" class="text-center"><b>:</b></td> <td>{{ $production->end_date ? date(config('settings.date_format'),strtotime($production->end_date)) : '' }}</td></tr>
                                                    <tr><td width="25%"><b>Production Status</b></td> <td width="2%" class="text-center"><b>:</b></td> <td>{!! PRODUCTION_STATUS_LABEL[$production->production_status] !!}</td></tr>
                                                    <tr><td width="25%"><b>Product Name</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ $production->product->product_name }}</td></tr>
                                                    <tr><td width="25%"><b>Product Type</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ PRODUCT_TYPE[$production->product->type] }}</td></tr>
                                                    <tr><td width="25%"><b>Category Name</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ $production->product->category->name }}</td></tr>
                                                    <tr><td width="25%"><b>Manufacturing Date</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ date(config('settings.date_format'),strtotime($production->mfg_date)) }}</td></tr>
                                                    <tr><td width="25%"><b>Expiration Date</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ date(config('settings.date_format'),strtotime($production->exp_date)) }}</td></tr>
                                                    @if($production->product_return_qty)<tr><td width="25%"><b>Production Return:</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ $production->product_return_qty }}</td></tr>@endif
                                                    <tr><td width="25%"><b>Description</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{!! $production->description !!}</td></tr>
                                                </table>
                                            </div>
                                            <div class="col-md-3">
                                                @if (!empty($production->product->product_image))
                                                <img src="{{ asset('storage/'.PRODUCT_IMAGE_PATH.$production->product->product_image) }}" alt="{{ $production->product->product_name }}" style="width: 100%;">
                                                @endif
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="kt_tab_materials" role="tabpanel" aria-labelledby="kt_tab_materials">
                                        <div class="row" id="material_list">

                                        </div>
                                    </div>
                                    <div class="tab-pane fade" id="kt_tab_variants" role="tabpanel" aria-labelledby="kt_tab_variants">
                                        <div class="row table-responsive">
                                            <table class="table table-bordered" id="finshed-goods">
                                                <thead class="bg-primary">
                                                    <th class="text-center">Batch No</th>
                                                    <th>Product Name</th>
                                                    <th>Product Size</th>
                                                    <th class="text-center">Total Coupon</th>
                                                    <th class="text-right">Coupon Price ({{ config('settings.currency_symbol') }})</th>
                                                    <th class="text-center">Coupon Exp Date</th>
                                                    <th class="text-center">Quantity</th>
                                                    <th class="text-center">Unit</th>
                                                    <th class="text-right">Direct Cost ({{ config('settings.currency_symbol') }})</th>
                                                    @if (permission('production-qr-code-print') || permission('production-packaging'))
                                                    <th class="text-center">Action</th>
                                                    @endif
                                                </thead>
                                               
                                                <tbody></tbody>
                                            </table>
                                        </div>
                                    </div>
                                    
                                    
                                </div>
                            </form>
                        </div>
                    {{-- </div> --}}
                {{-- </div> --}}
                <!--end: Datatable-->
            {{-- </div> --}}
        </div>
        <!--end::Card-->
    </div>
</div>
@include('production::qrcode-modal')
@include('production::production-status-modal')
@include('production::material-delivery-modal')
@include('production::material-receive-status-modal')
@include('production::material-return-modal')
@include('production::production-finished-goods-materials-modal')
@endsection

@push('scripts')
<script src="js/jquery.printarea.js"></script>
<script>
$(document).ready(function () {
    //QR Code Print
    $(document).on('click','#print-qrcode',function(){
        var mode = 'iframe'; // popup
        var close = mode == "popup";
        var options = {
            mode: mode,
            popClose: close
        };
        $("#printableArea").printArea(options);
    });


    //Show Production Status Change Form Modal
    $(document).on('click','#production-status-btn',function(){
            $('#production_status_modal').modal({
                keyboard: false,
                backdrop: 'static',
            });
            $('#production_status_modal .modal-title').html('<span>Change Production Status</span>');
            $('#production_status_modal #status-btn').text('Change Status');
                
    });

    


    //Show Material Delivery Form Modal
    $(document).on('click','#show-material-form',function(){
            $('#material_form')[0].reset();
            $('#material_form').find('.is-invalid').removeClass('is-invalid');
            $('#material_form').find('.error').remove();
            $.ajax({
                url: "{{route('production.material.delivery.list')}}",
                type: "POST",
                data: { id: "{{ $production->id }}",_token: _token},
                success: function (data) {
                    $('#material-delivery-list tbody').html('');
                    $('#material-delivery-list tbody').html(data);

                    
                    $('#material_modal').modal({
                        keyboard: false,
                        backdrop: 'static',
                    });
                    $('#material_modal .modal-title').html(
                        '<i class="fas fa-truck-loading text-white"></i> <span>Material Delivery</span>');
                    $('#material_modal #save-btn').text('Send');
                },
                error: function (xhr, ajaxOption, thrownError) {
                    console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
                }
            });
    });

    //Save Material Delivery Form Data
    $(document).on('click','#save-btn',function(e){
        e.preventDefault();
        let form = document.getElementById('material_form');
        let formData = new FormData(form);
        $.ajax({
            url: "{{route('production.material.delivered')}}",
            type: "POST",
            data: formData,
            dataType: "JSON",
            contentType: false,
            processData: false,
            cache: false,
            beforeSend: function(){
                $('#save-btn').addClass('spinner spinner-white spinner-right');
            },
            complete: function(){
                $('#save-btn').removeClass('spinner spinner-white spinner-right');
            },
            success: function (data) {
                $('#material_form').find('.is-invalid').removeClass('is-invalid');
                $('#material_form').find('.error').remove();
                if (data.status == false) {
                    $.each(data.errors, function (key, value) {
                        var key = key.split('.').join('_');
                        $('#material_form input#' + key).addClass('is-invalid');
                        $('#material_form select#' + key).parent().addClass('is-invalid');
                        $('#material_form #' + key).parent().append(
                            '<small class="error text-danger">' + value + '</small>');
                    });
                } else {
                    notification(data.status, data.message);
                    if (data.status == 'success') {
                        material_list();
                        $('#material_modal').modal('hide');
                        
                    }
                }

            },
            error: function (xhr, ajaxOption, thrownError) {
                console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
            }
        });
    });

    //Show Production Material Receive Status Change Form Modal
    $(document).on('click','#show-material-receive-form',function(){
            $('#material-receive-status-modal').modal({
                keyboard: false,
                backdrop: 'static',
            });
            $('#material-receive-status-modal .modal-title').html('<span>Change Material Receiving Status</span>');
            $('#material-receive-status-modal #receive-status-btn').text('Save');
                
    });

    //Save Materialelivery Form Data
    $(document).on('click','#receive-status-btn',function(e){
        e.preventDefault();
        let form = document.getElementById('material_receive_status_form');
        let formData = new FormData(form);
        $.ajax({
            url: "{{route('production.material.received')}}",
            type: "POST",
            data: formData,
            dataType: "JSON",
            contentType: false,
            processData: false,
            cache: false,
            beforeSend: function(){
                $('#receive-status-btn').addClass('spinner spinner-white spinner-right');
            },
            complete: function(){
                $('#receive-status-btn').removeClass('spinner spinner-white spinner-right');
            },
            success: function (data) {
                notification(data.status, data.message);
                if (data.status == 'success') {
                    material_list();
                    $('#material-receive-status-modal').modal('hide');
                    
                }
            },
            error: function (xhr, ajaxOption, thrownError) {
                console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
            }
        });
    });

    //Show Material Return Form Modal
    $(document).on('click','#show-material-return-form',function(){
            $('#material_return_form')[0].reset();
            $('#material_return_form').find('.is-invalid').removeClass('is-invalid');
            $('#material_return_form').find('.error').remove();
            $.ajax({
                url: "{{route('production.material.return.list')}}",
                type: "POST",
                data: { id: "{{ $production->id }}",_token: _token},
                success: function (data) {
                    $('#material-return-list tbody').html('');
                    $('#material-return-list tbody').html(data);
                    $('#material_return_modal').modal({
                        keyboard: false,
                        backdrop: 'static',
                    });
                    $('#material_return_modal .modal-title').html(
                        '<i class="fas fa-exchange-alt"></i> <span>Production Material Return</span>');
                    $('#material_return_modal #return-btn').text('Return');
                },
                error: function (xhr, ajaxOption, thrownError) {
                    console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
                }
            });
    });

    //Save Material Return Formata
    $(document).on('click','#return-btn',function(e){
        e.preventDefault();
        let form = document.getElementById('material_return_form');
        let formData = new FormData(form);
        $.ajax({
            url: "{{route('production.material.returned')}}",
            type: "POST",
            data: formData,
            dataType: "JSON",
            contentType: false,
            processData: false,
            cache: false,
            beforeSend: function(){
                $('#return-btn').addClass('spinner spinner-white spinner-right');
            },
            complete: function(){
                $('#return-btn').removeClass('spinner spinner-white spinner-right');
            },
            success: function (data) {
                $('#material_return_form').find('.is-invalid').removeClass('is-invalid');
                $('#material_return_form').find('.error').remove();
                if (data.status == false) {
                    $.each(data.errors, function (key, value) {
                        var key = key.split('.').join('_');
                        $('#material_return_form input#' + key).addClass('is-invalid');
                        $('#material_return_form #' + key).parent().append(
                            '<small class="error text-danger">' + value + '</small>');
                    });
                } else {
                    notification(data.status, data.message);
                    if (data.status == 'success') {
                        material_list();
                        $('#material_return_modal').modal('hide');
                    }
                }
            },
            error: function (xhr, ajaxOption, thrownError) {
                console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
            }
        });
    });

    $(document).on('click','#finished-good-material-btn', function(){
        let form = document.getElementById('finished_goods_material_form');
        let formData = new FormData(form);
        let url = "{{route('production.finished.goods.material.update')}}";
        $.ajax({
            url: url,
            type: "POST",
            data: formData,
            dataType: "JSON",
            contentType: false,
            processData: false,
            cache: false,
            beforeSend: function(){
                $('#finished-good-material-btn').addClass('spinner spinner-white spinner-right');
            },
            complete: function(){
                $('#finished-good-material-btn').removeClass('spinner spinner-white spinner-right');
            },
            success: function (data) {
                $('#finished_goods_material_form').find('.is-invalid').removeClass('is-invalid');
                $('#finished_goods_material_form').find('.error').remove();
                if (data.status == false) {
                    $.each(data.errors, function (key, value) {
                        var key = key.split('.').join('_');
                        $('#finished_goods_material_form input#' + key).addClass('is-invalid');
                        $('#finished_goods_material_form textarea#' + key).addClass('is-invalid');
                        $('#finished_goods_material_form select#' + key).parent().addClass('is-invalid');
                        if(key == 'production_qty')
                        {
                            $('#finished_goods_material_form #' + key).parents('.form-group').append(
                            '<small class="error text-danger">' + value + '</small>');
                        }else{
                            $('#finished_goods_material_form #' + key).parent().append(
                            '<small class="error text-danger">' + value + '</small>');
                        }
                        
                    });
                } else {
                    notification(data.status, data.message);
                    if (data.status == 'success') {
                        production_finished_goods_list();
                        $('#finished_goods_material_modal').modal('hide');
                    }
                }

            },
            error: function (xhr, ajaxOption, thrownError) {
                console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
            }
        });

    });

    


});
//Fetch materia liston load page
material_list();
function material_list()
{
    $.ajax({
        url: "{{ route('production.material.list') }}",
        type: "POST",
        data: {id:"{{ $production->id }}",_token:_token},
        success: function (data) {
            if(data) {
                $('#material_list').html('');
                $('#material_list').html(data);
            }
        },
        error: function (xhr, ajaxOption, thrownError) {
            console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
        }
    });
}

production_finished_goods_list();
function production_finished_goods_list()
{
    $.ajax({
        url: "{{ route('production.finished.goods.list') }}",
        type: "POST",
        data: {id:"{{ $production->id }}",_token:_token},
        success: function (data) {
            if(data) {
                $('#finshed-goods tbody').html('');
                $('#finshed-goods tbody').html(data);
            }
        },
        error: function (xhr, ajaxOption, thrownError) {
            console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
        }
    });
}
function show_finished_goods_edit_form(id, product_name)
{
    $.ajax({
        url: "{{ route('production.finished.goods.material.list') }}",
        type: "POST",
        data: {id:id,_token:_token},
        success: function (data) {
            if(data) {
                $('#finished_goods_materials').html('');
                $('#finished_goods_materials').html(data);
                $('#finished_goods_material_modal').modal({
                    keyboard: false,
                    backdrop: 'static',
                });
                $('#finished_goods_material_modal .modal-title').html('Materials of '+product_name);
            }
        },
        error: function (xhr, ajaxOption, thrownError) {
            console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
        }
    });
}

function material_calculation(key)
{
    var total_quantity   = $('#materials_'+key+'_total_qty').val() ? parseFloat($('#materials_'+key+'_total_qty').val()) : 0;
    var used_quantity    = $('#materials_'+key+'_used_qty').val() ? parseFloat($('#materials_'+key+'_used_qty').val()) : 0;
    var damaged_quantity = $('#materials_'+key+'_damaged_qty').val() ? parseFloat($('#materials_'+key+'_damaged_qty').val()) : 0;
    var odd_quantity     = parseFloat(total_quantity - (used_quantity + damaged_quantity));
    var cost             = $('#materials_'+key+'_cost').val() ? parseFloat($('#materials_'+key+'_cost').val()) : 0;
    $('#materials_'+key+'_direct_cost').val(parseFloat((used_quantity + damaged_quantity) * cost));
    $('#materials_'+key+'_odd_qty').val(odd_quantity);
}
/***********************
 ## Begin :: QR Code ##
************************/
function show_qrcode_modal(production_finished_good_id,production_id,batch_no,product_name)
{
    $('#qrcode_form')[0].reset();
    $('#qrcode_form #production_finished_good_id').val(production_finished_good_id);
    $('#qrcode_form #production_id').val(production_id);
    $('#qrcode_form #batch_no').val(batch_no);
    $('#qrcode_form #row_qty').val(1);
    $('#qrcode_modal').modal({
        keyboard: false,
        backdrop: 'static',
    });
    $('#qrcode_modal .modal-title').html('Print QR Code for '+product_name);
    load_qrcode_view();
}

function load_qrcode_view()
{
    var production_finished_good_id    = $('#qrcode_form #production_finished_good_id').val();
    var production_id    = $('#qrcode_form #production_id').val();
    var batch_no    = $('#qrcode_form #batch_no').val();
    var row_qty     = $('#qrcode_form #row_qty').val();
    
    if(production_finished_good_id && production_id && batch_no && row_qty){
        $.ajax({
            url: "{{ route('generate.qrcode') }}",
            type: "POST",
            data: {production_finished_good_id:production_finished_good_id,production_id:production_id,batch_no:batch_no,row_qty:row_qty,_token:_token},
            beforeSend: function(){
                $('#generate-qrcode').addClass('spinner spinner-white spinner-right');
            },
            complete: function(){
                $('#generate-qrcode').removeClass('spinner spinner-white spinner-right');
            },
            success: function (data) {
                $('#qrcode_form').find('.is-invalid').removeClass('is-invalid');
                $('#qrcode_form').find('.error').remove();
                if (data.status == false) {
                    $.each(data.errors, function (key, value) {
                        var key = key.split('.').join('_');
                        $('#qrcode_form input#' + key).addClass('is-invalid');
                        $('#qrcode_form #' + key).parent().append(
                        '<small class="error text-danger">' + value + '</small>');
                    });
                } 
                if(data) {
                    $('#qrcode-section').html('');
                    $('#qrcode-section').html(data);
                }
            },
            error: function (xhr, ajaxOption, thrownError) {
                console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
            }
        });
    }
}
/***********************
 ## End :: QR Code ##
************************/
</script>
@endpush