@if (!$finished_goods->isEmpty())
    @foreach ($finished_goods as $key => $item)
    <div class="row variant_remove">
        <div class="form-group col-md-4 required">
            @if($key == 0)<label for="variants_{{ $key + 1 }}_finish_goods_id" class="form-control-label">Finish Good</label>@endif
            <input type="text" class="form-control text-left" value="{{ $item->product->product_name.' '.$item->size->size.' '.$item->size->unit->unit_code }}" readonly>
            <input type="hidden" class="form-control text-center" name="variants[{{ $key + 1 }}][finish_goods_id]" value="{{ $item->id }}" id="variants_{{ $key + 1 }}_finish_goods_id">
        </div>
        <div class="form-group col-md-2">
            @if($key == 0)<label for="variants_{{ $key + 1 }}_total_coupon" class="form-control-label">Total Coupon</label>@endif
            <input type="text" class="form-control text-right" name="variants[{{ $key + 1 }}][total_coupon]" id="variants_{{ $key + 1 }}_total_coupon" placeholder="0" style="padding-right: 30px;">
        </div>
        <div class="form-group col-md-2">
            @if($key == 0)<label for="variants_{{ $key + 1 }}_coupon_price" class="form-control-label">Coupon Price</label>@endif
            <input type="text" class="form-control text-right" name="variants[{{ $key + 1 }}][coupon_price]" id="variants_{{ $key + 1 }}_coupon_price" placeholder="0.00" style="padding-right: 30px;">
        </div>
        <div class="form-group col-md-2">
            @if($key == 0)<label for="variants_{{ $key + 1 }}_coupon_expiration_date" class="form-control-label">Coupon Expiration Date</label>@endif
            <input type="text" class="form-control coupon_expiration_date" name="variants[{{ $key + 1 }}][coupon_expiration_date]" id="variants_{{ $key + 1 }}_coupon_expiration_date">
        </div>
        <div class="form-group col-md-2" @if($key == 0) style="padding-top: 26px;" @endif>
            <button type="button" class="btn btn-danger btn-sm remove_variant" data-toggle="tooltip" 
                data-placement="top" data-original-title="Remove">
                <i class="fas fa-minus-square"></i>
                </button>
        </div>
    </div>
    @endforeach
@endif