

@extends('layouts.app')

@section('title', $page_title)

@push('styles')
<link href="css/daterangepicker.min.css" rel="stylesheet" type="text/css" />
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
                <div class="card-toolbar">
                    <!--begin::Button-->
                    @if (permission('production-add'))
                    <a href="{{ route('production.add') }}"  class="btn btn-primary btn-sm font-weight-bolder"> 
                        <i class="fas fa-plus-circle"></i> Add New</a>
                        @endif
                    <!--end::Button-->
                </div>
            </div>
        </div>
        <!--end::Notice-->
        <!--begin::Card-->
        <div class="card card-custom">
            <div class="card-header flex-wrap py-5">
                <form method="POST" id="form-filter" class="col-md-12 px-0">
                    <div class="row">
                        <x-form.textbox labelName="Batch No." name="batch_no" col="col-md-3" />
                        <x-form.selectbox labelName="Product" name="finish_goods_id" col="col-md-3" class="selectpicker">
                            @if (!$finished_goods->isEmpty())
                                @foreach ($finished_goods as $item)
                                    <option value="{{ $item->id }}">{{ $item->product->product_name.' '.$item->size->size.' '.$item->size->unit->unit_name }}</option>
                                @endforeach
                            @endif
                        </x-form.selectbox>
                        <div class="form-group col-md-3">
                            <label for="name">Choose Your Date</label>
                            <div class="input-group">
                                <input type="text" class="form-control daterangepicker-filed" value="{{ date('Y-m-d') }} To {{ date('Y-m-d') }}">
                                <input type="hidden" id="start_date" name="start_date" value="{{ date('Y-m-d') }}">
                                <input type="hidden" id="end_date" name="end_date" value="{{ date('Y-m-d')}}">
                            </div>
                        </div>
                        <div class="col-md-3">
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
                                        <th>Batch No.</th>
                                        <th>Product Name</th>
                                        <th>Quantity</th>
                                        <th>Unit</th>
                                        <th>Direct Cost</th>
                                        <th>Total Cost</th>
                                        <th>Total Coupon</th>
                                        <th>Coupon Price</th>
                                        <th>Coupon Exp. Date</th>
                                        <th>Production Date</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                                <tfoot>
                                    <tr style="background: #034d97;">
                                        <td></td>
                                        <td></td>
                                        <td style="color:white;text-align:right !important;">Total</td>
                                        <td style="color:white;">0.00</td>
                                        <td></td>
                                        <td></td>
                                        <td  style="color:white;">0.00</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
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
<script src="js/knockout-3.4.2.js"></script>
<script src="js/daterangepicker.min.js"></script>
<script>
    var table;
    $(document).ready(function(){
        $('.daterangepicker-filed').daterangepicker({
            callback: function(startDate, endDate, period){
                var start_date = startDate.format('YYYY-MM-DD');
                var end_date   = endDate.format('YYYY-MM-DD');
                var title = start_date + ' To ' + end_date;
                $(this).val(title);
                $('input[name="start_date"]').val(start_date);
                $('input[name="end_date"]').val(end_date);
            }
        });
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
                "url": "{{route('production.report.datatable.data')}}",
                "type": "POST",
                "data": function (data) {
                    data.batch_no                  = $("#form-filter #batch_no").val();
                    data.finish_goods_id                = $("#form-filter #finish_goods_id option:selected").val();
                    data.start_date   = $("#form-filter #start_date").val();
                    data.end_date     = $("#form-filter #end_date").val();
                    data._token                    = _token;
                }
            },
            "columnDefs": [{
                    "targets": [4,10],
                    "orderable": false,
                    "className": "text-center"
                },
                {
                    "targets": [0,1,3,4,7,8],
                    "className": "text-center"
                },
                {
                    "targets": [5,6],
                    "orderable": false,
                    "className": "text-right"
                },

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
                        $(win.document.body).find('table thead').css('background-color','#034d97');
                        $(win.document.body).find('table tfoot tr').css('background-color','#034d97');
                        $(win.document.body).find('h1').css('text-align', 'center');
                        $(win.document.body).find('h1').css('font-size', '15px');
                        $(win.document.body).find( 'table' )
                        .addClass( 'compact' )
                        .css( 'font-size', 'inherit' );
                    },
                    footer:true
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
                    },
                    footer:true
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
                    },
                    footer:true
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
                    footer:true,
                    customize: function(doc) {
                    doc.defaultStyle.fontSize = 7; //<-- set fontsize to 16 instead of 10 
                    doc.styles.tableHeader.fontSize = 7;
                    doc.styles.tableFooter.fontSize = 7;
                    doc.pageMargins = [5,5,5,5];
                }  
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

                // Total over all pages
                for (let index = 3; index <= 6; index++) {
                    // Total over this page
                    if(index != 4 && index != 5)
                    {
                        total = api
                        .column( index )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
        
                    // Total over this page
                    pageTotal = api
                        .column(index, { page: 'current'} )
                        .data()
                        .reduce( function (a, b) {
                            return intVal(a) + intVal(b);
                        }, 0 );
        
                    // Update footer
                    $( api.column( index ).footer() ).html(number_format(pageTotal));
                    }
                }
            }
        });
    
        $('#btn-filter').click(function () {
            table.ajax.reload();
        });
    
        $('#btn-reset').click(function () {
            $('#form-filter')[0].reset();
            $('#form-filter .selectpicker').selectpicker('refresh');
            $('#form-filter #start_date').val("{{ date('Y-m-d') }} ");
            $('#form-filter #end_date').val("{{ date('Y-m-d') }} ");
            table.ajax.reload();
        });
    
    });
    </script>
@endpush