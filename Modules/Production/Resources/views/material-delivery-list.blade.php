@if (!$production_materials->isEmpty())
    @foreach ($production_materials as $key => $production_material)
    <tr>
        <td>{{ $production_material->material->material_name.' - '.$production_material->material->material_code }}</td>
        <td class="text-center">{{ $production_material->material->unit->unit_name }}</td>
        <td class="text-center">{{ $production_material->material->qty }}</td>
        <td class="text-center">{{ $production_material->required_qty }}</td>
        <td class="text-center">
            <input type="text" class="form-control text-center" value="{{ $production_material->required_qty }}" name="delivry_material[{{ $key + 1 }}][delivered_qty]" id="delivry_material_{{ $key + 1 }}_delivered_qty">
            <input type="hidden" class="form-control" name="delivry_material[{{ $key + 1 }}][id]" value="{{ $production_material->id }}">
            <input type="hidden" class="form-control" name="delivry_material[{{ $key + 1 }}][old_delivered_qty]" value="{{ $production_material->delivered_qty ? $production_material->delivered_qty : 0 }}">
            <input type="hidden" class="form-control" name="delivry_material[{{ $key + 1 }}][material_id]" value="{{ $production_material->material_id }}">
        </td>
    </tr>
    @endforeach
@endif