<div class="modal fade" id="store_or_update_modal" tabindex="-1" role="dialog" aria-labelledby="model-1" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">

      <!-- Modal Content -->
      <div class="modal-content">

        <!-- Modal Header -->
        <div class="modal-header bg-primary">
          <h3 class="modal-title text-white" id="model-1"></h3>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <i aria-hidden="true" class="ki ki-close text-white"></i>
          </button>
        </div>
        <!-- /modal header -->
        <form id="store_or_update_form" method="post">
          @csrf
            <!-- Modal Body -->
            <div class="modal-body">
                <div class="row">
                    <input type="hidden" name="update_id" id="update_id"/>

                    <x-form.selectbox labelName="Product" name="product_id" required="required" col="col-md-6" class="selectpicker">
                        @if (!$products->isEmpty())
                            @foreach ($products as $product)
                                <option value="{{ $product->id }}">{{ $product->product_name }}</option>
                            @endforeach
                        @endif
                    </x-form.selectbox>
                    <x-form.selectbox labelName="Size" name="size_id" required="required" col="col-md-6" class="selectpicker">
                        @if (!$sizes->isEmpty())
                            @foreach ($sizes as $size)
                                <option value="{{ $size->id }}">{{ $size->size.$size->unit->unit_code }}</option>
                            @endforeach
                        @endif
                    </x-form.selectbox>
                    <div class="col-md-6 form-group required">
                        <label for="code">Barcode</label>
                        <input type="text" class="form-control" name="code" id="code">
                    </div>
                    <x-form.textbox labelName="Cost" name="cost" col="col-md-6" placeholder="0.00"/>
                    <x-form.textbox labelName="Sale Price" name="price" required="required" col="col-md-6" placeholder="0.00"/>

                    
                    <x-form.selectbox labelName="Unit" name="unit_id" required="required"  col="col-md-6" onchange="populate_unit(this.value)" class="selectpicker">
                        @if (!$units->isEmpty())
                        @foreach ($units as $unit)
                            @if ($unit->base_unit == null)
                            <option value="{{ $unit->id }}">{{ $unit->unit_name.' ('.$unit->unit_code.')' }}</option>
                            @endif
                        @endforeach
                    @endif
                    </x-form.selectbox>

                    <x-form.selectbox labelName="Sale Unit" name="sale_unit_id" required="required" col="col-md-6"
                                class="selectpicker"/>

                    
                    <x-form.textbox labelName="Stock Quantity" name="qty" col="col-md-6" placeholder="0"/>
                    <x-form.textbox labelName="Stock Alert Quantity" name="alert_qty" col="col-md-6" placeholder="0"/>
                    
                </div>
            </div>
            <!-- /modal body -->

            <!-- Modal Footer -->
            <div class="modal-footer">
            <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary btn-sm" id="save-btn"></button>
            </div>
            <!-- /modal footer -->
        </form>
      </div>
      <!-- /modal content -->

    </div>
  </div>
