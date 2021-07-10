@if (!$product->product_material->isEmpty())
<tr>
    <td>Material Name</td>
    <td>Stock Unit</td>
    <td>Stock Quantity</td>
    <td>Required Quantity <sup class="text-danger">*</sup></td>
</tr>
@foreach ($product->product_material as $key =>  $material)
<tr>
    <td>
        <div class="form-group">
            <input type="hidden" class="form-control" name="materials[{{ $key+1 }}][id]" value="{{ $material->id }}" id="materials_{{ $key+1 }}_id" >
            <input type="text" class="form-control" value="{{ $material->material_name }}"  readonly>
        </div>
    </td>
    <td>
        <div class="form-group">
            <input type="text" class="form-control text-center" name="materials[{{ $key+1 }}][unit]" id="materials_{{ $key+1 }}_unit" value="{{ $material->unit->unit_name }}" readonly>
        </div>
    </td>
    <td>
        <div class="form-group">
            <input type="text" class="form-control text-center" name="materials[{{ $key+1 }}][stock_qty]" id="materials_{{ $key+1 }}_stock_qty" value="{{ $material->qty }}" readonly>
        </div>
    </td>
    <td>
        <div class="form-group">
            <input type="text" class="form-control text-center" name="materials[{{ $key+1 }}][qty]" placeholder="0" id="materials_{{ $key+1 }}_qty" onkeyup="check_qty(this.value,'{{ $key+1 }}')">
        </div>
    </td>
</tr>
@endforeach
@endif