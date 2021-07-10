<div class="col-md-12 text-center">
    @if($salesmen->avatar)
        <img src='storage/{{ SALESMEN_AVATAR_PATH.$salesmen->avatar }}' alt='{{ $salesmen->name }}' style='width:200px;'/>
    @else
        <img src='images/male.svg' alt='Default Image' style='width:200px;'/>
    @endif
</div>
<div class="col-md-12">
    <div class="table-responsive">
        <table class="table table-borderless">
            <tr><td width="30%"><b>Name</b></td><td><b>:</b></td><td>{{ $salesmen->name }}</td></tr>
            <tr><td width="30%"><b>Username</b></td><td><b>:</b></td><td>{{ $salesmen->username }}</td></tr>
            <tr><td width="30%"><b>Phone</b></td><td><b>:</b></td><td>{{ $salesmen->phone }}</td></tr>
            <tr><td width="30%"><b>Email</b></td><td><b>:</b></td><td>{!! $salesmen->email ? $salesmen->email : '<span class="label label-danger label-pill label-inline" style="min-width:70px !important;">No Email</span>' !!}</td></tr>
            
            <tr><td width="30%"><b>ASM</b></td><td><b>:</b></td><td>{{  $salesmen->asm->name.' - '.$salesmen->asm->warehouse->name  }}</td></tr>
            <tr><td width="30%"><b>Address</b></td><td><b>:</b></td><td>{{  $salesmen->district->name  }}</td></tr>
            <tr><td width="30%"><b>Address</b></td><td><b>:</b></td><td>{{  $salesmen->upazila->name  }}</td></tr>
            <tr><td width="30%"><b>Address</b></td><td><b>:</b></td><td>{{  $salesmen->address  }}</td></tr>
            <tr><td width="30%"><b>Status</b></td><td><b>:</b></td><td>{!! STATUS_LABEL[$salesmen->status] !!}</td></tr>
            <tr><td width="30%"><b>Created By</b></td><td><b>:</b></td><td>{{  $salesmen->created_by  }}</td></tr>
            @if($salesmen->modified_by)<tr><td width="30%"><b>Modified By</b></td><td><b>:</b></td><td>{{  $salesmen->modified_by  }}</td></tr>@endif
            <tr><td width="30%"><b>Create Date</b></td><td><b>:</b></td><td>{{  $salesmen->created_at ? date(config('settings.date_format'),strtotime($salesmen->created_at)) : ''  }}</td></tr>
            @if($salesmen->modified_by)<tr><td width="30%"><b>Modified Date</b></td><td><b>:</b></td><td>{{  $salesmen->updated_at ? date(config('settings.date_format'),strtotime($salesmen->updated_at)) : ''  }}</td></tr>@endif
        </table>
        <h6 class="bg-primary text-center text-white" style="width: 250px;padding: 5px; margin: 10px auto 5px auto;">Day wise visiting routes</h6>
        <table class="table table-bordered">
            <thead class="bg-primary">
                <th>Day</th>
                <th>Route</th>
            </thead>
            <tbody>
                @if (!$salesmen->routes->isEmpty())
                    @foreach ($salesmen->routes as $route)
                        <tr>
                            <td>{{ DAYS[$route->pivot->day] }}</td>
                            <td>{{ $route->name }}</td>
                        </tr>
                    @endforeach
                @endif
            </tbody>
        </table>
    </div>
</div>