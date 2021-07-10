@extends('layouts.app')

@section('title','Dashboard')

@push('styels')

@endpush

@section('content')
<div class="d-flex flex-column-fluid">
    <div class="container-fluid">
        <div class="row">
            <div class="col-xl-3">
                <!--begin::Stats Widget 29-->
                <div class="card card-custom bg-primary bgi-no-repeat card-stretch gutter-b" style="background-position: right top; background-size: 30% auto; 
                background-image: url({{ asset('images/abstract-1.svg') }})">
                    <!--begin::Body-->
                    <div class="card-body">
                        <span class="svg-icon svg-icon-2x svg-icon-info"> <i class="fas fa-users  text-white"></i> </span>
                        <span class="card-title font-weight-bolder text-white-75 font-size-h2 mb-0 mt-6 d-block  text-white" id="total-customer">0</span>
                        <span class="font-weight-bold font-size-sm  text-white">Total Customers</span>
                    </div>
                    <!--end::Body-->
                </div>
                <!--end::Stats Widget 29-->
            </div>
            <div class="col-xl-3">
                <!--begin::Stats Widget 29-->
                <div class="card card-custom bgi-no-repeat bg-warning card-stretch gutter-b" style="background-position: right top; background-size: 30% auto; 
                background-image: url({{ asset('images/abstract-1.svg') }})">
                    <!--begin::Body-->
                    <div class="card-body">
                        <span class="svg-icon svg-icon-2x svg-icon-info"> <i class="fas fa-user-tie  text-white"></i> </span>
                        <span class="card-title font-weight-bolder text-white-75 font-size-h2 mb-0 mt-6 d-block  text-white"  id="total-supplier">0</span>
                        <span class="font-weight-bold font-size-sm  text-white">Total Suppliers</span>
                    </div>
                    <!--end::Body-->
                </div>
                <!--end::Stats Widget 29-->
            </div>
            <div class="col-xl-3">
                <!--begin::Stats Widget 29-->
                <div class="card card-custom bgi-no-repeat bg-success card-stretch gutter-b" style="background-position: right top; background-size: 30% auto; 
                background-image: url({{ asset('images/abstract-1.svg') }})">
                    <!--begin::Body-->
                    <div class="card-body">
                        <span class="svg-icon svg-icon-2x svg-icon-info"> <i class="fab fa-opencart  text-white"></i> </span>
                        <span class="card-title font-weight-bolder text-white-75 font-size-h2 mb-0 mt-6 d-block  text-white"  id="total-sale">0Tk</span>
                        <span class="font-weight-bold font-size-sm  text-white">Total Sale</span>
                    </div>
                    <!--end::Body-->
                </div>
                <!--end::Stats Widget 29-->
            </div>
            <div class="col-xl-3">
                <!--begin::Stats Widget 29-->
                <div class="card card-custom bgi-no-repeat bg-danger card-stretch gutter-b" style="background-position: right top; background-size: 30% auto; 
                background-image: url({{ asset('images/abstract-1.svg') }})">
                    <!--begin::Body-->
                    <div class="card-body">
                        <span class="svg-icon svg-icon-2x svg-icon-info"> <i class="fas fa-cart-arrow-down text-white"></i> </span>
                        <span class="card-title font-weight-bolder text-white-75 font-size-h2 mb-0 mt-6 d-block  text-white"  id="total-purchase">0Tk</span>
                        <span class="font-weight-bold font-size-sm  text-white">Total Purchase</span>
                    </div>
                    <!--end::Body-->
                </div>
                <!--end::Stats Widget 29-->
            </div>
        </div>

    </div>
</div>
@endsection

@push('scripts')
<script>
show_data();
function show_data(value='') {
    $.ajax({
        url: "{{route('dashboard.data')}}",
        type: "POST",
        data: {value:value,_token:"{{ csrf_token() }}"},
        dataType: "JSON",
        success: function (data) {
            data.total_customer ? $("#total-customer").text(data.total_customer) : $("#total-customer").text('0');
            data.total_supplier ? $("#total-supplier").text(data.total_supplier) : $("#total-supplier").text('0');
            data.total_sale ? $("#total-sale").text(number_format(data.total_sale+'TK')) : $("#total-sale").text('0.00Tk');
            data.total_purchase ? $("#total-purchase").text(number_format(data.total_purchase+'Tk')) : $("#total-purchase").text('0.00Tk');
        },
        error: function (xhr, ajaxOption, thrownError) {
            console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
        }
    });
}
</script>
@endpush
