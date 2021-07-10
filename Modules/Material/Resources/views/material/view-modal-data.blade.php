<div class="col-md-12 text-center">
    @if($material->material_image)
        <img src='storage/{{ MATERIAL_IMAGE_PATH.$material->material_image }}' alt='{{ $material->material_name }}' style='width:200px;'/>
    @else
        <img src='images/default.svg' alt='Default Image' style='width:200px;'/>
    @endif
</div>
<div class="col-md-12">
    <div class="table-responsive">
        <table class="table table-borderless">
            <tr><td width="40%"><b>Material Name</b></td><td><b>:</b></td><td>{{ $material->material_name }}</td></tr>
            <tr><td width="40%"><b>Material Code</b></td><td><b>:</b></td><td>{{ $material->material_code }}</td></tr>
            <tr><td width="40%"><b>Category</b></td><td><b>:</b></td><td>{{ $material->category->name }}</td></tr>
            <tr><td width="40%"><b>Purchase Price</b></td><td><b>:</b></td><td>{{ $material->purchase_price ? number_format($material->purchase_price,2) : 0 }}</td></tr>
            <tr><td width="40%"><b>Unit</b></td><td><b>:</b></td><td>{{ $material->unit->unit_name }}</td></tr>
            <tr><td width="40%"><b>Purchase Unit</b></td><td><b>:</b></td><td>{{ $material->purchase_unit->unit_name }}</td></tr>
            <tr><td width="40%"><b>Stock Quantity</b></td><td><b>:</b></td><td>{!! $material->qty ? $material->qty : '<span class="label label-danger"">0</span>' !!}</td></tr>
            <tr><td width="40%"><b>Stock Alert Quantity</b></td><td><b>:</b></td><td>{!! $material->alert_qty ? $material->alert_qty : '<span class="label label-danger"">0</span>' !!}</td></tr>
            <tr><td width="40%"><b>Status</b></td><td><b>:</b></td><td>{!! STATUS_LABEL[$material->status] !!}</td></tr>
            <tr><td width="40%"><b>Created By</b></td><td><b>:</b></td><td>{{  $material->created_by  }}</td></tr>
            @if($material->modified_by)<tr><td width="40%"><b>Modified By</b></td><td><b>:</b></td><td>{{  $material->modified_by  }}</td></tr>@endif
            <tr><td width="40%"><b>Create Date</b></td><td><b>:</b></td><td>{{  $material->created_at ? date(config('settings.date_format'),strtotime($material->created_at)) : ''  }}</td></tr>
            @if($material->modified_by)<tr><td width="40%"><b>Modified Date</b></td><td><b>:</b></td><td>{{  $material->updated_at ? date(config('settings.date_format'),strtotime($material->updated_at)) : ''  }}</td></tr>@endif
    </div>
</div>