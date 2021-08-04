@extends('layouts.app')

@section('title', $page_title)

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
                    <a href="{{ route('adjustment') }}" class="btn btn-warning btn-sm font-weight-bolder"> 
                        <i class="fas fa-arrow-left"></i> Back</a>
                    <!--end::Button-->
                </div>
            </div>
        </div>
        <!--end::Notice-->
        <!--begin::Card-->
        <div class="card card-custom">
            <div class="card-body">
                <!--begin: Datatable-->
                <div id="kt_datatable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
                    <div class="row">
                        <input type="hidden" name="adjustment_id" value="{{ $adjustment->id }}">

                        <div class="col-md-12 text-center">
                            <h6>Adjustment No.: {{ $adjustment->adjustment_no }}</h6>
                        </div>

                        <div class="col-md-12">
                            <table class="table table-bordered" id="product_table">
                                <thead class="bg-primary">
                                    <th width="40%">Name</th>
                                    <th  width="15%" class="text-center">Code</th>
                                    <th width="10%" class="text-center">Unit</th>
                                    <th width="10%" class="text-center">Quantity</th>
                                    <th width="15%" class="text-center">Action</th>
                                </thead>
                                <tbody>
                                    @php
                                        $temp_unit_name = [];
                                    @endphp
                                    @if (!$adjustment->products->isEmpty())
                                        @foreach ($adjustment->products as $key => $adjustment_product)
                                            <tr>
                                                <td>{{ !empty($adjustment_product->product_variant_id) ? $adjustment_product->product->name.' - ('.$adjustment_product->product_variant->item_name.')' : $adjustment_product->product->name }}</td>
                
                                                <td class="text-center">{{ !empty($adjustment_product->product_variant_id) ? $adjustment_product->product_variant->item_code :  $adjustment_product->product->code }}</td>
                                                <td class="unit-name text-center">{{ $adjustment_product->product->unit->unit_name }}</td>
                                                <td class="text-center">{{ $adjustment_product->qty }}</td>

                                                <td class="text-center"> {{ $adjustment_product->action == '+' ? 'Addition' : 'Subtraction' }}</td>
                                            </tr>
                                        @endforeach
                                    @endif
                                </tbody>
                                <tfoot class="bg-primary">
                                    <th colspan="3" class="font-weight-bolder">Total</th>
                                    <th id="total-qty" class="text-center font-weight-bolder">{{ $adjustment->total_qty }}</th>
                                    <th></th>
                                </tfoot>
                            </table>
                        </div>

                        <div class="form-group col-md-12">
                            <label for="shipping_cost">Note</label>
                            <p>{{ $adjustment->note }}</p>
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
