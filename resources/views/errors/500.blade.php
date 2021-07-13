@extends('layouts.app')

@section('title','500')

@push('styles')

@endpush

@section('content')
<section class="background-light-grey padding-tt-50px padding-tb-50px text-center text-lg-left">
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col-lg-7 text-center">
                <h1 class="error-404 m-0 font-2 pull-top-40px text-main-color font-weight-700">500</h1>
                <h3 class="m-0 font-weight-bolder pb-3">Internal Server Error</h3>
                <div class="text-center"><a href="{{ url('/') }}" class="btn btn-md text-white background-main-color border-0 padding-lr-25px" style="border-radius: 30px;">Go Home</a></div>
            </div>
        </div>
    </div>
</section>
@endsection
