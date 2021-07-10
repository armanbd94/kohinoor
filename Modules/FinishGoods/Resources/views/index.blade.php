
@extends('layouts.app')

@section('title', $page_title)

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
                        <x-form.selectbox labelName="Product" name="product_id" col="col-md-3" class="selectpicker">
                            @if (!$products->isEmpty())
                                @foreach ($products as $product)
                                    <option value="{{ $product->id }}">{{ $product->product_name }}</option>
                                @endforeach
                            @endif
                        </x-form.selectbox>
                        <x-form.selectbox labelName="Size" name="size_id" col="col-md-3" class="selectpicker">
                            @if (!$sizes->isEmpty())
                                @foreach ($sizes as $size)
                                    <option value="{{ $size->id }}">{{ $size->size.' '.$size->unit->unit_code }}</option>
                                @endforeach
                            @endif
                        </x-form.selectbox>
                        <x-form.textbox labelName="Barcode" name="code" col="col-md-3" />
                        <x-form.selectbox labelName="Type" name="type" col="col-md-3" class="selectpicker">
                            @foreach (PRODUCT_TYPE as $key => $value)
                                <option value="{{ $key }}">{{ $value }}</option>
                            @endforeach
                        </x-form.selectbox>
                        <x-form.selectbox labelName="Status" name="status" col="col-md-3" class="selectpicker">
                            @foreach (STATUS as $key => $value)
                                <option value="{{ $key }}">{{ $value }}</option>
                            @endforeach
                        </x-form.selectbox>
                        <div class="col-md-9">
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
                                        @if (permission('inventory-bulk-delete'))
                                        <th>
                                            <div class="custom-control custom-checkbox">
                                                <input type="checkbox" class="custom-control-input" id="select_all" onchange="select_all()">
                                                <label class="custom-control-label" for="select_all"></label>
                                            </div>
                                        </th>
                                        @endif
                                        <th>Sl</th>
                                        <th>Product Name</th>
                                        <th>Size</th>
                                        <th>Barcode</th>
                                        <th>Type</th>
                                        <th>Direct Cost</th>
                                        <th>MRP</th>
                                        <th>Unit</th>
                                        <th>Sale Unit</th>
                                        <th>Stock Qty</th>
                                        <th>Alert Qty</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
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
@include('finishgoods::modal')
@endsection

@push('scripts')
<script>
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
                "url": "{{route('finished.goods.datatable.data')}}",
                "type": "POST",
                "data": function (data) {
                    data.product_id = $("#form-filter #product_id").val();
                    data.size_id    = $("#form-filter #size_id").val();
                    data.code       = $("#form-filter #code").val();
                    data.type       = $("#form-filter #type").val();
                    data.status     = $("#form-filter #status").val();
                    data._token     = _token;
                }
            },
            "columnDefs": [{
                    @if (permission('inventory-bulk-delete'))
                    "targets": [0,13],
                    @else 
                    "targets": [12],
                    @endif
                    "orderable": false,
                    "className": "text-center"
                },
                {
                    @if (permission('inventory-bulk-delete'))
                    "targets": [1,3,4,5,8,9,10,11,12],
                    @else 
                    "targets": [0,2,3,4,7,8,9,10,11],
                    @endif
                    "className": "text-center"
                },
                {
                    @if (permission('inventory-bulk-delete'))
                    "targets": [6,7],
                    @else 
                    "targets": [5,6],
                    @endif
                    "className": "text-right"
                },

            ],
            "dom": "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6' <'float-right'B>>>" +
                "<'row'<'col-sm-12'tr>>" +
                "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'<'float-right'p>>>",
    
            "buttons": [
                @if (permission('inventory-report'))
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
                        @if (permission('inventory-bulk-delete'))
                        columns: ':visible:not(:eq(0),:eq(13))' 
                        @else 
                        columns: ':visible:not(:eq(12))' 
                        @endif
                    },
                    customize: function (win) {
                        $(win.document.body).addClass('bg-white');
                        $(win.document.body).find('table thead').css({'background':'#034d97'});
                        $(win.document.body).find('table tfoot tr').css({'background-color':'#034d97'});
                        $(win.document.body).find('h1').css('text-align', 'center');
                        $(win.document.body).find('h1').css('font-size', '15px');
                        $(win.document.body).find('table').css( 'font-size', 'inherit' );
                    },
                },
                {
                    "extend": 'csv',
                    'text':'CSV',
                    'className':'btn btn-secondary btn-sm text-white',
                    "title": "{{ $page_title }} List",
                    "filename": "{{ strtolower(str_replace(' ','-',$page_title)) }}-list",
                    "exportOptions": {
                        @if (permission('inventory-bulk-delete'))
                        columns: ':visible:not(:eq(0),:eq(13))' 
                        @else 
                        columns: ':visible:not(:eq(12))' 
                        @endif
                    }
                },
                {
                    "extend": 'excel',
                    'text':'Excel',
                    'className':'btn btn-secondary btn-sm text-white',
                    "title": "{{ $page_title }} List",
                    "filename": "{{ strtolower(str_replace(' ','-',$page_title)) }}-list",
                    "exportOptions": {
                        @if (permission('inventory-bulk-delete'))
                        columns: ':visible:not(:eq(0),:eq(13))' 
                        @else 
                        columns: ':visible:not(:eq(12))' 
                        @endif
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
                        @if (permission('inventory-bulk-delete'))
                        columns: ':visible:not(:eq(0),:eq(13))' 
                        @else 
                        columns: ':visible:not(:eq(12))' 
                        @endif
                    },
                    customize: function(doc) {
                        doc.defaultStyle.fontSize = 7; //<-- set fontsize to 16 instead of 10 
                        doc.styles.tableHeader.fontSize = 7;
                        doc.pageMargins = [5,5,5,5];
                    } 
                },
                @endif 
                @if (permission('inventory-bulk-delete'))
                {
                    'className':'btn btn-danger btn-sm delete_btn d-none text-white',
                    'text':'Delete',
                    action:function(e,dt,node,config){
                        multi_delete();
                    }
                }
                @endif
            ],
        });
    
        $('#btn-filter').click(function () {
            table.ajax.reload();
        });
    
        $('#btn-reset').click(function () {
            $('#form-filter')[0].reset();
            $('#form-filter .selectpicker').selectpicker('refresh');
            table.ajax.reload();
        });

        $(document).on('click', '#save-btn', function () {
            let form = document.getElementById('store_or_update_form');
            let formData = new FormData(form);
            let url = "{{route('finished.goods.store.or.update')}}";
            let id = $('#update_id').val();
            let method;
            if (id) {
                method = 'update';
            } else {
                method = 'add';
            }
            store_or_update_data(table, method, url, formData);
        });
    
        $(document).on('click', '.edit_data', function () {
            let id = $(this).data('id');
            $('#store_or_update_form')[0].reset();
            $('#store_or_update_form .select').val('');
            $('#store_or_update_form').find('.is-invalid').removeClass('is-invalid');
            $('#store_or_update_form').find('.error').remove();
            if (id) {
                $.ajax({
                    url: "{{route('finished.goods.edit')}}",
                    type: "POST",
                    data: { id: id,_token: _token},
                    dataType: "JSON",
                    success: function (data) {
                        if(data.status == 'error'){
                            notification(data.status,data.message)
                        }else{
                            $('#store_or_update_form #update_id').val(data.id);
                            $('#store_or_update_form #product_id').val(data.product_id);
                            $('#store_or_update_form #size_id').val(data.size_id);
                            $('#store_or_update_form #code').val(data.code);
                            $('#store_or_update_form #cost').val(data.cost);
                            $('#store_or_update_form #price').val(data.price);
                            $('#store_or_update_form #unit_id').val(data.unit_id);
                            $('#store_or_update_form #qty').val(data.qty);
                            $('#store_or_update_form #alert_qty').val(data.alert_qty);
                            $('#store_or_update_form .selectpicker').selectpicker('refresh');
                            populate_unit(data.unit_id,data.sale_unit_id);
                            
                            $('#store_or_update_modal').modal({
                                keyboard: false,
                                backdrop: 'static',
                            });
                            $('#store_or_update_modal .modal-title').html(
                                '<i class="fas fa-edit text-white"></i> <span>Edit Finished Goods</span>');
                            $('#store_or_update_modal #save-btn').text('Update');
                        }
                        
                    },
                    error: function (xhr, ajaxOption, thrownError) {
                        console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
                    }
                });
            }
        });

        $(document).on('click', '.view_data', function () {
            let id = $(this).data('id');
            let name  = $(this).data('name');
            if (id) {
                $.ajax({
                    url: "{{route('finished.goods.view')}}",
                    type: "POST",
                    data: { id: id,_token: _token},
                    success: function (data) {
                        $('#view_modal #view-data').html('');
                        $('#view_modal #view-data').html(data);
                        $('#view_modal').modal({
                            keyboard: false,
                            backdrop: 'static',
                        });
                        $('#view_modal .modal-title').html(
                                '<i class="fas fa-eye text-white"></i> <span> ' + data.name + ' Details</span>');
                    },
                    error: function (xhr, ajaxOption, thrownError) {
                        console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
                    }
                });
            }
        });
    
        $(document).on('click', '.delete_data', function () {
            let id    = $(this).data('id');
            let name  = $(this).data('name');
            let row   = table.row($(this).parent('tr'));
            let url   = "{{ route('finished.goods.delete') }}";
            delete_data(id, url, table, row, name);
        });
    
        function multi_delete(){
            let ids = [];
            let rows;
            $('.select_data:checked').each(function(){
                ids.push($(this).val());
                rows = table.rows($('.select_data:checked').parents('tr'));
            });
            if(ids.length == 0){
                Swal.fire({
                    type:'error',
                    title:'Error',
                    text:'Please checked at least one row of table!',
                    icon: 'warning',
                });
            }else{
                let url = "{{route('finished.goods.bulk.delete')}}";
                bulk_delete(ids,url,table,rows);
            }
        }

        $(document).on('click', '.change_status', function () {
            let id     = $(this).data('id');
            let name   = $(this).data('name');
            let status = $(this).data('status');
            let row    = table.row($(this).parent('tr'));
            let url    = "{{ route('finished.goods.change.status') }}";
            change_status(id, url, table, row, name, status);
        });
    
    
    });

    
    function populate_unit(unit_id,sale_unit_id='')
    {
        $.ajax({
            url:"{{ url('populate-unit') }}/"+unit_id,
            type:"GET",
            dataType:"JSON",
            success:function(data){
                $('#sale_unit_id').empty();
                $.each(data, function(key, value) {
                    $('#sale_unit_id').append('<option value="'+ key +'">'+ value +'</option>');
                });
                $('.selectpicker').selectpicker('refresh');
                if(sale_unit_id){
                    $('#sale_unit_id').val(sale_unit_id);
                }
                $('.selectpicker').selectpicker('refresh');
            },
        });
    }
    </script>
@endpush