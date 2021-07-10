@extends('layouts.asm-app')

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
                <div class="card-toolbar">
                    <!--begin::Button-->
                    <a href="javascript:void(0);" onclick="showFormModal('Add New Customer','Save')" class="btn btn-primary btn-sm font-weight-bolder"> 
                        <i class="fas fa-plus-circle"></i> Add New</a>
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
                        <x-form.textbox labelName="Shop Name" name="shop_name" col="col-md-3" />
                        <x-form.textbox labelName="Customer Name" name="name" col="col-md-3" />
                        <x-form.textbox labelName="Mobile" name="mobile" col="col-md-3" />
                        
                        <x-form.selectbox labelName="Customer Group" name="customer_group_id" col="col-md-3" class="selectpicker">
                            @if (!$customer_groups->isEmpty())
                                @foreach ($customer_groups as $value)
                                <option value="{{ $value->id }}">{{ $value->group_name }}</option>
                                @endforeach
                            @endif
                        </x-form.selectbox>

                        <x-form.selectbox labelName="Upazila" name="upazila_id" col="col-md-3" class="selectpicker" onchange="upazilaRouteList(this.value,1)">
                            @if (!$upazilas->isEmpty())
                                @foreach ($upazilas as $value)
                                <option value="{{ $value->id }}">{{ $value->name }}</option>
                                @endforeach
                            @endif
                        </x-form.selectbox>

                        <x-form.selectbox labelName="Route" name="route_id" col="col-md-3" class="selectpicker">
                            @if (!$routes->isEmpty())
                                @foreach ($routes as $value)
                                <option value="{{ $value->id }}">{{ $value->name }}</option>
                                @endforeach
                            @endif
                        </x-form.selectbox>

                        <x-form.selectbox labelName="Status" name="status" col="col-md-3" class="selectpicker">
                            @foreach (STATUS as $key => $value)
                                <option value="{{ $key }}">{{ $value }}</option>
                            @endforeach
                        </x-form.selectbox>
                        
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
                                        <th>Customer Name</th>
                                        <th>Shop Name</th>
                                        <th>Mobile No.</th>
                                        <th>Group Name</th>
                                        <th>Upazila</th>
                                        <th>Route</th>
                                        <th>Postal Code</th>
                                        <th>Status</th>
                                        <th>Balance</th>
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
@include('asm::customer.modal')
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
                "url": "{{route('asm.customer.datatable.data')}}",
                "type": "POST",
                "data": function (data) {
                    data.name   = $("#form-filter #name").val();
                    data.shop_name   = $("#form-filter #shop_name").val();
                    data.mobile = $("#form-filter #mobile").val();
                    data.customer_group_id  = $("#form-filter #customer_group_id option:selected").val();
                    data.upazila_id  = $("#form-filter #upazila_id option:selected").val();
                    data.route_id  = $("#form-filter #route_id option:selected").val();
                    data.status = $("#form-filter #status").val();
                    data._token = _token;
                }
            },
            "columnDefs": [{
                    "targets": [10],
                    "orderable": false,
                    "className": "text-center"
                },
                {
                    "targets": [3,4,5,6,7,8],
                    "className": "text-center"
                },
                {
                    "targets": [9],
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
            let url = "{{route('asm.customer.store.or.update')}}";
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
            $('#store_or_update_form').find('.is-invalid').removeClass('is-invalid');
            $('#store_or_update_form').find('.error').remove();
            if (id) {
                $.ajax({
                    url: "{{route('asm.customer.edit')}}",
                    type: "POST",
                    data: { id: id,_token: _token},
                    dataType: "JSON",
                    success: function (data) {
                        if(data.status == 'error'){
                            notification(data.status,data.message)
                        }else{
                            $('#store_or_update_form #update_id').val(data.id);
                            $('#store_or_update_form #name,#store_or_update_form #old_name').val(data.name);
                            $('#store_or_update_form #shop_name').val(data.shop_name);
                            $('#store_or_update_form #mobile').val(data.mobile);
                            $('#store_or_update_form #email').val(data.email);
                            $('#store_or_update_form #customer_group_id').val(data.customer_group_id);
                            $('#store_or_update_form #district_id').val(data.district_id);
                            $('#store_or_update_form #upazila_id').val(data.upazila_id);
                            $('#store_or_update_form #postal_code').val(data.postal_code);
                            $('#store_or_update_form #address').val(data.address);
                            $('#store_or_update_form #previous_balance, #store_or_update_form #old_previous_balance').val(data.previous_balance.debit);
                            $('#store_or_update_form .selectpicker').selectpicker('refresh');
                            upazilaRouteList(data.upazila_id,2,data.route_id);
                            $('#store_or_update_modal').modal({
                                keyboard: false,
                                backdrop: 'static',
                            });
                            $('#store_or_update_modal .modal-title').html(
                                '<i class="fas fa-edit text-white"></i> <span>Edit ' + data.name + '</span>');
                            $('#store_or_update_modal #save-btn').text('Update');
                        }
                        
                    },
                    error: function (xhr, ajaxOption, thrownError) {
                        console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
                    }
                });
            }
        });
    

        $(document).on('click', '.change_status', function () {
            let id     = $(this).data('id');
            let name   = $(this).data('name');
            let status = $(this).data('status');
            let row    = table.row($(this).parent('tr'));
            let url    = "{{ route('asm.customer.change.status') }}";
            change_status(id, url, table, row, name, status);
        });
    
    
    });
    function upazilaRouteList(upazila_id,set_id,route_id='')
    {
        if(upazila_id){
            $.ajax({
                url:"{{ url('asm/upazila-id-wise-route-list') }}/"+upazila_id,
                type:"GET",
                dataType:"JSON",
                success:function(data){
                    html = `<option value="">Select Please</option>`;
                    $.each(data, function(key, value) {
                        html += '<option value="'+ key +'">'+ value +'</option>';
                    });
                    
                    if(set_id == 1)
                    {
                        $('#form-filter #route_id').empty();
                        $('#form-filter #route_id').append(html);
                    }else{
                        $('#store_or_update_form #route_id').empty();
                        $('#store_or_update_form #route_id').append(html);
                    }
                    $('.selectpicker').selectpicker('refresh');
                    if(route_id){
                        $('#store_or_update_form #route_id').val(route_id);
                        $('#store_or_update_form #route_id.selectpicker').selectpicker('refresh');
                    }
                    
                },
            });
        }
    }
    </script>
@endpush
