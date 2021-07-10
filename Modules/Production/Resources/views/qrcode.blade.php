@extends('layouts.app')

@section('title', $page_title)

@push('styles')

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
                    <a href="{{ route('production') }}" class="btn btn-primary btn-sm font-weight-bolder"> 
                        <i class="fas fa-arrow-left"></i> Production Manage</a>
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
                    <div class="d-flex justify-content-center align-items-center" style="border:1px solid #ddd;box-sizing:border-box;width: 150px;height:150px;background-image:url({{ asset('storage/'.LOGO_PATH.config('settings.logo')) }});background-repeat:space;background-size:30px 30px;background-origin: content-box;">
                        <div class="d-flex justify-content-center align-items-center" style="width: 120px;height:110px;background:white;">
                            {!! QrCode::size(100)->generate('Batch:1001;Code:9874563;ExpDate:10-Jan-2020'); !!}
                        </div>
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
<script>
$(document).ready(function () {


});
</script>
@endpush