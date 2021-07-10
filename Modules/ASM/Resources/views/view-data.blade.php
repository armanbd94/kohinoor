<div class="col-md-12 text-center">
    @if($asm->avatar)
        <img src='storage/{{ ASM_AVATAR_PATH.$asm->avatar }}' alt='{{ $asm->name }}' style='width:200px;'/>
    @else
        <img src='images/male.svg' alt='Default Image' style='width:200px;'/>
    @endif
</div>
<div class="col-md-12">
    <div class="table-responsive">
        <table class="table table-borderless">
            <tr><td width="30%"><b>Name</b></td><td><b>:</b></td><td>{{ $asm->name }}</td></tr>
            <tr><td width="30%"><b>Username</b></td><td><b>:</b></td><td>{{ $asm->username }}</td></tr>
            <tr><td width="30%"><b>Phone</b></td><td><b>:</b></td><td>{{ $asm->phone }}</td></tr>
            <tr><td width="30%"><b>Email</b></td><td><b>:</b></td><td>{!! $asm->email ? $asm->email : '<span class="label label-danger label-pill label-inline" style="min-width:70px !important;">No Email</span>' !!}</td></tr>
            <tr><td width="30%"><b>Warehouse</b></td><td><b>:</b></td><td>{{ $asm->warehouse->name }}</td></tr>
            <tr><td width="30%"><b>District</b></td><td><b>:</b></td><td>{{ $asm->district->name }}</td></tr>
            <tr><td width="30%"><b>Status</b></td><td><b>:</b></td><td>{!! STATUS_LABEL[$asm->status] !!}</td></tr>
            <tr><td width="30%"><b>Address</b></td><td><b>:</b></td><td>{{  $asm->address  }}</td></tr>
            <tr><td width="30%"><b>Created By</b></td><td><b>:</b></td><td>{{  $asm->created_by  }}</td></tr>
            @if($asm->modified_by)<tr><td width="30%"><b>Modified By</b></td><td><b>:</b></td><td>{{  $asm->modified_by  }}</td></tr>@endif
            <tr><td width="30%"><b>Create Date</b></td><td><b>:</b></td><td>{{  $asm->created_at ? date(config('settings.date_format'),strtotime($asm->created_at)) : ''  }}</td></tr>
            @if($asm->modified_by)<tr><td width="30%"><b>Modified Date</b></td><td><b>:</b></td><td>{{  $asm->updated_at ? date(config('settings.date_format'),strtotime($asm->updated_at)) : ''  }}</td></tr>@endif
    </div>
</div>