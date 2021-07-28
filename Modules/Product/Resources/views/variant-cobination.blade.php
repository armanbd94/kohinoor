@if (!empty($combinations) && count($combinations) > 0)
    @foreach ($combinations as $key => $value)
    @if(!empty($product_id))
        @php 
        $variant_exist = \DB::table('product_variants')->where([['product_id',$product_id],['item_name',implode('-',$value)]])->count();
        @endphp
        @if($variant_exist == 0)
        <tr class="variant-row">
            <td>
                <div class="form-group mb-0">
                <input type="text" class="form-control" name="variants[{{ $key+1 }}][name]" value="{{ implode('-',$value) }}">
                <input type="hidden" class="form-control" name="variants[{{ $key+1 }}][id]">
                </div>
            </td>
            <td>
                <div class="form-group mb-0">
                    <div class="input-group" id="code_section">
                        <input type="text" class="form-control text-center" name="variants[{{ $key+1 }}][code]" id="variants_{{ $key+1 }}_code" data-row="{{ $key+1 }}">
                        <div class="input-group-prepend">
                            <span class="input-group-text bg-primary" id="generate-{{ $key+1 }}-code" onclick="generate_variants_code('{{ $key+1 }}')"  data-toggle="tooltip" data-theme="dark" title="Generate Code"
                            style="border-top-right-radius: 0.42rem;border-bottom-right-radius: 0.42rem;border:0;cursor: pointer;">
                                <i class="fas fa-retweet text-white"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </td>
            <td>
                <div class="form-group mb-0">
                    <select name="variants[{{ $key+1 }}][item_base_unit_id]" id="variants_{{ $key+1 }}_item_base_unit_id" data-row="{{ $key+1 }}"  onchange="populate_unit(this.value,2,'{{ $key+1 }}')" class="form-control selectpicker" data-live-search="true"  data-live-search-placeholder="Search">
                        <option value="">Select Please</option>
                        @if (!$units->isEmpty())
                            @foreach ($units as $unit)
                                @if ($unit->base_unit == null)
                                <option value="{{ $unit->id }}">{{ $unit->unit_name.' ('.$unit->unit_code.')' }}</option>
                                @endif
                            @endforeach
                        @endif
                    </select>
                </div>
            </td>
            <td>
                <div class="form-group mb-0">
                    <select name="variants[{{ $key+1 }}][item_unit_id]" id="variants_{{ $key+1 }}_item_unit_id" data-row="{{ $key+1 }}"  class="form-control selectpicker" data-live-search="true"  data-live-search-placeholder="Search"></select>
                </div>
            </td>
            <td>
                <div class="form-group mb-0">
                <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_base_unit_mrp]" id="variants_{{ $key+1 }}_item_base_unit_mrp" data-row="{{ $key+1 }}">
                </div>
            </td>
            <td>
                <div class="form-group mb-0">
                <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_base_unit_price]" id="variants_{{ $key+1 }}_item_base_unit_price" data-row="{{ $key+1 }}">
                </div>
            </td>
            <td>
                <div class="form-group mb-0">
                <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_unit_mrp]" id="variants_{{ $key+1 }}_item_unit_mrp" data-row="{{ $key+1 }}">
                </div>
            </td>
            <td>
                <div class="form-group mb-0">
                <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_unit_price]" id="variants_{{ $key+1 }}_item_unit_price" data-row="{{ $key+1 }}">
                </div>
            </td>
            <td>
                <div class="form-group mb-0">
                <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][alert_qty]" id="variants_{{ $key+1 }}_alert_qty" data-row="{{ $key+1 }}">
                </div>
            </td>
            <td class="text-center">
                <button type="button" class="btn btn-danger btn-sm remove-variant"> <i class="fas fa-minus-square"></i> </button>
            </td>
        </tr>
        @endif
    @else
    <tr class="variant-row">
        <td>
            <div class="form-group mb-0">
            <input type="text" class="form-control" name="variants[{{ $key+1 }}][name]" value="{{ implode('-',$value) }}">
            <input type="hidden" class="form-control" name="variants[{{ $key+1 }}][id]">
            </div>
        </td>
        <td>
            <div class="form-group mb-0">
                <div class="input-group" id="code_section">
                    <input type="text" class="form-control text-center" name="variants[{{ $key+1 }}][code]" id="variants_{{ $key+1 }}_code" data-row="{{ $key+1 }}">
                    <div class="input-group-prepend">
                        <span class="input-group-text bg-primary" id="generate-{{ $key+1 }}-code" onclick="generate_variants_code('{{ $key+1 }}')"  data-toggle="tooltip" data-theme="dark" title="Generate Code"
                        style="border-top-right-radius: 0.42rem;border-bottom-right-radius: 0.42rem;border:0;cursor: pointer;">
                            <i class="fas fa-retweet text-white"></i>
                        </span>
                    </div>
                </div>
            </div>
        </td>
        <td>
            <div class="form-group mb-0">
                <select name="variants[{{ $key+1 }}][item_base_unit_id]" id="variants_{{ $key+1 }}_item_base_unit_id" data-row="{{ $key+1 }}"  onchange="populate_unit(this.value,2,'{{ $key+1 }}')" class="form-control selectpicker" data-live-search="true"  data-live-search-placeholder="Search">
                    <option value="">Select Please</option>
                    @if (!$units->isEmpty())
                        @foreach ($units as $unit)
                            @if ($unit->base_unit == null)
                            <option value="{{ $unit->id }}">{{ $unit->unit_name.' ('.$unit->unit_code.')' }}</option>
                            @endif
                        @endforeach
                    @endif
                </select>
            </div>
        </td>
        <td>
            <div class="form-group mb-0">
                <select name="variants[{{ $key+1 }}][item_unit_id]" id="variants_{{ $key+1 }}_item_unit_id" data-row="{{ $key+1 }}"  class="form-control selectpicker" data-live-search="true"  data-live-search-placeholder="Search"></select>
            </div>
        </td>
        <td>
            <div class="form-group mb-0">
            <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_base_unit_mrp]" id="variants_{{ $key+1 }}_item_base_unit_mrp" data-row="{{ $key+1 }}">
            </div>
        </td>
        <td>
            <div class="form-group mb-0">
            <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_base_unit_price]" id="variants_{{ $key+1 }}_item_base_unit_price" data-row="{{ $key+1 }}">
            </div>
        </td>
        <td>
            <div class="form-group mb-0">
            <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_unit_mrp]" id="variants_{{ $key+1 }}_item_unit_mrp" data-row="{{ $key+1 }}">
            </div>
        </td>
        <td>
            <div class="form-group mb-0">
            <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_unit_price]" id="variants_{{ $key+1 }}_item_unit_price" data-row="{{ $key+1 }}">
            </div>
        </td>
        <td>
            <div class="form-group mb-0">
            <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][alert_qty]" id="variants_{{ $key+1 }}_alert_qty" data-row="{{ $key+1 }}">
            </div>
        </td>
        <td class="text-center">
            <button type="button" class="btn btn-danger btn-sm remove-variant"> <i class="fas fa-minus-square"></i> </button>
        </td>
    </tr>
    @endif
    
    @endforeach
@endif