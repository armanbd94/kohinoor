@extends('layouts.app')

@section('title', $page_title)

@push('styles')
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
<style>
    .tox-tinymce{
        height: 300px !important;
    }
    .heading{
        background: rgba(235, 236, 245, 0.5);
        border-left: 5px solid #034d97;
        padding: 10px;
    }
    .warning-text{

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
                    <a href="{{ route('production') }}" class="btn btn-warning btn-sm font-weight-bolder"> 
                        <i class="fas fa-arrow-left"></i> Back</a>
                    <!--end::Button-->
                </div>
            </div>
        </div>
        <!--end::Notice-->
        <!--begin::Card-->
        <div class="card card-custom">
            <div class="card-body" style="padding-bottom: 100px !important;">
                <!--begin: Datatable-->
                <div id="kt_datatable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer pb-5">
                    <p class="text-danger">(All * mark fields are required)</p>
                    <form id="store_or_update_form" method="post" enctype="multipart/form-data">
                        @csrf
                        <div class="row pb-5">
                            <input type="hidden" name="update_id" id="update_id" value="" />
                            <input type="hidden" name="warehouse_id" id="warehouse_id" value="1" />
                            <div class="col-md-12"> 
                                <div class="row">
                                    <div class="form-group col-md-4 required">
                                        <label for="batch_no">Batch No.</label>
                                        <input type="text" class="form-control" name="batch_no" id="batch_no" value="{{ $batch_no }}" readonly>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label for="start_date">Start Date</label>
                                        <input type="text" class="form-control date" name="start_date" id="start_date" value="{{ date('Y-m-d') }}" readonly />
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 pt-5">
                                <h4 class="heading">Product</h4>
                                <div class="row">
                                    <div class="form-group col-md-4 required">
                                        <label for="product_id" class="form-control-label">Product Name</label>
                                        <select name="product_id" id="product_id" required="required" class="form-control selectpicker" data-live-search="true" 
                                        data-live-search-placeholder="Search">
                                            <option value="">Select Please</option>
                                            @if (!$products->isEmpty())
                                                @foreach ($products as $product)
                                                    <option value="{{ $product->id }}">{{ $product->product_name }}</option>
                                                @endforeach 
                                            @endif
                                        </select>
                                    </div>
                                    <x-form.textbox labelName="Manufacturing Date" name="mfg_date" id="products_mfg_date" class="date mfg_date" required="required" col="col-md-4" />
                                    <x-form.textbox labelName="Expiration Date" name="exp_date" id="products_exp_date" class="date exp_date" required="required" col="col-md-4" />

                                    <div class="col-md-12 variant_section">
                                        
                                        
                                    </div>
                               </div>
                               
                            </div>

                            <div class="col-md-12 material_section pt-5 d-none">
                                <h4 class="heading">Materials</h4>
                                <table class="table table-borderless">
                                    <tbody></tbody>
                                </table>
                            </div>
                            <div class="form-group col-md-12">
                                <label for="description">Description</label>
                                <textarea class="form-control" name="description" id="description" style="height: 200px;"></textarea>
                            </div>
                            <div class="form-grou col-md-12 text-center pt-5">
                                <button type="button" class="btn btn-danger btn-sm mr-3"><i class="fas fa-sync-alt"></i> Reset</button>
                                <button type="button" class="btn btn-primary btn-sm mr-3" id="save-btn" onclick="store_data()"><i class="fas fa-save"></i> Save</button>
                            </div>
                        </div>
                    </form>
                </div>
                <!--end: Datatable-->
            </div>
        </div>
        <!--end::Card-->
    </div>
</div>
@endsection

@push('scripts')
<script src="js/bootstrap-datetimepicker.min.js"></script>
{{-- <script src='https://cdn.tiny.cloud/1/xbwyjdvo6tgahz14jep9xp3cg986wbz63a3ibrm6e5rl2nf2/tinymce/5/tinymce.min.js' referrerpolicy="origin"></script> --}}
<script>
var material_count = 1;

$(document).ready(function () {
    $('.date').datetimepicker({format: 'YYYY-MM-DD',ignoreReadonly: true});
    $('.coupon_expiration_date').datetimepicker({format: 'YYYY-MM-DD',ignoreReadonly: true});
    $(".mfg_date").on("dp.change", function (e) {
        $('.exp_date').data("DateTimePicker").minDate(e.date);
    });
    $(".exp_date").on("dp.change", function (e) {
        $('.mfg_date').data("DateTimePicker").maxDate(e.date);
    });

    // tinymce.init({
    //     selector: 'textarea#description',
    //     height: 100,
    // });

    $('#product_id').change(function(){
        var product_id = $('#product_id option:selected').val();
        if(product_id){
            $.ajax({
                url: "{{ route('production.product.variants') }}",
                type: "POST",
                data: {product_id:product_id,_token:_token},
                success: function (data) {
                    if(data)
                    {
                        $('.variant_section').html('');
                        $('.variant_section').html(data);
                        
                    }else{
                        $('.variant_section').html('');
                    }
                    $('.variant_section .coupon_expiration_date').datetimepicker({format: 'YYYY-MM-DD',ignoreReadonly: true});
                },
                error: function (xhr, ajaxOption, thrownError) {
                    console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
                }
            });
            $.ajax({
                url: "{{ route('product.wise.materials') }}",
                type: "POST",
                data: {product_id:product_id,_token:_token},
                success: function (data) {
                    if(data)
                    {
                        $('.material_section').removeClass('d-none');
                        $('.material_section table tbody').html('');
                        $('.material_section table tbody').html(data);
                        
                    }else{
                        $('.material_section').addClass('d-none');
                        $('.material_section table tbody').html('');
                    }
                },
                error: function (xhr, ajaxOption, thrownError) {
                    console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
                }
            });
        }
    });
    $(document).on('click','.remove_variant',function(){
        $(this).closest('.variant_remove').remove();
    });
    
    
});

function generate_variant_coupon_code(row)
{
    $.get('production/generate-coupon-code', function(data){
            $("#store_or_update_form #variants_"+row+"_coupon_code").val(data);
    });
}


function check_qty(value,id)
{
    var stock_qty = parseFloat($('#materials_'+id+'_stock_qty').val());
    if(value && stock_qty)
    {
        if(value > stock_qty){
            notification('error','Required quantity cannot be greater than stock quantity');
            $('#materials_'+id+'_qty').val(stock_qty);
        }
    }
    
}
function store_data(){
    // tinyMCE.triggerSave();
    let form = document.getElementById('store_or_update_form');
    let formData = new FormData(form);
    let url = "{{route('production.store.or.update')}}";
    let id = $('#store_or_update_form #update_id').val();
    let method;
    if (id) {
        method = 'update';
    } else {
        method = 'add';
    }
    $.ajax({
        url: url,
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
            $('#store_or_update_form').find('.is-invalid').removeClass('is-invalid');
            $('#store_or_update_form').find('.error').remove();
            if (data.status == false) {
                $.each(data.errors, function (key, value) {
                    var key = key.split('.').join('_');
                    $('#store_or_update_form input#' + key).addClass('is-invalid');
                    $('#store_or_update_form textarea#' + key).addClass('is-invalid');
                    $('#store_or_update_form select#' + key).parent().addClass('is-invalid');
                    $('#store_or_update_form #' + key).parent().append(
                        '<small class="error text-danger">' + value + '</small>');
                });
            } else {
                notification(data.status, data.message);
                if (data.status == 'success') {
                    window.location.replace("{{ url('production/view') }}/"+data.production_id);
                    
                }
            }

        },
        error: function (xhr, ajaxOption, thrownError) {
            console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
        }
    });
}

</script>
@endpush