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
                    <button type="button" class="btn btn-primary btn-sm mr-5" onclick="store_data()" id="save-btn"><i class="fas fa-dolly-flatbed"></i> Transfer</button>
                   
                   <a href="{{ route('production') }}" class="btn btn-warning btn-sm font-weight-bolder"> 
                        <i class="fas fa-arrow-left"></i> Back</a>
                    <!--end::Button-->
                </div>
            </div>
        </div>
        <!--end::Notice-->
        <!--begin::Card-->
        <div class="card card-custom" style="padding-bottom: 100px !important;">
            <form id="store_or_update_form" method="post">
                @csrf
                <div class="card-body">
                    <div class="col-md-12">
                        <div class="row">
                            <x-form.textbox labelName="Batch No." name="batch_no" value="{{ $production->batch_no }}" property="readonly" required="required" col="col-md-3"/>
                            <x-form.textbox labelName="Chalan No." name="chalan_no" value="{{ $production->chalan_no ? $production->chalan_no : 'KEAPLTR-'.$production->id }}" property="readonly" required="required" col="col-md-3"/>
                            <x-form.textbox labelName="Transfer Date" name="transfer_date" required="required" col="col-md-3" property="readonly" class="date" value="{{ $production->transfer_date ? $production->transfer_date : date('Y-m-d') }}"/>
                            <x-form.textbox labelName="Warehouse" name="warehouse" value="{{ $production->warehouse->name }}" property="readonly" required="required" col="col-md-3"/>
                        </div> 
                    </div>
                    <div class="col-md-12 pt-5">
                        <table class="table table-bordered pb-5" id="material_table">
                            <thead class="bg-primary">
                                <th>Name</th>
                                <th class="text-center">Code</th>
                                <th class="text-center">Unit</th>
                                <th class="text-center">Base Unit</th>
                                <th class="text-center">Qty Unit</th>
                                <th class="text-center">Qty Base Unit</th>
                                <th class="text-right">Net Unit Cost</th>
                                <th class="text-right">Sub Total</th>
                            </thead>
                            <tbody>
                                @php 
                                    $total_cost = $total_unit_qty = $total_base_unit_qty = 0; 
                                @endphp
                                @if (!$production->products->isEmpty())
                                    @foreach ($production->products as $item)
                                    @php
                                    if($item->product->unit->operator == '*')
                                    {
                                        $qty_unit = $item->base_unit_qty / $item->product->unit->operation_value;
                                    }else{
                                        $qty_unit = $item->base_unit_qty * $item->product->unit->operation_value;
                                    }
                                    $total_cost += $qty_unit * $item->product->unit_price;
                                    $total_unit_qty += $qty_unit;
                                    $total_base_unit_qty += $item->base_unit_qty;
                                    @endphp
                                    <tr>
                                        <td>{{ $item->product->name }}</td>
                                        <td class="text-center">{{ $item->product->code }}</td>
                                        <td class="text-center">{{ $item->product->unit->unit_name.' ('.$item->product->unit->unit_code.')' }}</td>
                                        <td class="text-center">{{ $item->product->base_unit->unit_name.' ('.$item->product->base_unit->unit_code.')' }}</td>
                                        <td class="text-center">{{ number_format($qty_unit,2,'.','') }}</td>
                                        <td class="text-center">{{ number_format($item->base_unit_qty,2,'.','') }}</td>
                                        <td class="text-right">{{ number_format($item->product->unit_price,2,'.','') }}</td>
                                        <td class="text-right">{{ number_format(($qty_unit * $item->product->unit_price),2,'.','') }}</td>
                                    </tr>
                                    @endforeach
                                @endif
                            </tbody>
                            <tfoot>
                                <tr class="bg-primary text-white">
                                    <th colspan="7" class="text-right">Total</th>
                                    <th class="text-right">
                                        {{ number_format($total_cost,2,'.','') }}
                                        
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="col-md-12 pt-5">
                        <div class="row">
                            <x-form.selectbox labelName="Transfer Status" name="transfer_status" required="required"  col="col-md-2" class="selectpicker">
                                @foreach (TRANSFER_STATUS as $key => $value)
                                    <option value="{{ $key }}" {{ $production->transfer_status == $key ? 'selected' : '' }}>{{ $value }}</option>
                                @endforeach
                            </x-form.selectbox>
                            <x-form.textbox labelName="Shipping Cost" name="shipping_cost" value="{{ $production->shipping_cost }}" col="col-md-2"/>
                            <x-form.textbox labelName="Labor Cost" name="labor_cost" value="{{ $production->labor_cost }}" col="col-md-2"/>
                            <x-form.textbox labelName="Received By" name="received_by" value="{{ $production->received_by }}" required="required" col="col-md-3"/>
                            <x-form.textbox labelName="Carried By" name="carried_by" value="{{ $production->carried_by }}" required="required" col="col-md-3"/>
                            <x-form.textarea labelName="Remarks" name="carried_by" value="{{ $production->remarks }}" required="required" col="col-md-12"/>
                        </div>
                    </div>
                    <div class="col-md-12 pt-5">
                        <table class="table table-bordered">
                            <thead class="bg-primary">
                                <th><strong>Items</strong><span class="float-right" id="item"> 
                                    @if (!$production->products->isEmpty()) 
                                    {{ count($production->products).'('.$total_unit_qty.')'.'('.$total_base_unit_qty.')' }}
                                    @endif
                                </span></th>
                                <th><strong>Total</strong><span class="float-right" id="subtotal">{{ number_format($total_cost,2,'.','') }}</span></th>
                                <th><strong>Shipping Cost</strong><span class="float-right" id="shipping_total_cost"></span></th>
                                <th><strong>Labor Cost</strong><span class="float-right" id="labor_total_cost"></span></th>
                                <th><strong>Grand Total</strong><span class="float-right" id="grand_total">{{ number_format($total_cost,2,'.','') }}</span></th>
                            </thead>
                        </table>
                        <input type="hidden" name="total_unit_qty" id="total_unit_qty" value="{{ $total_unit_qty }}">
                        <input type="hidden" name="total_base_unit_qty" id="total_base_unit_qty" value="{{ $total_base_unit_qty }}">
                        <input type="hidden" name="total_cost" id="total" value="{{ $total_cost }}">
                        <input type="hidden" name="grand_total">
                    </div>
                </div>
            </form>
        </div>
        <!--end::Card-->
    </div>
</div>
@endsection

@push('scripts')
<script src="js/moment.js"></script>
<script src="js/bootstrap-datetimepicker.min.js"></script>
<script>
$(document).ready(function () {
    $('.date').datetimepicker({format: 'YYYY-MM-DD',ignoreReadonly: true});
    

    calculateGrandTotal();
    function calculateGrandTotal()
    {
        var subtotal       = parseFloat($('#total').val());
        var shipping_cost  = parseFloat($('#shipping_cost').val());
        var labor_cost     = parseFloat($('#labor_cost').val());

        if(!shipping_cost){
            shipping_cost = 0.00;
        }
        if(!labor_cost){
            labor_cost = 0.00;
        }
        var grand_total = (subtotal + shipping_cost + labor_cost);


        $('#subtotal').text(subtotal.toFixed(2));
        $('#shipping_total_cost').text(shipping_cost.toFixed(2));
        $('#labor_total_cost').text(labor_cost.toFixed(2));
        $('#grand_total').text(grand_total.toFixed(2));
        $('input[name="grand_total"]').val(grand_total.toFixed(2));
        
    }

    $('input[name="shipping_cost"]').on('input',function(){
        calculateGrandTotal();
    });
    $('input[name="labor_cost"]').on('input',function(){
        calculateGrandTotal();
    });
});
</script>
@endpush