<div class="modal fade" id="material_modal" tabindex="-1" role="dialog" aria-labelledby="model-1" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">

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
        <!-- Modal Body -->
        <form id="material_form" method="POST">
            @csrf
            <div class="modal-body">
                <input type="hidden" name="production_id" value="{{ $production->id }}">
                <div class="row">
                    <div class="form-group col-md-6 required">
                        <label for="">Materal Delivary Status</label>
                        <select class="form-control" name="material_delivered_status" id="material_delivered_status" required>
                            <option value="2" selected>Full Deleivered</option>
                            <option value="3">Partially Delivered</option>
                        </select>
                    </div>
                    <div class="col-md-12">
                        <table class="table table-bordered"id="material-delivery-list">
                            <thead class="bg-primary">
                                <th>Material</th>
                                <th class="text-center">Unit</th>
                                <th class="text-center">Current Stock</th>
                                <th class="text-center">Ordered Qty</th>
                                <th class="text-center">Delivery Qty</th>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-sm" id="save-btn"></button>
            </div>
        </form>
        <!-- /modal body -->
      </div>
      <!-- /modal content -->

    </div>
  </div>