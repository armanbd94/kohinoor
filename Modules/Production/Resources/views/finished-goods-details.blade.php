<div class="col-md-12">
    <table class="table table-borderless">
        <tr><td width="25%"><b>Batch No.</b></td><td width="5%"><b>:</b></td><td width="70%">{{ $data->batch_no }}</td></tr>
        <tr><td width="25%"><b>Product Name</b></td><td width="5%"><b>:</b></td><td width="70%">{{ $data->finished_goods->product->product_name.' '.$data->finished_goods->size->size.' '.$data->finished_goods->size->unit->unit_name }}</td></tr>
        <tr><td width="25%"><b>Production Quantity</b></td><td width="5%"><b>:</b></td><td width="70%">{{ $data->qty.' '.$data->finished_goods->unit->unit_name }}</td></tr>
        <tr><td width="25%"><b>Direct Cost</b></td><td width="5%"><b>:</b></td><td width="70%">{{ number_format(($data->direct_cost/$data->qty),2) }}</td></tr>
        <tr><td width="25%"><b>Total Coupon</b></td><td width="5%"><b>:</b></td><td width="70%">{{ $data->total_coupon ? $data->total_coupon : '' }}</td></tr>
        <tr><td width="25%"><b>Coupon Price</b></td><td width="5%"><b>:</b></td><td width="70%">{{ $data->coupon_price ? number_format(($data->coupon_price),2) : '' }}</td></tr>
        <tr><td width="25%"><b>Coupon Exp. Date</b></td><td width="5%"><b>:</b></td><td width="70%">{{ $data->coupon_exp_date ? date(config('settings.date_format'),strtotime($data->coupon_exp_date)) : '' }}</td></tr>
    </table>
</div>

<div class="col-md-12">
    <h5>Material Details</h5>
    <table class="table table-bordered">
        <thead class="bg-primary">
            <th width="25%">Material</th>
            <th width="10%" class="text-center">Unit</th>
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
                        <td class="text-center">{{ $item->material->unit->unit_name }}</td>
                        <td class="text-center">{{ $item->total_qty ? $item->total_qty : 0 }} </td>
                        <td class="text-center">{{ $item->used_qty ? $item->used_qty : 0 }}</td>
                        <td class="text-center">{{ $item->damaged_qty ? $item->damaged_qty : 0 }}</td>
                        <td class="text-center">{{ $item->odd_qty ? $item->odd_qty : 0 }}</td>
                    </tr>
                @endforeach
            @endif
        </tbody>
    </table>
</div>