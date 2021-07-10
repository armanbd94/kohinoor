<div class="modal fade" id="material_return_modal" tabindex="-1" role="dialog" aria-labelledby="model-1" aria-hidden="true">
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
        <form id="material_return_form" method="POST">
            @csrf
            <div class="modal-body">
                <input type="hidden" name="production_id" value="{{ $production->id }}">
                <div class="row">
                    <div class="col-md-12">
                        <table class="table table-bordered"id="material-return-list">
                            <thead class="bg-primary">
                                <th width="25%">Material</th>
                                <th width="10%" class="text-center">Unit</th>
                                <th width="15%" class="text-center">Current Stock</th>
                                <th width="15%" class="text-center">Received Qty</th>
                                <th width="10%" class="text-center">Used Qty</th>
                                <th width="15%" class="text-center">Damage Qty</th>
                                <th width="10%" class="text-center">Odd Qty</th>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary btn-sm" id="return-btn"></button>
            </div>
        </form>
        <!-- /modal body -->
      </div>
      <!-- /modal content -->

    </div>
  </div>