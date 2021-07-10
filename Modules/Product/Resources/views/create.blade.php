@extends('layouts.app')

@section('title', $page_title)

@push('styles')
<style>
    .tox-tinymce{
        height: 300px !important;
    }
</style>
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
                    <a href="{{ route('product') }}" class="btn btn-warning btn-sm font-weight-bolder"> 
                        <i class="fas fa-arrow-left"></i> Back</a>
                    <!--end::Button-->
                </div>
            </div>
        </div>
        <!--end::Notice-->
        <!--begin::Card-->
        <div class="card card-custom" style="padding-bottom: 100px !important;">
            <div class="card-header card-header-tabs-line">
                <div class="card-toolbar">
                    <ul class="nav nav-tabs nav-bold nav-tabs-line">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#kt_tab_general">
                                <span class="nav-icon"><i class="fab fa-product-hunt"></i></span>
                                <span class="nav-text">General</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#kt_tab_materials">
                                <span class="nav-icon"><i class="fas fa-toolbox"></i></span>
                                <span class="nav-text">Materials</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#kt_tab_variants">
                                <span class="nav-icon"><i class="fas fa-box"></i></span>
                                <span class="nav-text">Variants</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="card-toolbar">
                    @if (!isset($product))
                    <button type="button" class="btn btn-danger btn-sm mr-3">Reset</button>
                    @else 
                    <a href="{{ route('product') }}" class="btn btn-danger btn-sm mr-3">Cnacel</a>
                    @endif
                    <button type="button" class="btn btn-primary btn-sm mr-3" id="save-btn" onclick="store_data(1)">{{ isset($product) ? 'Update' : 'Save' }}</button>
                    @if (!isset($product))
                    <button type="button" class="btn btn-success btn-sm" id="add-another-btn" onclick="store_data(2)">Save And Add Another</button>
                    @endif
                </div>
            </div>
            <div class="card-body">
                <form id="store_or_update_form" method="post" enctype="multipart/form-data">
                    @csrf
                    <input type="hidden" name="update_id" id="update_id" value="{{ isset($product) ? $product->id : '' }}" />
                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="kt_tab_general" role="tabpanel" aria-labelledby="kt_tab_general">
                            <div class="row">
                                <div class="col-md-10">
                                    <div class="row">
                                        <x-form.textbox labelName="Product Name" name="product_name" value="{{ isset($product) ? $product->product_name : '' }}" required="required" col="col-md-6" placeholder="Enter product name"/>
                                        <x-form.selectbox labelName="Type" name="type" required="required" col="col-md-6" class="selectpicker">
                                            @foreach (PRODUCT_TYPE as $key => $value)
                                                <option value="{{ $key }}" {{ isset($product) ? (($product->type == $key) ? 'selected' : '')  : '' }}>{{ $value }}</option>
                                            @endforeach
                                        </x-form.selectbox>

                                        <x-form.selectbox labelName="Category" name="category_id" required="required" col="col-md-6" class="selectpicker">
                                            @if (!$categories->isEmpty())
                                                @foreach ($categories as $category)
                                                <option value="{{ $category->id }}" {{ isset($product) ? (($product->category_id == $category->id) ? 'selected' : '')  : '' }}>{{ $category->name }}</option>
                                                @endforeach
                                            @endif
                                        </x-form.selectbox>

                                        <div class="col-md-6 form-group">
                                            <label for="tax_id">Product Tax</label>
                                            <select name="tax_id" id="tax_id" required="required" class="form-control selectpicker">
                                                <option value="0" selected>No Tax</option>
                                                @if (!$taxes->isEmpty())
                                                    @foreach ($taxes as $tax)
                                                        <option value="{{ $tax->id }}"  {{ isset($product) ? (($product->tax_id == $tax->id) ? 'selected' : '')  : '' }}>{{ $tax->name }}</option>
                                                    @endforeach 
                                                @endif
                                            </select>
                                        </div>

                                        <div class="col-md-6 form-group">
                                            <label for="tax_method">Tax Method<span class="text-danger">*</span> <i class="fas fa-info-circle" data-toggle="tooltip" 
                                                data-theme="dark" title="Exclusive: Poduct price = Actual product price + Tax. Inclusive: Actual product price = Product price - Tax"></i></label>
                                            <select name="tax_method" id="tax_method" required="required" class="form-control selectpicker">
                                            @foreach (TAX_METHOD as $key => $value)
                                                <option value="{{ $key }}" 
                                                @if(isset($product)) @if($product->tax_method == $key) {{ 'selected' }} @endif @else  @if($key == 1){{ 'selected' }} @endif @endif>{{ $value }}</option>
                                            @endforeach
                                            </select>
                                        </div>

                                        <div class="form-group col-md-6">
                                            <label for="description">Description</label>
                                            <textarea class="form-control" name="description" id="description">{{ isset($product) ? $product->description : '' }}</textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="row">
                                        <div class="form-group col-md-12 mb-0">
                                            <label for="logo" class="form-control-label">Product Image</label>
                                            <div class="col=md-12 px-0  text-center">
                                                <div id="product_image">
                                
                                                </div>
                                            </div>
                                            <input type="hidden" name="old_product_image" id="old_product_image"  value="{{ isset($product) ? (!empty($product->product_image) ? $product->product_image : '') : '' }}">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="kt_tab_materials" role="tabpanel" aria-labelledby="kt_tab_materials">
                            <div class="row">
                                <div class="col-md-12 material_section">
                                    @if (isset($product))
                                        @if (!$product->product_material->isEmpty())
                                            @foreach ($product->product_material as $key => $value)
                                            <div class="row {{ ($key == 0) ? '' : 'row_remove' }}">
                                                <div class="form-group col-md-5 required">
                                                    <label for="materials_{{ $key+1 }}_id" class="form-control-label">Material Name</label>
                                                    <select name="materials[{{ $key+1 }}][id]" id="materials_{{ $key+1 }}_id" required="required" class="form-control selectpicker" data-live-search="true" 
                                                    data-live-search-placeholder="Search">
                                                        <option value="">Select Please</option>
                                                        @if (!$materials->isEmpty())
                                                            @foreach ($materials as $material)
                                                                <option value="{{ $material->id }}" {{ ($value->id == $material->id) ? 'selected' : '' }}>{{ $material->material_name }}</option>
                                                            @endforeach 
                                                        @endif
                                                    </select>
                                                </div>
                                                @if ($key == 0)
                                                <div class="form-group col-md-2" style="padding-top: 28px;">
                                                    <button type="button" id="add" class="btn btn-success btn-sm" data-toggle="tooltip" 
                                                        data-placement="top" data-original-title="Add More">
                                                        <i class="fas fa-plus-square"></i>
                                                        </button>
                                                </div>
                                                @else
                                                <div class="form-group col-md-2" style="padding-top:20px;">
                                                    <button type="button" class="btn btn-danger btn-sm remove" data-toggle="tooltip" 
                                                        data-placement="top" data-original-title="Remove">
                                                        <i class="fas fa-minus-square"></i>
                                                    </button>
                                                </div>
                                                @endif
                                            </div>
                                            @endforeach
                                        @endif
                                    @else
                                        <div class="row">
                                            <div class="form-group col-md-5 required">
                                                <label for="materials_1_id" class="form-control-label">Material Name</label>
                                                <select name="materials[1][id]" id="materials_1_id" required="required" class="form-control selectpicker" data-live-search="true" 
                                                data-live-search-placeholder="Search">
                                                    <option value="">Select Please</option>
                                                    @if (!$materials->isEmpty())
                                                        @foreach ($materials as $material)
                                                            <option value="{{ $material->id }}">{{ $material->material_name }}</option>
                                                        @endforeach 
                                                    @endif
                                                </select>
                                            </div>
                                            <div class="form-group col-md-2" style="padding-top: 28px;">
                                                <button type="button" id="add" class="btn btn-success btn-sm" data-toggle="tooltip" 
                                                    data-placement="top" data-original-title="Add More">
                                                    <i class="fas fa-plus-square"></i>
                                                    </button>
                                            </div>
                                        </div>
                                    @endif
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="kt_tab_variants" role="tabpanel" aria-labelledby="kt_tab_variants">
                            <div class="row">
                                <div class="col-md-12 variants_section">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <table class="table table-bordered">
                                                <thead class="bg-primary">
                                                    <th>Size<sup><b class="text-danger">*</b></sup></th>
                                                    <th>Barcode<sup><b class="text-danger">*</b></sup></th>
                                                    <th class="text-center">Unit<sup><b class="text-danger">*</b></sup></th>
                                                    <th class="text-center">Sale Unit<sup><b class="text-danger">*</b></sup></th>
                                                    <th class="text-right">Cost</th>
                                                    <th class="text-right">Sale Price<sup><b class="text-danger">*</b></sup></th>
                                                    <th class="text-center">Qty</th>
                                                    <th class="text-center">Alert Qty</th>
                                                    <th></th>
                                                </thead>
                                                <tbody>
                                                    @if (isset($product))
                                                        @if (!$product->product_size->isEmpty())
                                                            @foreach ($product->product_size as $key => $value)
                                                            <tr class="{{ ($key == 0) ? '' : 'variant_remove' }}">
                                                                <td width="10%">
                                                                    <div class="form-group my-0">
                                                                        <input type="hidden" name="variants[{{ $key+1 }}][id]" value="{{ $value->pivot->id }}">
                                                                        <select name="variants[{{ $key+1 }}][size_id]" id="variants_{{ $key+1 }}_size_id" required="required" class="form-control selectpicker" data-live-search="true" 
                                                                        data-live-search-placeholder="Search">
                                                                            <option value="">Select Please</option>
                                                                            @if (!$sizes->isEmpty())
                                                                                @foreach ($sizes as $size)
                                                                                    <option value="{{ $size->id }}" {{ ($value->id == $size->id) ? 'selected' : '' }}>{{ $size->size.' '.$size->unit->unit_name  }}</option>
                                                                                @endforeach 
                                                                            @endif
                                                                        </select>
                                                                    </div>
                                                                </td>
                                                                <td width="15%">
                                                                    <div class="form-group my-0">
                                                                        <input type="text" class="form-control" name="variants[{{ $key+1 }}][code]" value="{{ $value->pivot->code }}" id="variants_{{ $key+1 }}_code" readonly>
                                                                    </div>
                                                                </td>
                                                                <td width="15%">
                                                                    <div class="form-group my-0">
                                                                        <select name="variants[{{ $key+1 }}][unit_id]" id="variants_{{ $key+1 }}_unit_id" required="required" onchange="populate_unit(unit_id=this.value,row='{{ $key+1 }}')" class="form-control selectpicker unit_id" data-live-search="true" 
                                                                        data-live-search-placeholder="Search">
                                                                            <option value="">Select Please</option>
                                                                            @if (!$units->isEmpty())
                                                                                @foreach ($units as $unit)
                                                                                    @if ($unit->base_unit == null)
                                                                                    <option value="{{ $unit->id }}" {{ ($value->pivot->unit_id == $unit->id) ? 'selected' : '' }}>{{ $unit->unit_name.' ('.$unit->unit_code.')' }}</option>
                                                                                    @endif
                                                                                @endforeach
                                                                            @endif
                                                                        </select>
                                                                    </div>
                                                                </td>
                                                                <td width="15%">
                                                                    <div class="form-group my-0">
                                                                        <select name="variants[{{ $key+1 }}][sale_unit_id]" id="variants_{{ $key+1 }}_sale_unit_id" required="required" class="form-control selectpicker sale_unit_id" data-live-search="true" 
                                                                        data-live-search-placeholder="Search">
                                                                        @php
                                                                            $sale_units = \DB::table('units')->where('base_unit',$value->pivot->unit_id)
                                                                            ->orWhere('id',$value->pivot->unit_id)->get();
                                                                        @endphp
                                                                        @if (!$sale_units->isEmpty())
                                                                            @foreach ($sale_units as $unit)
                                                                            <option value="{{ $unit->id }}" {{ ($value->pivot->unit_id == $unit->id) ? 'selected' : '' }}>{{ $unit->unit_name.' ('.$unit->unit_code.')' }}</option>
                                                                            @endforeach
                                                                        @endif
                                                                        </select>
                                                                    </div>
                                                                </td>
                                                                <td width="10%">
                                                                    <div class="form-group my-0">
                                                                        <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][cost]" id="variants_{{ $key+1 }}_cost"  value="{{ $value->pivot->cost }}" placeholder="0.00">
                                                                    </div>
                                                                </td>
                                                                <td  width="10%">
                                                                    <div class="form-group my-0">
                                                                        <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][price]" id="variants_{{ $key+1 }}_price"  value="{{ $value->pivot->price }}" placeholder="0.00">
                                                                    </div>
                                                                </td>
                                                            
                                                                <td width="10%">
                                                                    <div class="form-group my-0">
                                                                        <input type="text" class="form-control text-center" name="variants[{{ $key+1 }}][qty]" id="variants_{{ $key+1 }}_qty" value="{{ $value->pivot->qty ? $value->pivot->qty : 0 }}" placeholder="0.00">
                                                                    </div>
                                                                </td>
                                                                <td width="10%">
                                                                    <div class="form-group my-0">
                                                                        <input type="text" class="form-control text-center" name="variants[{{ $key+1 }}][alert_qty]" id="variants_{{ $key+1 }}_alert_qty" value="{{ $value->pivot->alert_qty ? $value->pivot->alert_qty : 0 }}" placeholder="0.00">
                                                                    </div>
                                                                </td>
                                                                <td width="5%">
                                                                    <div class="form-group my-0">
                                                                        @if ($key == 0)
                                                                        <button type="button" id="add_variant" class="btn btn-success btn-sm" data-toggle="tooltip" 
                                                                            data-placement="top" data-original-title="Add More">
                                                                            <i class="fas fa-plus-square"></i>
                                                                            </button>
                                                                        @else 
                                                                        <button type="button" class="btn btn-danger btn-sm remove_variant" data-toggle="tooltip" 
                                                                            data-placement="top" data-original-title="Remove">
                                                                            <i class="fas fa-minus-square"></i>
                                                                        </button>
                                                                        @endif
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            @endforeach
                                                        @endif
                                                    @else
                                                    <tr>
                                                        <td width="10%">
                                                            <div class="form-group my-0">
                                                                <select name="variants[1][size_id]" id="variants_1_size_id" required="required" class="form-control selectpicker" data-live-search="true" 
                                                                data-live-search-placeholder="Search">
                                                                    <option value="">Select Please</option>
                                                                    @if (!$sizes->isEmpty())
                                                                        @foreach ($sizes as $size)
                                                                            <option value="{{ $size->id }}">{{ $size->size.' '.$size->unit->unit_name  }}</option>
                                                                        @endforeach 
                                                                    @endif
                                                                </select>
                                                            </div>
                                                        </td>
                                                        <td width="15%">
                                                            <div class="form-group my-0">
                                                                {{-- <div class="input-group"> --}}
                                                                    <input type="text" class="form-control" name="variants[1][code]" id="variants_1_code">
                                                                    {{-- <div class="input-group-prepend" onclick="generate_variant_code(1)">
                                                                        <span class="input-group-text bg-primary" id="generate-code-1"  data-toggle="tooltip" data-theme="dark" title="Generate Code"
                                                                        style="border-top-right-radius: 0.42rem;border-bottom-right-radius: 0.42rem;border:0;cursor: pointer;">
                                                                            <i class="fas fa-retweet text-white"></i>
                                                                        </span>
                                                                    </div>
                                                                </div> --}}
                                                            </div>
                                                        </td>
                                                        <td width="15%">
                                                            <div class="form-group my-0">
                                                                <select name="variants[1][unit_id]" id="variants_1_unit_id" required="required" onchange="populate_unit(unit_id=this.value,row='1')" class="form-control selectpicker unit_id" data-live-search="true" 
                                                                data-live-search-placeholder="Search">
                                                                    <option value="">Select Please</option>
                                                                    @if (!$units->isEmpty())
                                                                        @foreach ($units as $unit)
                                                                            @if ($unit->base_unit == null)
                                                                            <option value="{{ $unit->id }}">{{ $unit->unit_name.' ('.$unit->unit_code.')' }}</option>
                                                                            @endif
                                                                        @endforeach
                                                                    @endif
                                                                </select>
                                                            </div>
                                                        </td>
                                                        <td width="15%">
                                                            <div class="form-group my-0">
                                                                <select name="variants[1][sale_unit_id]" id="variants_1_sale_unit_id" required="required" class="form-control selectpicker sale_unit_id" data-live-search="true" 
                                                                data-live-search-placeholder="Search">
                                                                </select>
                                                            </div>
                                                        </td>
                                                        <td width="10%">
                                                            <div class="form-group my-0">
                                                                <input type="text" class="form-control text-right" name="variants[1][cost]" id="variants_1_cost" placeholder="0.00">
                                                            </div>
                                                        </td>
                                                        <td  width="10%">
                                                            <div class="form-group my-0">
                                                                <input type="text" class="form-control text-right" name="variants[1][price]" id="variants_1_price" placeholder="0.00">
                                                            </div>
                                                        </td>
                                                        
                                                        <td width="10%">
                                                            <div class="form-group my-0">
                                                                <input type="text" class="form-control text-center" name="variants[1][qty]" id="variants_1_qty" placeholder="0.00">
                                                            </div>
                                                        </td>
                                                        <td width="10%">
                                                            <div class="form-group my-0">
                                                                <input type="text" class="form-control text-center" name="variants[1][alert_qty]" id="variants_1_alert_qty" placeholder="0.00">
                                                            </div>
                                                        </td>
                                                        <td width="5%">
                                                            <div class="form-group my-0">
                                                                <button type="button" id="add_variant" class="btn btn-success btn-sm" data-toggle="tooltip" 
                                                                    data-placement="top" data-original-title="Add More">
                                                                    <i class="fas fa-plus-square"></i>
                                                                    </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    @endif
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!--end::Card-->
    </div>
</div>
@endsection

@push('scripts')
<script src="js/spartan-multi-image-picker-min.js"></script>
<script>
@if (isset($product))
    @if (!$product->product_material->isEmpty())
    var count = "{{ count($product->product_material) + 1 }}";
    @else 
    var count = 1;
    @endif
    @if (!$product->product_size->isEmpty())
    var variant_count = "{{ count($product->product_size) + 1 }}";
    @else 
    var variant_count = 1;
    @endif
@else 
    var count = 1;
    var variant_count = 1;
@endif


$(document).ready(function () {

    $("#product_image").spartanMultiImagePicker({
        fieldName:        'product_image',
        maxCount: 1,
        rowHeight:        '200px',
        groupClassName:   'col-md-12 col-sm-12 col-xs-12',
        maxFileSize:      '',
        dropFileLabel : "Drop Here",
        allowedExt: 'png|jpg|jpeg',
        onExtensionErr : function(index, file){
            Swal.fire({icon: 'error',title: 'Oops...',text: 'Only png,jpg,jpeg file format allowed!'});
        },

    });

    $("input[name='product_image']").prop('required',true);

    $('.remove-files').on('click', function(){
        $(this).parents(".col-md-12").remove();
    });

    $(document).on('change','#barcode_symbology', function(){
        if($('#barcode_symbology option:selected').val() != ''){
            $('#product_code').prop('disabled',false);
        }else{
            $('#product_code').prop('disabled',true);
        }
    });

    @if (isset($product))
        @if(!empty($product->product_image))
            $('#product_image img.spartan_image_placeholder').css('display','none');
            $('#product_image .spartan_remove_row').css('display','none');
            $('#product_image .img_').css('display','block');
            $('#product_image .img_').attr('src',"{{ asset('storage/'.PRODUCT_IMAGE_PATH.$product->product_image)}}");
        @endif
    @endif
    
    function add_more_material_field(row){
        html = ` <div class="row row_remove">
                    <div class="form-group col-md-5 required">
                        <select name="materials[`+row+`][id]" id="materials_`+row+`_id" required="required" class="form-control selectpicker">
                            <option value="">Select Please</option>
                            @if (!$materials->isEmpty())
                                @foreach ($materials as $material)
                                    <option value="{{ $material->id }}">{{ $material->material_name }}</option>
                                @endforeach 
                            @endif
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <button type="button" class="btn btn-danger btn-sm remove" data-toggle="tooltip" 
                            data-placement="top" data-original-title="Remove">
                            <i class="fas fa-minus-square"></i>
                        </button>
                    </div>
                </div>`;
        $('.material_section').append(html);
        $('.selectpicker').selectpicker('refresh');
    }

    $(document).on('click','#add',function(){
        count++;
        add_more_material_field(count);
    });
    $(document).on('click','.remove',function(){
        count--;
        $(this).closest('.row_remove').remove();
    });


    function add_more_product_variant(row)
    {
        html = `<tr class="variant_remove">
                    <td width="10%">
                        <div class="form-group my-0">
                            <select name="variants[`+row+`][size_id]" id="variants_`+row+`_size_id" required="required" class="form-control selectpicker" data-live-search="true" 
                            data-live-search-placeholder="Search">
                                <option value="">Select Please</option>
                                @if (!$sizes->isEmpty())
                                    @foreach ($sizes as $size)
                                        <option value="{{ $size->id }}">{{ $size->size.' '.$size->unit->unit_name }}</option>
                                    @endforeach 
                                @endif
                            </select>
                        </div>
                    </td>
                    <td width="15%">
                        <div class="form-group my-0">
                            <input type="text" class="form-control" name="variants[`+row+`][code]" id="variants_`+row+`_code">
                        </div>
                    </td>
                    <td width="15%">
                        <div class="form-group my-0">
                            <select name="variants[`+row+`][unit_id]" id="variants_`+row+`_unit_id" required="required" onchange="populate_unit(unit_id=this.value,row=`+row+`)" class="form-control selectpicker unit_id" data-live-search="true" 
                            data-live-search-placeholder="Search">
                                <option value="">Select Please</option>
                                @if (!$units->isEmpty())
                                    @foreach ($units as $unit)
                                        @if ($unit->base_unit == null)
                                        <option value="{{ $unit->id }}">{{ $unit->unit_name.' ('.$unit->unit_code.')' }}</option>
                                        @endif
                                    @endforeach
                                @endif
                            </select>
                        </div>
                    </td>
                    <td width="15%">
                        <div class="form-group my-0">
                            <select name="variants[`+row+`][sale_unit_id]" id="variants_`+row+`_sale_unit_id" required="required" class="form-control selectpicker sale_unit_id" data-live-search="true" 
                            data-live-search-placeholder="Search">
                            </select>
                        </div>
                    </td>
                    <td width="10%">
                        <div class="form-group my-0">
                            <input type="text" class="form-control text-right" name="variants[`+row+`][cost]" id="variants_`+row+`_cost" placeholder="0.00">
                        </div>
                    </td>
                    <td  width="10%">
                        <div class="form-group my-0">
                            <input type="text" class="form-control text-right" name="variants[`+row+`][price]" id="variants_`+row+`_price" placeholder="0.00">
                        </div>
                    </td>
                    
                    <td width="10%">
                        <div class="form-group my-0">
                            <input type="text" class="form-control text-center" name="variants[`+row+`][qty]" id="variants_`+row+`_qty" placeholder="0.00">
                        </div>
                    </td>
                    <td width="10%">
                        <div class="form-group my-0">
                            <input type="text" class="form-control text-center" name="variants[`+row+`][alert_qty]" id="variants_`+row+`_alert_qty" placeholder="0.00">
                        </div>
                    </td>
                    <td width="5%">
                        <div class="form-group my-0">
                            <button type="button" class="btn btn-danger btn-sm remove_variant" data-toggle="tooltip" 
                                data-placement="top" data-original-title="Remove">
                                <i class="fas fa-minus-square"></i>
                            </button>
                        </div>
                    </td>
                </tr>`;
        $('.variants_section table tbody').append(html);
        $('#variants_'+row+'_size_id.selectpicker,#variants_'+row+'_stock_unit.selectpicker,#variants_'+row+'_sale_unit.selectpicker').val('');
        $('.selectpicker').selectpicker('refresh');
    }

    $(document).on('click','#add_variant',function(){
        variant_count++;
        add_more_product_variant(variant_count);
    });
    $(document).on('click','.remove_variant',function(){
        variant_count--;
        $(this).closest('.variants_section table tbody tr').remove();
    });
    
});

function populate_unit(unit_id,row,sale_unit_id='')
{
    $.ajax({
        url:"{{ url('populate-unit') }}/"+unit_id,
        type:"GET",
        dataType:"JSON",
        success:function(data){
            $('#variants_'+row+'_sale_unit_id').empty();
            $.each(data, function(key, value) {
                $('#variants_'+row+'_sale_unit_id').append('<option value="'+ key +'">'+ value +'</option>');
            });
            $('#variants_'+row+'_sale_unit_id.selectpicker').selectpicker('refresh');
            if(sale_unit_id){
                $('#variants_'+row+'_sale_unit_id').val(sale_unit_id);
            }
            $('#variants_'+row+'_sale_unit_id.selectpicker').selectpicker('refresh');
        },
    });
}

function store_data(btn){
    let form = document.getElementById('store_or_update_form');
    let formData = new FormData(form);
    let url = "{{route('product.store.or.update')}}";
    let id = $('#update_id').val();
    let method;
    if (id) {
        method = 'update';
    } else {
        method = 'add';
    }
    $.ajax({
        url: url,
        type: "POST",
        data: formData,
        dataType: "JSON",
        contentType: false,
        processData: false,
        cache: false,
        beforeSend: function(){
            $('#save-btn').addClass('spinner spinner-white spinner-right');
        },
        complete: function(){
            $('#save-btn').removeClass('spinner spinner-white spinner-right');
        },
        success: function (data) {
            $('#store_or_update_form').find('.is-invalid').removeClass('is-invalid');
            $('#store_or_update_form').find('.error').remove();
            if (data.status == false) {
                $.each(data.errors, function (key, value) {
                    var key = key.split('.').join('_');
                    $('#store_or_update_form input#' + key).addClass('is-invalid');
                    $('#store_or_update_form textarea#' + key).addClass('is-invalid');
                    $('#store_or_update_form select#' + key).parent().addClass('is-invalid');
                    $('#store_or_update_form #' + key).parent().append(
                    '<small class="error text-danger">' + value + '</small>');
                    
                    
                    
                });
            } else {
                notification(data.status, data.message);
                if (data.status == 'success') {
                    if($('#update_id').val() == '')
                    {
                        if(btn == 1){
                            window.location.replace("{{ route('product') }}");
                        }else{
                            // $('#store_or_update_form')[0].reset();
                            // $('#store_or_update_form .selectpicker').selectpicker('refresh');
                            // $('#store_or_update_form .spartan_image_placeholder').css('display','block');
                            // $('#store_or_update_form .spartan_remove_row').css('display','none');
                            // $('#store_or_update_form .img_').css('display','none');
                            // $('#store_or_update_form .img_').attr('src','');

                            // $('#store_or_update_form .row_remove').remove();
                            // $('#store_or_update_form table tbody .variant_remove').remove();
                            // count = 1;
                            // count = 1;
                            window.location.replace("{{ route('product.add') }}");
                        }
                    }else{
                        window.location.replace("{{ route('product') }}");
                    }
                    
                    
                }
            }

        },
        error: function (xhr, ajaxOption, thrownError) {
            console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
        }
    });
}

</script>
@endpush