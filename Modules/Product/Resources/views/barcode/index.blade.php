@extends('layouts.app')

@section('title', $page_title)

@push('styles')
{{-- <link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Libre+Barcode+EAN13+Text&display=swap" rel="stylesheet"> 
<style>
    .barcode{
        font-family: 'Libre Barcode EAN13 Text', cursive;
    }
</style> --}}
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
                    <a href="{{ route('product') }}" class="btn btn-warning btn-sm font-weight-bolder"> 
                        <i class="fas fa-arrow-left"></i> Back</a>
                    <!--end::Button-->
                </div>
            </div>
        </div>
        <!--end::Notice-->
        <!--begin::Card-->
        <div class="card card-custom" style="padding-bottom: 100px !important;">
            <div class="card-body" style="padding-bottom: 100px !important;">
                <!--begin: Datatable-->
                <div id="kt_datatable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer pb-5">
                    
                    <form id="generate-barcode-form" method="POST">
                        @csrf
                        <div class="row">
                            <x-form.selectbox labelName="Product" name="product" required="required"  col="col-md-3" class="selectpicker">
                                @if (!$finished_goods->isEmpty())
                                @foreach ($finished_goods as $item)
                                    <option value="{{ $item->code }}" data-price="{{ $item->price }}" data-name="{{ $item->product->product_name.' '.$item->size->size.' '.$item->size->unit->unit_code }}">{{ $item->product->product_name.' '.$item->size->size.' '.$item->size->unit->unit_code }}</option>
                                @endforeach
                                @endif
                            </x-form.selectbox>
                            <x-form.textbox labelName="No of Barcode" name="barcode_qty" required="required" col="col-md-2" class="text-center" value="1" placeholder="Enter barcode print quantity"/>
                            <x-form.textbox labelName="Qunatity Each Row " name="row_qty" required="required" col="col-md-2" class="text-center" value="1" placeholder="Enter barcode print quantity"/>
                            <div class="form-group col-md-2">
                                <label for="">Print With</label>
                                <div class="div">
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="product_name">
                                        <label class="custom-control-label" for="product_name">Product Name</label>
                                    </div>
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="price">
                                        <label class="custom-control-label" for="price">Price</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-md-3" style="padding-top:28px;">
                                <button type="button" class="btn btn-primary btn-sm" id="generate-barcode"><i class="fas fa-barcode"></i>Generate Barcode</button>
                            </div>
                        </div>
                    </form>
                    
                    <div class="row" id="barcode-section">
                        {{-- <div class="col-md-2 barcode text-center py-5">
                            {!! DNS1D::getBarcodeHTML('8941166000003', 'EAN13'); !!}
                        </div> --}}
                    </div>
                </div>
                <!--end: Datatable-->
            </div>
        </div>
        <!--end::Card-->
    </div>
</div>
@endsection

@push('scripts')
<script src="js/jquery.printarea.js"></script>
<script>
$(document).ready(function () {
    $(document).on('click','#generate-barcode',function(){
        var product       = $('#product option:selected').val();
        var product_name  = '';
        var product_price = '';
        var barcode_qty   = $('#barcode_qty').val();
        var row_qty       = $('#row_qty').val();
        if($('#product_name').prop("checked") == true){
            product_name = $('#product option:selected').data('name');
        }
        if($('#price').prop("checked") == true){
            product_price = $('#product option:selected').data('price');
        }

        $.ajax({
            url: "{{ route('generate.barcode') }}",
            type: "POST",
            data: {product:product,product_name:product_name,product_price:product_price,barcode_qty:barcode_qty,row_qty:row_qty,_token:_token},
            beforeSend: function(){
                $('#generate-barcode').addClass('spinner spinner-white spinner-right');
            },
            complete: function(){
                $('#generate-barcode').removeClass('spinner spinner-white spinner-right');
            },
            success: function (data) {
                $('#generate-barcode-form').find('.is-invalid').removeClass('is-invalid');
                $('#generate-barcode-form').find('.error').remove();
                if (data.status == false) {
                    $.each(data.errors, function (key, value) {
                        var key = key.split('.').join('_');
                        $('#generate-barcode-form input#' + key).addClass('is-invalid');
                        $('#generate-barcode-form textarea#' + key).addClass('is-invalid');
                        $('#generate-barcode-form select#' + key).parent().addClass('is-invalid');
                        $('#generate-barcode-form #' + key).parent().append(
                        '<small class="error text-danger">' + value + '</small>');
                    });
                } 
                if(data) {
                    $('#barcode-section').html('');
                    $('#barcode-section').html(data);
                }

            },
            error: function (xhr, ajaxOption, thrownError) {
                console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
            }
        });
    });

    $(document).on('click','#print-barcode',function(){
        var mode = 'iframe'; // popup
        var close = mode == "popup";
        var options = {
            mode: mode,
            popClose: close
        };
        $("#printableArea").printArea(options);
    });
});
</script>
@endpush