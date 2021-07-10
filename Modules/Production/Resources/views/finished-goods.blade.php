@if (!$production->production_finished_goods->isEmpty())
@foreach ($production->production_finished_goods as $key => $item)
<tr id="row_{{ $key+1 }}">
    <input type="hidden" value="{{ $item->id }}" id="production_finished_goods_id_{{ $key+1 }}">
    <input type="hidden" value="{{ $item->pivot->finish_goods_id }}" id="finish_goods_id_{{ $key+1 }}">
    <td class="text-center">{{ $production->batch_no }}</td>
    <td>{{ $production->product->product_name }}</td>
    <td>{{ $item->size->size.' '.$item->size->unit->unit_name }}</td>
    <td class="text-center px-0">{{ $item->pivot->total_coupon ? $item->pivot->total_coupon : 'N/A' }}</td>
    <td class="text-right px-0">{{ $item->pivot->coupon_price ? number_format($item->pivot->coupon_price,2) : 'N/A' }}</td>
    <td class="text-center px-0">{{ $item->pivot->coupon_exp_date ? date(config('settings.date_format'),strtotime($item->pivot->coupon_exp_date)) : 'N/A' }}</td>
    <td class="text-center px-0">{{ $item->pivot->qty }}</td>
    <td class="text-center px-0">{{ $item->unit->unit_name }}</td>
    <td class="text-right px-0">{{ $item->pivot->direct_cost ? number_format(($item->pivot->direct_cost / $item->pivot->qty),2) : '' }}</td>
    @if (permission('production-qr-code-print') || permission('production-packaging'))
    <td class="text-center">
        <div class="d-flex justify-content-center">
            @if (permission('production-qrcode-print') && !empty($item->pivot->total_coupon) && $production->production_status == 4)
                <button type="button" class="btn btn-icon btn-outline-success btn-sm mr-2" data-toggle="tooltip" data-theme="dark" title="QR Code"
                onclick="show_qrcode_modal('{{ $item->pivot->id }}','{{ $production->id }}','{{ $item->pivot->batch_no }}','{{ $production->product->product_name.' '.$item->size->size.' '.$item->size->unit->unit_name }}')">
                    <i class="fas fa-qrcode"></i>
                </button>
            @endif
            @if (permission('production-packaging') && $production->production_status != 4)
                <button type="button" class="btn btn-icon btn-outline-primary btn-sm mr-2 edit_finished_goods_{{ $key+1 }}" data-toggle="tooltip" data-theme="dark" title="Edit"
                onclick="show_finished_goods_edit_form('{{ $item->pivot->id }}','{{ $production->product->product_name.' '.$item->size->size.' '.$item->size->unit->unit_name }}')">
                    <i class="fas fa-edit"></i>
                </button>
            @endif
        </div>
    </td>
    @endif
</tr>
@endforeach
@endif