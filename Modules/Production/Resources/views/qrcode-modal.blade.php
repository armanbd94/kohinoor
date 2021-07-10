<div class="modal fade" id="qrcode_modal" tabindex="-1" role="dialog" aria-labelledby="model-1" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">

      <!-- Modal Content -->
      <div class="modal-content">

        <!-- Modal Header -->
        <div class="modal-header bg-primary">
          <h3 class="modal-title text-white" id="model-1"></h3>
          <button type="button" class="btn btn-warning btn-sm float-right" id="print-qrcode" style="position: absolute;
          right: 65px;"> <i class="fas fa-print"></i> Print</button>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <i aria-hidden="true" class="ki ki-close text-white"></i>
          </button>
        </div>
        <!-- /modal header -->
        <!-- Modal Body -->
        <div class="modal-body">
            <div class="col-md-12 col-lg-12">
                <form id="qrcode_form" method="POST">
                    <div class="row">
                        <input type="hidden" name="production_finished_good_id" id="production_finished_good_id">
                        <input type="hidden" name="production_id" id="production_id">
                        <input type="hidden" name="batch_no" id="batch_no">
                        <x-form.textbox labelName="QR Code Qunatity Each Row " name="row_qty" required="required" col="col-md-4" class="text-center" value="1" placeholder="Enter barcode print quantity"/>
                        <div class="form-group col-md-4" style="padding-top:28px;">
                            <button type="button" class="btn btn-primary btn-sm" onclick="load_qrcode_view()"><i class="fas fa-qrcode"></i>Generate QR Code</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="col-md-12">
                <div class="row" id="qrcode-section">

                </div>
            </div>
        </div>
        <!-- /modal body -->
      </div>
      <!-- /modal content -->

    </div>
  </div>
