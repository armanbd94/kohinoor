@extends('layouts.app')

@section('title', $page_title)

@push('styles')
<style>
    .tox-tinymce{
        height: 300px !important;
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
                    <a href="{{ route('product') }}" class="btn btn-warning btn-sm font-weight-bolder"> 
                        <i class="fas fa-arrow-left"></i> Back</a>
                    <!--end::Button-->
                </div>
            </div>
        </div>
        <!--end::Notice-->
        <!--begin::Card-->
        <div class="card card-custom" style="padding-bottom: 100px !important;">
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
                            <a class="nav-link" data-toggle="tab" href="#kt_tab_materials">
                                <span class="nav-icon"><i class="fas fa-toolbox"></i></span>
                                <span class="nav-text">Materials</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#kt_tab_variants">
                                <span class="nav-icon"><i class="fas fa-box"></i></span>
                                <span class="nav-text">Variants</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="card-body">
                <form id="store_or_update_form" method="post" enctype="multipart/form-data">
                    @csrf
                    <input type="hidden" name="update_id" id="update_id" value="{{ isset($product) ? $product->id : '' }}" />
                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="kt_tab_general" role="tabpanel" aria-labelledby="kt_tab_general">
                            <div class="row">
                                <div class="col-md-9">
                                    <table class="table table-borderless table-hover">
                                        <tr><td width="25%"><b>Name</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ $product->product_name }}</td></tr>
                                        <tr><td width="25%"><b>Type</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ PRODUCT_TYPE[$product->type] }}</td></tr>
                                        <tr><td width="25%"><b>Category</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ $product->category->name }}</td></tr>
                                        <tr><td width="25%"><b>Tax</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ $product->tax->rate }}%</td></tr>
                                        <tr><td width="25%"><b>Tax Method</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ TAX_METHOD[$product->tax_method] }}</td></tr>
                                        <tr><td width="25%"><b>Description</b></td> <td  width="2%" class="text-center"><b>:</b></td> <td>{{ $product->description }}</td></tr>
                                    </table>
                                </div>
                                <div class="col-md-3">
                                    @if (!empty($product->product_image))
                                    <img src="{{ asset('storage/'.PRODUCT_IMAGE_PATH.$product->product_image) }}" alt="{{ $product->product_name }}" style="width: 100%;">
                                    @endif
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="kt_tab_materials" role="tabpanel" aria-labelledby="kt_tab_materials">
                            <div class="row">
                                <div class="col-md-12">
                                    <ol>
                                        @if (!$product->product_material->isEmpty())
                                            @foreach ($product->product_material as $item)
                                                <li>{{ $item->material_name }}</li>
                                            @endforeach
                                        @endif
                                    </ol>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="kt_tab_variants" role="tabpanel" aria-labelledby="kt_tab_variants">
                            <div class="row">
                                <div class="col-md-12 variants_section">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <table class="table table-bordered">
                                                <thead class="bg-primary">
                                                    <th>Size</th>
                                                    <th>Barcode</th>
                                                    <th class="text-center">Unit</th>
                                                    <th class="text-center">Sale Unit</th>
                                                    <th class="text-right">Cost</th>
                                                    <th class="text-right">Sale Price</th>
                                                    <th class="text-center">Qty</th>
                                                    <th class="text-center">Alert Qty</th>
                                                </thead>
                                                <tbody>
                                                    @if (!$product->product_size->isEmpty())
                                                        @foreach ($product->finish_goods as $key => $value)
                                                        <tr class="{{ ($key == 0) ? '' : 'variant_remove' }}">
                                                            <td width="10%">{{ $value->size->size.' '.$value->size->unit->unit_name }}</td>
                                                            <td width="15%">{{ $value->code }}</td>
                                                            <td class="text-center" width="10%">{{ $value->unit->unit_name }}</td>
                                                            <td class="text-center" width="10%">{{ $value->sale_unit->unit_name }}</td>
                                                            <td class="text-right" width="15%">{{ number_format($value->cost,2) }}</td>
                                                            <td class="text-right" width="10%">{{ number_format($value->price,2) }}</td>
                                                            <td class="text-center"  width="10%">{{ $value->qty }}</td>
                                                            <td class="text-center" width="10%"> {{ $value->alert_qty }}</td>
                                                        </tr>
                                                        @endforeach
                                                    @endif
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!--end::Card-->
    </div>
</div>
@endsection
