<input type="hidden" name="production_finished_good_id" value="{{ $data->id }}">
<div class="form-group col-md-6 required">
    <label for="production_qty">Production Quantity</label>
    <div class="input-group">
        <input type="text" class="form-control" name="production_qty" id="production_qty" value="{{ $data->qty }}">
        <div class="input-group-append">
            <span class="input-group-text bg-primary text-white" id="production_unit">{{ $data->finished_goods->unit->unit_name }}</span>
        </div>
    </div>
    
</div>
<div class="col-md-12">
    <table class="table table-bordered"id="finished-goods-material-list">
        <thead class="bg-primary">
            <th width="25%">Material</th>
            <th width="10%" class="text-center">Unit</th>
            <th width="15%" class="text-center">Remaining Qty</th>
            <th width="10%" class="text-center">Total Qty</th>
            <th width="10%" class="text-center">Used Qty</th>
            <th width="10%" class="text-center">Damage Qty</th>
            <th width="10%" class="text-center">Odd Qty</th>
        </thead>
        <tbody>
            @if (!$data->finished_goods_materials->isEmpty())
                @foreach ($data->finished_goods_materials as $key => $item)
                @php
                $production_material = DB::table('production_materials')->where(['production_id'=>$item->production_id,
                'material_id'=>$item->material_id,])->first();
                @endphp
                    <tr>
                        <td>{{ $item->material->material_name }}</td>
                        <td>{{ $item->material->unit->unit_name }}</td>
                        <td class="text-center">{{ $production_material ? ($production_material->received_qty - ($production_material->used_qty + $production_material->damaged_qty)) : '' }}</td>
                        <td>
                            <input type="hidden" name="materials[{{ $key+1 }}][id]" id="materials_{{ $key+1 }}_id" value="{{ $item->id }}">
                            <input type="hidden" name="materials[{{ $key+1 }}][cost]" id="materials_{{ $key+1 }}_cost" value="{{ $item->material->purchase_price }}">
                            <input type="hidden" name="materials[{{ $key+1 }}][direct_cost]" id="materials_{{ $key+1 }}_direct_cost" value="{{ ($production_material->used_qty + $production_material->damaged_qty) * $item->material->purchase_price}}">
                            <input type="hidden" name="materials[{{ $key+1 }}][remaining_qty]" id="materials_{{ $key+1 }}_remaining_qty" value="{{ $production_material ? ($production_material->received_qty - ($production_material->used_qty + $production_material->damaged_qty)) : 0 }}">
                            <input type="text" class="form-control total_qty text-center" onkeyup="material_calculation('{{ $key+1 }}')" data-key="{{ $key+1 }}" name="materials[{{ $key+1 }}][total_qty]" id="materials_{{ $key+1 }}_total_qty" value="{{ $item->total_qty }}">
                            <input type="hidden" name="materials[{{ $key+1 }}][reupdate]" value="{{ $item->total_qty ? 1 : 2 }}">
                        </td>
                        <td>
                            <input type="text" class="form-control used_qty text-center" onkeyup="material_calculation('{{ $key+1 }}')" data-key="{{ $key+1 }}" name="materials[{{ $key+1 }}][used_qty]" id="materials_{{ $key+1 }}_used_qty" value="{{ $item->used_qty }}">
                        </td>
                        <td>
                            <input type="text" class="form-control damaged_qty text-center" onkeyup="material_calculation('{{ $key+1 }}')" data-key="{{ $key+1 }}" name="materials[{{ $key+1 }}][damaged_qty]" id="materials_{{ $key+1 }}_damaged_qty" value="{{ $item->damaged_qty }}">
                        </td>
                        <td>
                            <input type="text" class="form-control odd_qty text-center" data-key="{{ $key+1 }}" name="materials[{{ $key+1 }}][odd_qty]" id="materials_{{ $key+1 }}_odd_qty" value="{{ $item->odd_qty }}" readonly>
                        </td>
                    </tr>
                @endforeach
            @endif
        </tbody>
    </table>
</div>