@if (!$production_materials->isEmpty())
    @foreach ($production_materials as $key => $production_material)
    @php
    $used_qty =  $production_material->used_qty ? $production_material->used_qty : 0;   
    $damaged_qty =  $production_material->damaged_qty ? $production_material->damaged_qty : 0;   
    $received_qty = $production_material->received_qty ? $production_material->received_qty : 0;
    $odd_qty = $received_qty - ($used_qty + $damaged_qty );
    @endphp
    <tr>
        <td>{{ $production_material->material->material_name.' - '.$production_material->material->material_code }}</td>
        <td class="text-center">{{ $production_material->material->unit->unit_name }}</td>
        <td class="text-center">{{ $production_material->material->qty }}</td>
        <td class="text-center">{{ $received_qty }}</td>
        <td class="text-center">
            <input type="text" class="form-control text-center" name="return_material[{{ $key + 1 }}][used_qty]" id="return_material_{{ $key + 1 }}_used_qty" value="{{ $used_qty }}" readonly>
            <input type="hidden" class="form-control" name="return_material[{{ $key + 1 }}][id]" value="{{ $production_material->id }}">
        </td>
        <td class="text-center">
            <input type="text" class="form-control text-center" name="return_material[{{ $key + 1 }}][damaged_qty]" id="return_material_{{ $key + 1 }}_damaged_qty" value="{{ $damaged_qty }}" readonly>
        </td>
        <td class="text-center">
            <input type="text" class="form-control text-center" name="return_material[{{ $key + 1 }}][odd_qty]" id="return_material_{{ $key + 1 }}_odd_qty" value="{{ $odd_qty }}" readonly>
        </td>
    </tr>
    @endforeach
@endif