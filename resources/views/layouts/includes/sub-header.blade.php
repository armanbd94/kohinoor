<div class="subheader py-2  subheader-solid " id="kt_subheader">
    <div  class=" container-fluid  d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
        <div class="d-flex align-items-right flex-wrap mr-1">
            <h5 class="text-dark font-weight-bold mt-2 mb-2 mr-5"> {{ $page_title }}</h5>
        </div>
        
        <div class="d-flex align-items-center pt-4">
            @if (request()->is('/') || request()->is('asm/dashboard'))
            <div class="form-group mr-3">
                <select onchange="show_data(this.value)" class="form-control" style="height: 32px;
                padding: 5px;
                margin-top: 10px;
                border-radius: 5px;">
                    <option value="">Select Option</option>
                    <option value="1">Today</option>
                    <option value="2">This Week</option>
                    <option value="3">This Month</option>
                    <option value="4">This Year</option>
                </select>
            </div>
            @endif
            

            <ol class="breadcrumb float-right pull-right">
                <li><a href="{{ route('dashboard') }}"><i class="fas fa-home"></i> Dashboard</a></li>
                @if (!empty($breadcrumb))
                    @foreach ($breadcrumb as $item)
                        @if(!isset($item['link']))
                        <li class="active">{{ $item['name'] }}</li>
                        @else 
                        <li><a href="{{ $item['link'] }}">{{ $item['name'] }}</a></li>
                        @endif
                    @endforeach
                @endif
            </ol>
        </div>
    </div>
</div>