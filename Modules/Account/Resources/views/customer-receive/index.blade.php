@extends('layouts.app')

@section('title', $page_title)

@push('styles')
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
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
                
            </div>

        </div>
        <!--end::Notice-->
        <!--begin::Card-->
        <div class="card card-custom">
            <div class="card-body">
                <!--begin: Datatable-->
                <div id="kt_datatable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
                    <form id="customer-receive-form" method="post">
                        @csrf
                        <div class="row">
                            <div class="form-group col-md-6 required">
                                <label for="voucher_no">Voucher No</label>
                                <input type="text" class="form-control" name="voucher_no" id="voucher_no" value="{{ $voucher_no }}" readonly />
                            </div>
                            <div class="form-group col-md-6 required">
                                <label for="voucher_date">Date</label>
                                <input type="text" class="form-control date" name="voucher_date" id="voucher_date" value="{{ date('Y-m-d') }}" readonly />
                            </div>
                            <x-form.selectbox labelName="Warehouse" name="warehouse_id" required="required"  col="col-md-6" class="selectpicker">
                                @if (!$warehouses->isEmpty())
                                @foreach ($warehouses as $warehouse)
                                    <option value="{{ $warehouse->id }}">{{ $warehouse->name }}</option>
                                @endforeach
                                @endif
                            </x-form.selectbox>
                            <x-form.selectbox labelName="District" name="district_id" required="required" onchange="getUpazilaList(this.value)" col="col-md-6" class="selectpicker">
                                @if (!$districts->isEmpty())
                                @foreach ($districts as $district)
                                    <option value="{{ $district->id }}">{{ $district->name }}</option>
                                @endforeach
                                @endif
                            </x-form.selectbox>
                            <x-form.selectbox labelName="Upazila" name="upazila_id" required="required" onchange="getRouteList(this.value)"  col="col-md-6" class="selectpicker"/>
                            <x-form.selectbox labelName="Route" name="route_id" required="required"  onchange="getCustomerList(this.value)"  col="col-md-6" class="selectpicker"/>
                            <x-form.selectbox labelName="Customer" name="customer_id" required="required"  col="col-md-6" class="selectpicker"/>
                            <x-form.selectbox labelName="Payment Type" name="payment_type" required="required"  col="col-md-6" class="selectpicker">
                                @foreach (SALE_PAYMENT_METHOD as $key => $value)
                                <option value="{{ $key }}">{{ $value }}</option>
                                @endforeach
                            </x-form.selectbox>
                            <x-form.selectbox labelName="Account" name="account_id" required="required"  col="col-md-6" class="selectpicker"/>
                            <x-form.textbox labelName="Amount" name="amount" required="required" col="col-md-6" placeholder="0.00"/>
                            <x-form.textarea labelName="Remarks" name="remarks" col="col-md-12"/>
                            <div class="form-group col-md-12 pt-5">
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
<script>
$('.date').datetimepicker({format: 'YYYY-MM-DD',ignoreReadonly: true});
$(document).on('change', '#payment_type', function () {
    $.ajax({
        url: "{{route('account.list')}}",
        type: "POST",
        data: { payment_method: $('#payment_type option:selected').val(),_token: _token},
        success: function (data) {
            $('#customer-receive-form #account_id').html('');
            $('#customer-receive-form #account_id').html(data);
            $('#customer-receive-form #account_id.selectpicker').selectpicker('refresh');
        },
        error: function (xhr, ajaxOption, thrownError) {
            console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
        }
    });
});
function store_data(){
    let form = document.getElementById('customer-receive-form');
    let formData = new FormData(form);
    let url = "{{url('customer-receive')}}";
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
            $('#customer-receive-form').find('.is-invalid').removeClass('is-invalid');
            $('#customer-receive-form').find('.error').remove();
            if (data.status == false) {
                $.each(data.errors, function (key, value) {
                    var key = key.split('.').join('_');
                    $('#customer-receive-form input#' + key).addClass('is-invalid');
                    $('#customer-receive-form textarea#' + key).addClass('is-invalid');
                    $('#customer-receive-form select#' + key).parent().addClass('is-invalid');
                    $('#customer-receive-form #' + key).parent().append(
                        '<small class="error text-danger">' + value + '</small>');
                });
            } else {
                notification(data.status, data.message);
                if (data.status == 'success' && data.supplier_transaction != '') {

                    window.location.replace("{{ url('customer-receive') }}/"+data.customer_transaction+'/'+$('#payment_type option:selected').val());
                    
                }
            }

        },
        error: function (xhr, ajaxOption, thrownError) {
            console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
        }
    });
}

function getUpazilaList(district_id){
    $.ajax({
        url:"{{ url('district-id-wise-upazila-list') }}/"+district_id,
        type:"GET",
        dataType:"JSON",
        success:function(data){
            html = `<option value="">Select Please</option>`;
            $.each(data, function(key, value) {
                html += '<option value="'+ key +'">'+ value +'</option>';
            });
            $('#upazila_id').empty();
            $('#upazila_id').append(html);
            $('.selectpicker').selectpicker('refresh');
        },
    });
}
function getRouteList(upazila_id){
    $.ajax({
        url:"{{ url('upazila-id-wise-route-list') }}/"+upazila_id,
        type:"GET",
        dataType:"JSON",
        success:function(data){
            html = `<option value="">Select Please</option>`;
            $.each(data, function(key, value) {
                html += '<option value="'+ key +'">'+ value +'</option>';
            });
            $('#route_id').empty();
            $('#route_id').append(html);
            $('.selectpicker').selectpicker('refresh');
        },
    });
}
function getCustomerList(route_id){
    $.ajax({
        url:"{{ url('route-id-wise-customer-list') }}",
        type:"POST",
        data:{route_id:route_id,_token:_token},
        success:function(data){
            $('#customer_id').empty();
            $('#customer_id').append(data);
            $('.selectpicker').selectpicker('refresh');
        },
    });
}
</script>
@endpush