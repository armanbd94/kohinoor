@extends('layouts.asm-app')

@section('title', $page_title)

@push('styles')
<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
@endpush

@section('content')
<div class="d-flex flex-column-fluid">
    <div class="container-fluid">
        <!--begin::Notice-->
        <div class="card card-custom gutter-b">
            <div class="card-header flex-wrap py-5">
                <div class="card-title">
                    <h3 class="card-label"><i class="{{ $page_icon }} text-primary"></i> {{ $sub_title }}</h3>
                </div>
            </div>
        </div>
        <!--end::Notice-->
        <!--begin::Card-->
        <div class="card card-custom">
            <div class="card-header flex-wrap py-5">
                <form method="POST" id="form-filter" class="col-md-12 px-0">
                    <div class="row">
                        <div class="form-group col-md-3">
                            <label for="from_date">From Date</label>
                            <input type="text" class="form-control date" name="from_date" id="from_date" readonly />
                        </div>
                        <div class="form-group col-md-3">
                            <label for="to_date">To Date</label>
                            <input type="text" class="form-control date" name="to_date" id="to_date" readonly />
                        </div>

                        <x-form.selectbox labelName="Sales Person" name="salesmen_id" col="col-md-3" class="selectpicker">
                            @if (!$salesmen->isEmpty())
                                @foreach ($salesmen as $value)
                                <option value="{{ $value->id }}">{{ $value->name }}</option>
                                @endforeach
                            @endif
                        </x-form.selectbox>

                        <x-form.selectbox labelName="Upazila" name="upazila_id" col="col-md-3" class="selectpicker" onchange="upazilaRouteList(this.value)">
                            @if (!$upazilas->isEmpty())
                                @foreach ($upazilas as $value)
                                <option value="{{ $value->id }}">{{ $value->name }}</option>
                                @endforeach
                            @endif
                        </x-form.selectbox>

                        <x-form.selectbox labelName="Route" name="route_id" col="col-md-3" class="selectpicker" onchange="routeCustomerList(this.value)">
                            @if (!$routes->isEmpty())
                                @foreach ($routes as $value)
                                <option value="{{ $value->id }}">{{ $value->name }}</option>
                                @endforeach
                            @endif
                        </x-form.selectbox>

                        <x-form.selectbox labelName="Customer" name="customer_id" col="col-md-3" class="selectpicker">
                            @if (!$customers->isEmpty())
                                @foreach ($customers as $value)
                                <option value="{{ $value->id }}">{{ $value->name.' - '.$value->shop_name }}</option>
                                @endforeach
                            @endif
                        </x-form.selectbox>

                        <div class="col-md-6">
                            <div style="margin-top:28px;">    
                                <div style="margin-top:28px;">    
                                    <button id="btn-reset" class="btn btn-danger btn-sm btn-elevate btn-icon float-right" type="button"
                                    data-toggle="tooltip" data-theme="dark" title="Reset">
                                    <i class="fas fa-undo-alt"></i></button>
    
                                    <button id="btn-filter" class="btn btn-primary btn-sm btn-elevate btn-icon mr-2 float-right" type="button"
                                    data-toggle="tooltip" data-theme="dark" title="Search">
                                    <i class="fas fa-search"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="card-body">
                <!--begin: Datatable-->
                <div id="kt_datatable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
                    <div class="row">
                        <div class="col-sm-12">
                            <table id="dataTable" class="table table-bordered table-hover">
                                <thead class="bg-primary">
                                    <tr>
                                        <th>Sl</th>
                                        <th>Coupon Code</th>
                                        <th>Received From</th>
                                        <th>Received By</th>
                                        <th>Upazila</th>
                                        <th>Route</th>
                                        <th>Received Date</th>
                                        <th>Coupon Price</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                                <tfoot>
                                    <tr class="bg-primary">
                                        <th style="text-align: right !important;font-weight:bold;" colspan="7">Total</th>
                                        <th style="text-align: right !important;font-weight:bold;"></th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
                <!--end: Datatable-->
            </div>
        </div>
        <!--end::Card-->
    </div>
</div>
@endsection

@push('scripts')
<script src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $('.date').datetimepicker({format: 'YYYY-MM-DD',ignoreReadonly: true});
    var table;
    $(document).ready(function(){
    
        table = $('#dataTable').DataTable({
            "processing": true, //Feature control the processing indicator
            "serverSide": true, //Feature control DataTable server side processing mode
            "order": [], //Initial no order
            "responsive": true, //Make table responsive in mobile device
            "bInfo": true, //TO show the total number of data
            "bFilter": false, //For datatable default search box show/hide
            "lengthMenu": [
                [5, 10, 15, 25, 50, 100, 1000, 10000, -1],
                [5, 10, 15, 25, 50, 100, 1000, 10000, "All"]
            ],
            "pageLength": 25, //number of data show per page
            "language": { 
                processing: `<i class="fas fa-spinner fa-spin fa-3x fa-fw text-primary"></i> `,
                emptyTable: '<strong class="text-danger">No Data Found</strong>',
                infoEmpty: '',
                zeroRecords: '<strong class="text-danger">No Data Found</strong>'
            },
            "ajax": {
                "url": "{{route('asm.coupon.received.datatable.data')}}",
                "type": "POST",
                "data": function (data) {
                    data.from_date = $("#form-filter #from_date").val();
                    data.to_date = $("#form-filter #to_date").val();
                    data.salesmen_id = $("#form-filter #salesmen_id").val();
                    data.upazila_id  = $("#form-filter #upazila_id").val();
                    data.route_id    = $("#form-filter #route_id").val();
                    data.customer_id = $("#form-filter #customer_id").val();
                    data._token      = _token;
                }
            },
            "columnDefs": [
                {
                    "targets": [0,6],
                    "className": "text-center"
                },
                {
                    "targets": [4,5],
                    "orderable":false,
                    "className": "text-center"
                },
                {
                    "targets": [7],
                    "className": "text-right"
                }
            ],
            "dom": "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6' <'float-right'B>>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'<'float-right'p>>>",
            "buttons": [
                {
                    'extend':'colvis','className':'btn btn-secondary btn-sm text-white','text':'Column','columns': ':gt(0)'
                },
                {
                    "extend": 'print',
                    'text':'Print',
                    'className':'btn btn-secondary btn-sm text-white',
                    "title": "{{ $page_title }} List",
                    "orientation": "landscape", //portrait
                    "pageSize": "A4", //A3,A5,A6,legal,letter
                    "exportOptions": {
                        columns: function (index, data, node) {
                            return table.column(index).visible();
                        }
                    },
                    customize: function (win) {
                        $(win.document.body).addClass('bg-white');
                    },
                },
                {
                    "extend": 'csv',
                    'text':'CSV',
                    'className':'btn btn-secondary btn-sm text-white',
                    "title": "{{ $page_title }} List",
                    "filename": "{{ strtolower(str_replace(' ','-',$page_title)) }}-list",
                    "exportOptions": {
                        columns: function (index, data, node) {
                            return table.column(index).visible();
                        }
                    }
                },
                {
                    "extend": 'excel',
                    'text':'Excel',
                    'className':'btn btn-secondary btn-sm text-white',
                    "title": "{{ $page_title }} List",
                    "filename": "{{ strtolower(str_replace(' ','-',$page_title)) }}-list",
                    "exportOptions": {
                        columns: function (index, data, node) {
                            return table.column(index).visible();
                        }
                    }
                },
                {
                    "extend": 'pdf',
                    'text':'PDF',
                    'className':'btn btn-secondary btn-sm text-white',
                    "title": "{{ $page_title }} List",
                    "filename": "{{ strtolower(str_replace(' ','-',$page_title)) }}-list",
                    "orientation": "landscape", //portrait
                    "pageSize": "A4", //A3,A5,A6,legal,letter
                    "exportOptions": {
                        columns: function (index, data, node) {
                            return table.column(index).visible();
                        }
                    },
                },
            ],
            "footerCallback": function ( row, data, start, end, display ) {
                var api = this.api(), data;
    
                // Remove the formatting to get integer data for summation
                var intVal = function ( i ) {
                    return typeof i === 'string' ?
                        i.replace(/[\$,]/g, '')*1 :
                        typeof i === 'number' ?
                            i : 0;
                };


                total = api
                    .column( 7 )
                    .data()
                    .reduce( function (a, b) {
                        return intVal(a) + intVal(b);
                    }, 0 );
    
                // Total over this page
                pageTotal = api
                    .column( 7, { page: 'current'} )
                    .data()
                    .reduce( function (a, b) {
                        return intVal(a) + intVal(b);
                    }, 0 );
    
                // Update footer
                $( api.column( 7 ).footer() ).html('= '+number_format(pageTotal) +' ('+ number_format(total) +' Total)');

            }
        });

        $('#btn-filter').click(function () {
            table.ajax.reload();
        });
    
        $('#btn-reset').click(function () {
            $('#form-filter')[0].reset();
            $('#form-filter .selectpicker').selectpicker('refresh');
            table.ajax.reload();
        });
    });

    function upazilaRouteList(upazila_id)
    {
        $.ajax({
            url:"{{ url('asm/upazila-id-wise-route-list') }}/"+upazila_id,
            type:"GET",
            dataType:"JSON",
            success:function(data){
                html = `<option value="">Select Please</option>`;
                $.each(data, function(key, value) {
                    html += '<option value="'+ key +'">'+ value +'</option>';
                });

                $('#form-filter #route_id').empty();
                $('#form-filter #route_id').append(html);
                $('#form-filter #route_id.selectpicker').selectpicker('refresh');
            },
        });
    }

    function routeCustomerList(route_id)
    {
        $.ajax({
            url:"{{ url('asm/route-id-wise-customer-list') }}",
            type:"POST",
            data:{_token:_token,route_id:route_id},
            success:function(data){
                $('#form-filter #customer_id').html('');
                $('#form-filter #customer_id').html(data);
                $('#form-filter #customer_id.selectpicker').selectpicker('refresh');
            },
        });
    }
    </script>
@endpush