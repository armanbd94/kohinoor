<div class="col-md-12 pb-5">
@if (permission('production-material-deliver'))
    @if (!empty($production) && ($production->material_delivered_status != 2))
        <button type="button" class="btn btn-primary btn-sm float-right" id="show-material-form">Material Delivery</button>   
    @endif
@endif
@if (permission('production-material-receive'))
    @if (!empty($production) && ($production->material_delivered_status != 1) && ($production->material_received_status != 1) && ($production->material_returned != 1))
    <button type="button" class="btn btn-primary btn-sm float-right" id="show-material-return-form"><i class="fas fa-arrow-up"></i> Return Material</button>  
    @endif
    @if (!empty($production) && ($production->material_delivered_status != 1) && ($production->material_received_status != 2))
        <button type="button" class="btn btn-primary btn-sm float-right mr-3" id="show-material-receive-form"><i class="fas fa-arrow-down"></i> Material Receive</button>   
    @endif
@endif
</div>
@if (!empty($production))
    <div class="col-md-12">
        <table class="table table-borderless">
            <tr>
                <td><b>Delivered By:</b> {{ $production->material_delivered_by }}</td>
                <td class="text-right"><b>Received By:</b> {{ $production->material_received_by }}</td>
            </tr>
            <tr>
                <td><b>Delivered Time:</b> {{ $production->material_delivered_datetime ? date('d-M-Y h:i:s A',strtotime($production->material_delivered_datetime)) : '' }}</td>
                <td class="text-right"><b>Received Time:</b> {{ $production->material_received_datetime ? date('d-M-Y h:i:s A',strtotime($production->material_received_datetime)) : '' }}</td>
            </tr>
            <tr>
                <td><b>Delivery Status:</b> {!! PRODUCTION_MATERIAL_DELIVERY_LABEL[$production->material_delivered_status] !!}</td> 
                <td class="text-right"><b>Receive Status:</b> @if($production->material_received_by) {!! PRODUCTION_MATERIAL_RECEIVE_LABEL[$production->material_received_status] !!} @endif</td>
            </tr>
        </table>                                          
    </div>
@endif
<div class="col-md-12">
    <table class="table table-bordered table-hovered">
        <thead class="bg-primary">
            <th>Material</th>
            <th class="text-center">Unit</th>
            <th class="text-center">Current Stock</th>
            <th class="text-center">Ordered Qty</th>
            <th class="text-center">Delivered Qty</th>
            <th class="text-center">Received Qty</th>
            <th class="text-center">Used Qty</th>
            <th class="text-center">Damaged Qty</th>
            <th class="text-center">Odd Qty</th>
        </thead>
        <tbody>
            @if (!$production_materials->isEmpty())
            @foreach ($production_materials as $production_material)
            <tr>
                <td>{{ $production_material->material->material_name.' - '.$production_material->material->material_code }}</td>
                <td class="text-center">{{ $production_material->material->unit->unit_name }}</td>
                <td class="text-center">{{ $production_material->material->qty ? $production_material->material->qty : 0 }}</td>
                <td class="text-center">{{ $production_material->required_qty ? $production_material->required_qty : 0 }}</td>
                <td class="text-center">{{ $production_material->delivered_qty ? $production_material->delivered_qty : 0 }}</td>
                <td class="text-center">{{ $production_material->received_qty ? $production_material->received_qty : 0 }}</td>
                <td class="text-center">{{ $production_material->used_qty ? $production_material->used_qty : 0 }}</td>
                <td class="text-center">{{ $production_material->damaged_qty ? $production_material->damaged_qty : 0 }}</td>
                <td class="text-center">{{ ($production_material->received_qty - ($production_material->used_qty + $production_material->damaged_qty)) }}</td>
                
            </tr>
            @endforeach
            @else 
            <tr>
                <td colspan="8" class="text-danger">No Material List Found</td>
            </tr>
            @endif
        </tbody>
    </table>
</div>

