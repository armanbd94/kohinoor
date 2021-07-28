@extends('layouts.app')

@section('title', $page_title)

@push('styles')
<link href="css/tagify.css" rel="stylesheet" type="text/css" />
<style>
    .tagsinput{
        height: calc(1.5em + 1.3rem + 2px) !important;
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
            <div class="card-body">
                <form id="store_or_update_form" method="post" enctype="multipart/form-data">
                    @csrf
                    <div class="row">
                        <div class="col-md-10">
                            <div class="row">
                                <input type="hidden" name="update_id" id="update_id" value="{{ $product->id }}">
        
                                <x-form.textbox labelName="Product Name" name="name" required="required" value="{{ $product->name }}" col="col-md-4" placeholder="Enter product name"/>
                                
                                <div class="col-md-4 form-group required code {{ $product->type == 2 ? 'd-none' : '' }}">
                                    <label for="code">Code</label>
                                    <div class="input-group" id="code_section">
                                        <input type="text" class="form-control" name="code" id="code" value="{{ $product->type == 1 ? $product->code : '' }}">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-primary" id="generate-code"  data-toggle="tooltip" data-theme="dark" title="Generate Code"
                                            style="border-top-right-radius: 0.42rem;border-bottom-right-radius: 0.42rem;border:0;cursor: pointer;">
                                                <i class="fas fa-retweet text-white"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <x-form.selectbox labelName="Barcode Symbology" name="barcode_symbology" required="required" col="col-md-4" class="selectpicker">
                                    @foreach (BARCODE_SYMBOL as $key => $value)
                                        <option value="{{ $key }}" {{ ($key == $product->barcode_symbology) ? 'selected' : '' }}>{{ $value }}</option>
                                    @endforeach
                                </x-form.selectbox> 

                                <x-form.selectbox labelName="Category" name="category_id" required="required" col="col-md-4" class="selectpicker">
                                    @if (!$categories->isEmpty())
                                        @foreach ($categories as $category)
                                        <option value="{{ $category->id }}"  {{ $product->category_id == $category->id ? 'selected' : '' }}>{{ $category->name }}</option>
                                        @endforeach
                                    @endif
                                </x-form.selectbox>
                                
                                <div class="form-group col-md-4 required unit">
                                    <label for="base_unit_id">Base Unit</label>
                                    <select name="base_unit_id" id="base_unit_id"  onchange="populate_unit(this.value,1)" class="form-control selectpicker" data-live-search="true"  data-live-search-placeholder="Search">
                                        <option value="">Select Please</option>
                                        @if (!$units->isEmpty())
                                            @foreach ($units as $unit)
                                                @if ($unit->base_unit == null)
                                                <option value="{{ $unit->id }}" {{ $product->base_unit_id == $unit->id ? 'selected' : '' }}>{{ $unit->unit_name.' ('.$unit->unit_code.')' }}</option>
                                                @endif
                                            @endforeach
                                        @endif
                                    </select>
                                </div>
        
                                <div class="form-group col-md-4 required unit">
                                    <label for="unit_id">Unit</label>
                                    <select name="unit_id" id="unit_id"  class="form-control selectpicker" data-live-search="true"  data-live-search-placeholder="Search">
                                    @php
                                        $sale_units = \DB::table('units')->where('base_unit',$product->unit_id)
                                        ->orWhere('id',$product->unit_id)->get();
                                    @endphp
                                    @if (!$sale_units->isEmpty())
                                        @foreach ($sale_units as $unit)
                                        <option value="{{ $unit->id }}" {{ ($product->unit_id == $unit->id) ? 'selected' : '' }}>{{ $unit->unit_name.' ('.$unit->unit_code.')' }}</option>
                                        @endforeach
                                    @endif
                                    </select>
                                </div>
                                @if ($product->type == 1)
                                <x-form.textbox labelName="MRP (Price) Base Unit" name="base_unit_mrp" value="{{ $product->base_unit_mrp }}" required="required" col="col-md-4 price" placeholder="Enter product price"/>
                                <x-form.textbox labelName="TP (Price) Base Unit" name="base_unit_price" value="{{ $product->base_unit_price }}" required="required" col="col-md-4 price" placeholder="Enter product price"/>
                                <x-form.textbox labelName="MRP (Price) Unit" name="unit_mrp" value="{{ $product->unit_mrp }}" required="required" col="col-md-4 price" placeholder="Enter product price"/>
                                <x-form.textbox labelName="TP (Price) Unit" name="unit_price" value="{{ $product->unit_price }}" required="required" col="col-md-4 price" placeholder="Enter product price"/>
                                <x-form.textbox labelName="Alert Quantity" name="alert_quantity" value="{{ $product->alert_quantity }}"  col="col-md-4 alert-qty" placeholder="Enter product alert qty"/>
                                @endif

                                <div class="col-md-4 form-group">
                                    <label for="tax_id">Product Tax</label>
                                    <select name="tax_id" id="tax_id" required="required" class="form-control selectpicker">
                                        <option value="0" selected>No Tax</option>
                                        @if (!$taxes->isEmpty())
                                            @foreach ($taxes as $tax)
                                                <option value="{{ $tax->id }}"  {{ $product->tax_id == $tax->id ? 'selected' : '' }}>{{ $tax->name }}</option>
                                            @endforeach 
                                        @endif
                                    </select>
                                </div>
        
                                <div class="col-md-4 form-group">
                                    <label for="tax_method">Tax Method<span class="text-danger">*</span> <i class="fas fa-info-circle" data-toggle="tooltip" data-placement="top"
                                        data-theme="dark" title="Exclusive: Poduct price = Actual product price + Tax. Inclusive: Actual product price = Product price - Tax"></i></label>
                                    <select name="tax_method" id="tax_method" class="form-control selectpicker">
                                    @foreach (TAX_METHOD as $key => $value)
                                        <option value="{{ $key }}" {{ $product->tax_method == $key ? 'selected' : '' }}>{{ $value }}</option>
                                    @endforeach
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="row">
                                <div class="form-group col-md-12 mb-0">
                                    <label for="logo" class="form-control-label">Product Image</label>
                                    <div class="col=md-12 px-0  text-center">
                                        <div id="image">
                        
                                        </div>
                                    </div>
                                    <input type="hidden" name="old_image" id="old_image" value="{{ $product->image }}">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 {{ $product->type == 1 ? 'd-none' : '' }} pt-5" id="variant-section">
                            <div class="row" style="position: relative;border: 1px solid #E4E6EF;padding: 10px 0 0 0; margin: 0;border-radius:5px;">
                                <div style="width: 100px;background: #fa8c15;text-align: center;margin: 0 auto;color: white;padding: 5px 0;
                                    position: absolute;top:-16px;left:10px;">Variant</div>
                                <div class="col-md-12">
                                    
                                    <table class="table table-borderless" id="attribute-table">
                                        <tbody>
                                            @if($product->type == 2 && !$product->attributes->isEmpty())
                                            @foreach($product->attributes as $key => $value)
                                            <tr>
                                                <td width="35%">
                                                    <input type="hidden" name="attribute[{{ $key+1 }}][product_attribute_id]" value="{{ $value->pivot->id }}">
                                                    <div class="form-group required my-0">
                                                        <label for="code">Attribute</label>
                                                        <select name="attribute[{{ $key+1 }}][id]" id="attribute_{{ $key+1 }}_id" class="form-control attribute_id selectpicker" data-id="1" data-live-search="true"  data-live-search-placeholder="Search">
                                                            <option value="">Select Please</option>
                                                            @if (!$attributes->isEmpty())
                                                                @foreach ($attributes as $attribute)
                                                                    <option value="{{ $attribute->id }}" {{ $value->id == $attribute->id ? 'selected' : '' }}>{{ $attribute->name }}</option>
                                                                @endforeach
                                                            @endif
                                                        </select>
                                                    </div>
                                                </td>
                                                <td width="65">
                                                    @php
                                                        $options = \DB::table('product_attribute_options')->where([['product_id',$product->id],['product_attribute_id',$value->pivot->id]])->get();
                                                        $option_names = [];
                                                        $option_values = '';
                                                        if(!$options->isEmpty())
                                                        {
                                                            foreach ($options as $option) {
                                                                array_push($option_names,$option->name);
                                                            }
                                                        }
                                                        if(count($option_names) > 0)
                                                        {
                                                            $option_values = implode(',',$option_names);
                                                        }
                                                    @endphp
                                                    <div class="form-group required my-0">
                                                        <label for="">Option</label>
                                                        <input type="text" value="{{ $option_values }}" name="attribute[{{ $key+1 }}][value]" id="attribute_{{ $key+1 }}_value" data-id="{{ $key+1 }}" class="form-control tagsinput tagify">
                                                    </div>
                                                </td>
                                                
                                            </tr>
                                            @endforeach
                                            @endif
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-md-12 pb-5 pt-0" style="padding-left: 20px;">
                                    <button class="btn btn-primary btn-sm" type="button" id="add_to_variation_table"> <i class="fas fa-plus-circle"></i> Generate Variants</button>
                                </div>
                            </div>
                            <div class="table-responsive mt-5" id="variant-list">
                                <table id="variant-table" class="table table-bordered table-hover variant-list"  style="width: 1500px;">
                                    <thead class="bg-primary">
                                        <th>Name</th>
                                        <th>Barcode</th>
                                        <th>Base Unit</th>
                                        <th style="width: 200px;">Unit</th>
                                        <th>MRP (Price) Base Unit</th>
                                        <th>TP (Price) Base Unit</th>
                                        <th>MRP (Price) Unit</th>
                                        <th>TP (Price) Unit</th>
                                        <th>Alert Qty</th>
                                        <th class="text-center"><i class="fas fa-trash text-white"></i></th>
                                    </thead>
                                    <tbody>
                                        @if($product->type == 2 && !$product->variants->isEmpty())
                                            @foreach ($product->variants as $key => $value)
                                            <tr>
                                                <td>
                                                    <div class="form-group mb-0">
                                                    <input type="text" class="form-control" name="variants[{{ $key+1 }}][name]" value="{{ $value->item_name }}">
                                                    <input type="hidden" class="form-control" name="variants[{{ $key+1 }}][id]" value="{{ $value->id }}">
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="form-group mb-0">
                                                        <div class="input-group" id="code_section">
                                                            <input type="text" class="form-control text-center" name="variants[{{ $key+1 }}][code]" id="variants_{{ $key+1 }}_code" value="{{ $value->item_code }}" data-row="{{ $key+1 }}">
                                                            <div class="input-group-prepend">
                                                                <span class="input-group-text bg-primary" id="generate-{{ $key+1 }}-code" onclick="generate_variants_code('{{ $key+1 }}')"  data-toggle="tooltip" data-theme="dark" title="Generate Code"
                                                                style="border-top-right-radius: 0.42rem;border-bottom-right-radius: 0.42rem;border:0;cursor: pointer;">
                                                                    <i class="fas fa-retweet text-white"></i>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="form-group mb-0">
                                                        <select name="variants[{{ $key+1 }}][item_base_unit_id]" id="variants_{{ $key+1 }}_item_base_unit_id" data-row="{{ $key+1 }}"  onchange="populate_unit(this.value,2,'{{ $key+1 }}')" class="form-control selectpicker" data-live-search="true"  data-live-search-placeholder="Search">
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
                                                <td>
                                                    <div class="form-group mb-0">
                                                        <select name="variants[{{ $key+1 }}][item_unit_id]" id="variants_{{ $key+1 }}_item_unit_id" data-row="{{ $key+1 }}"  class="form-control selectpicker" data-live-search="true"  data-live-search-placeholder="Search"></select>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="form-group mb-0">
                                                    <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_base_unit_mrp]" id="variants_{{ $key+1 }}_item_base_unit_mrp" value="{{ $value->item_base_unit_mrp }}" data-row="{{ $key+1 }}">
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="form-group mb-0">
                                                    <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_base_unit_price]" id="variants_{{ $key+1 }}_item_base_unit_price" value="{{ $value->item_base_unit_price }}" data-row="{{ $key+1 }}">
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="form-group mb-0">
                                                    <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_unit_mrp]" id="variants_{{ $key+1 }}_item_unit_mrp" value="{{ $value->item_unit_mrp }}" data-row="{{ $key+1 }}">
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="form-group mb-0">
                                                    <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][item_unit_price]" id="variants_{{ $key+1 }}_item_unit_price" value="{{ $value->item_unit_price }}" data-row="{{ $key+1 }}">
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="form-group mb-0">
                                                    <input type="text" class="form-control text-right" name="variants[{{ $key+1 }}][alert_qty]" id="variants_{{ $key+1 }}_alert_qty" value="{{ $value->alert_qty }}" data-row="{{ $key+1 }}">
                                                    </div>
                                                </td>
                                                <td class="text-center">
                                                    {{-- @php
                                                        $total_child_data = 0;
                                                        $total_child_data += $value->sales()->count();
                                                        $total_child_data += $value->purchases()->count();
                                                        $total_child_data += $value->adjustments()->count();
                                                        $total_child_data += $value->quotations()->count();
                                                    @endphp
                                                    @if ($total_child_data > 0)
                                                    <button type="button" class="btn btn-danger btn-sm" data-toggle="tooltip" data-theme="dark" title="Cannott remove. This variant associated with many datas" disabled> <i class="fas fa-minus-square"></i> </button>
                                                    @else --}}
                                                    <button type="button" class="btn btn-danger btn-sm remove-variant"> <i class="fas fa-minus-square"></i> </button>
                                                    {{-- @endif --}}
                                                    
                                                </td>
                                            @endforeach
                                        @endif
                                    </tbody>
                                </table>
                                <div id="table-loading" class="d-none" style="margin: 0 auto;width:120px;">
                                    <img src="images/loading.svg" style="width: 100px;" alt="loading..."  />
                                </div>
                            </div>
                        </div>

                        <div class="form-group col-md-12 mt-5">
                            <label for="description">Description</label>
                            <textarea class="form-control" name="description" id="description">{{ $product->description }}</textarea>
                        </div>

                        <div class="col-md-12 pt-5" id="material-section">
                            <div class="row" style="position: relative;border: 1px solid #E4E6EF;padding: 10px 0 0 0; margin: 0;border-radius:5px;">
                                <div style="width: 100px;background: #fa8c15;text-align: center;margin: 0 auto;color: white;padding: 5px 0;
                                    position: absolute;top:-16px;left:10px;">Materials</div>

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
                                @else 
                                <div class="col-md-12 pt-5 material_section">
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
                                            <button type="button" id="add-material" class="btn btn-success btn-sm" data-toggle="tooltip" 
                                                data-placement="top" data-original-title="Add More">
                                                <i class="fas fa-plus-square"></i>
                                                </button>
                                        </div>
                                    </div>
                                </div>
                                @endif    
                            </div>
                        </div>
                        
                        <div class="form-group col-md-12 pt-5">
                            <button type="button" class="btn btn-primary btn-sm" id="update-btn">Update</button>
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
<script src="js/jQuery.tagify.min.js"></script>
<script src="js/spartan-multi-image-picker.min.js"></script>
<script>
$(document).ready(function () {
    //tagify plugin initialization
    @if($product->type == 2 && !$product->attributes->isEmpty())
    @foreach($product->attributes as $key => $value)
    $('#attribute_'+"{{ $key+1 }}"+'_value').tagify({
            transformTag: function (e) {
                e.class = "tagify__tag tagify__tag--primary"
            },
        });
    @endforeach
    @else
    $('#attribute_1_value').tagify({
            transformTag: function (e) {
                e.class = "tagify__tag tagify__tag--primary"
            },
        });
    @endif
    /** Start :: Product Image **/
    $("#image").spartanMultiImagePicker({
        fieldName:        'image',
        maxCount: 1,
        rowHeight:        '150px',
        groupClassName:   'col-md-12 col-sm-12 col-xs-12',
        maxFileSize:      '',
        dropFileLabel : "Drop Here",
        allowedExt: '',
        // onExtensionErr : function(index, file){
        //     Swal.fire({icon: 'error',title: 'Oops...',text: 'Only png,jpg,jpeg file format allowed!'});
        // },

    });

    $("input[name='image']").prop('required',true);

    $('.remove-files').on('click', function(){
        $(this).parents(".col-md-12").remove();
    });

    @if(!empty($product->image))
    $('#image img').css('display','none');
    $('#image .spartan_remove_row').css('display','block');
    $('#image .img_').css('display','block');
    $('#image .img_').attr('src',"{{ asset('storage/'.PRODUCT_IMAGE_PATH.$product->image)}}");
    @else   
    $('#image img').css('display','block');
    $('#image .spartan_remove_row').css('display','none');
    $('#image .img_').css('display','none');
    $('#image .img_').attr('src','');
    @endif
    /** End :: Product Image **/

    /** Start :: Generate Product Variant Combination **/
    $(document).on('click','#add_to_variation_table',function(e){
        e.preventDefault();
        var TagArray = [];
        var rowCount = $('#attribute-table tr').length;

        for(i=1;i<=rowCount;i++){
            var localArray = [];
            var row = $('#attribute_'+i+'_value').data('id');
            var TagValues = JSON.parse($('#attribute_'+i+'_value').tagify().val());
            for(let j=0;j<TagValues.length;j++){
                localArray.push(TagValues[j].value);
            }
            TagArray.push(localArray);
        }
        
        $.ajax({
            url:"{{ url('generate-product-variant') }}",
            type:"POST",
            data:{data:TagArray,product_id:$('#update_id').val(),_token:_token},
            beforeSend: function(){
                $('#variant-list #table-loading').removeClass('d-none');
            },
            complete: function(){
                $('#variant-list #table-loading').addClass('d-none');
            },
            success:function(data){
                $('#variant-table tbody .variant-row').remove();
                $('#variant-table tbody').append(data);
                $('.selectpicker').selectpicker('refresh');
            },
        });
    });
    $(document).on('click','.remove-variant',function(){
        $(this).closest('tr').remove();
    });
    /** End :: Generate Product Variant Combination **/

    /** Start :: Add More Attribute Field **/
    @if($product->type == 2 && !$product->attributes->isEmpty())
    var attribute_count = "{{ count($product->attributes) }}";
    @else
    var attribute_count = 1;
    @endif
    function add_more_attribute_field(row){
        html = ` <tr>
                    <td>
                        <div class="form-group">
                            <select name="attribute[`+row+`][id]" id="attribute_`+row+`_id" class="form-control attribute_id selectpicker" data-id="`+row+`" data-live-search="true"  data-live-search-placeholder="Search">
                                <option value="">Select Please</option>
                                @if (!$attributes->isEmpty())
                                    @foreach ($attributes as $attribute)
                                        <option value="{{ $attribute->id }}">{{ $attribute->name }}</option>
                                    @endforeach
                                @endif
                            </select>
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <input type="text" name="attribute[`+row+`][value]" id="attribute_`+row+`_value" data-id="`+row+`" class="form-control tagsinput tagify">
                        </div>
                    </td>
                    <td class="text-center">
                        <div class="form-group">
                            <button type="button" class="btn btn-danger btn-sm remove_attribute" data-toggle="tooltip" 
                            data-placement="top" data-original-title="Remove">
                            <i class="fas fa-minus-square"></i>
                        </button>
                        </div>
                    </td>
                </tr> `;
        $('#attribute-table tbody').append(html);
        $('.selectpicker').selectpicker('refresh');
        $('#attribute_'+row+'_value').tagify({
            transformTag: function (e) {
                e.class = "tagify__tag tagify__tag--primary"
            },
        });
    }

    $(document).on('click','#add_more_attribute',function(){
        attribute_count++;
        add_more_attribute_field(attribute_count);
    });
    $(document).on('click','.remove_attribute',function(){
        attribute_count--;
        $(this).closest('.row_remove').remove();
    });
    /** End :: Add More Attribute Field **/

    
    //Generate Code
    $(document).on('click','#generate-code',function(){
        $.ajax({
            url: "{{ route('product.generate.code') }}",
            type: "GET",
            dataType: "JSON",
            beforeSend: function(){
                $('#generate-code').addClass('spinner spinner-white spinner-right');
            },
            complete: function(){
                $('#generate-code').removeClass('spinner spinner-white spinner-right');
            },
            success: function (data) {
                data ? $('#store_or_update_form #code').val(data) : $('#store_or_update_form #code').val('');
            },
            error: function (xhr, ajaxOption, thrownError) {
                console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
            }
        });
    });


    $(document).on('click','#promotion',function() {
       if($(this).is(':checked')){
            $(this).val(1);
            $('.promotion-section').removeClass('d-none');
       }else{
            $(this).val(2);
            $('.promotion-section').addClass('d-none');
       }
    });
    

    /****************************/
    $(document).on('click','#update-btn',function(){
        let form = document.getElementById('store_or_update_form');
        let formData = new FormData(form);

        $.ajax({
            url: "{{route('product.update')}}",
            type: "POST",
            data: formData,
            dataType: "JSON",
            contentType: false,
            processData: false,
            cache: false,
            beforeSend: function(){
                $('#update-btn').addClass('spinner spinner-white spinner-right');
            },
            complete: function(){
                $('#update-btn').removeClass('spinner spinner-white spinner-right');
            },
            success: function (data) {
                $('#store_or_update_form').find('.is-invalid').removeClass('is-invalid');
                $('#store_or_update_form').find('.error').remove();
                if (data.status == false) {
                    $.each(data.errors, function (key, value){
                        var key = key.split('.').join('_');
                        $('#store_or_update_form input#' + key).addClass('is-invalid');
                        $('#store_or_update_form textarea#' + key).addClass('is-invalid');
                        $('#store_or_update_form select#' + key).parent().addClass('is-invalid');
                        // if(key == 'code' || key == 'start_date' || key == 'end_date'){
                            $('#store_or_update_form #' + key).parents('.form-group').append(
                            '<small class="error text-danger">' + value + '</small>');
                        // }else{
                        //     $('#store_or_update_form #' + key).parent().append(
                        //     '<small class="error text-danger">' + value + '</small>');
                        // }
                    });
                } else {
                    notification(data.status, data.message);
                    if (data.status == 'success') {
                            window.location.replace("{{ route('product') }}");

                    }
                }
            },
            error: function (xhr, ajaxOption, thrownError) {
                console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
            }
        });
        });
});

function populate_unit(unit_id)
{
    $.ajax({
        url:"{{ url('populate-unit') }}/"+unit_id,
        type:"GET",
        dataType:"JSON",
        success:function(data){
            $('#purchase_unit_id,#sale_unit_id').empty();
            $.each(data, function(key, value) {
                $('#purchase_unit_id,#sale_unit_id').append('<option value="'+ key +'">'+ value +'</option>');
            });
            $('#purchase_unit_id.selectpicker,#sale_unit_id.selectpicker').selectpicker('refresh');
        },
    });
}

function generate_variants_code(row){
    $.ajax({
            url: "{{ route('product.variant.generate.code') }}",
            type: "GET",
            dataType: "JSON",
            beforeSend: function(){
                $('#generate-'+row+'-code').addClass('spinner spinner-white spinner-right');
            },
            complete: function(){
                $('#generate-'+row+'-code').removeClass('spinner spinner-white spinner-right');
            },
            success: function (data) {
                data ? $('#variants_'+row+'_code').val(data) : $('#variants_'+row+'_code').val('');
            },
            error: function (xhr, ajaxOption, thrownError) {
                console.log(thrownError + '\r\n' + xhr.statusText + '\r\n' + xhr.responseText);
            }
        });
}
</script>
@endpush