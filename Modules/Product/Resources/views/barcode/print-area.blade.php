<div class="col-md-12 col-lg-12"  style="width: 100%;">
    <div class="row">
        <div class="col-md-12">
            <button type="button" class="btn btn-primary btn-sm float-right mb-5" id="print-barcode"> <i class="fas fa-print"></i> Print</button>
        </div>
        <div class="col-md-12" id="printableArea" style="width: 100%;margin:0;padding:0;">
            <link href="{{asset('css/print.css')}}" rel="stylesheet" type="text/css" />
            @if (!empty($barcode))
            <table style="width: 100%;">
                <tbody>
                <?php
                $counter = 0;
                for ($i = 0; $i < $barcode_qty; $i++) {
                    ?>
                    <?php if ($counter == $row_qty) { ?>
                        <tr> 
                            <?php $counter = 0; ?>
                        <?php } ?>
                        <td>     
                            <div style="text-align: center;width: 40mm;height:30mm; font-size:12px;margin-left:25px;">
                                <div style="padding-top: 20px;font-weight:bold;">
                                    <b>{{ config('settings.title') }}</b>
                                </div>
                                @if(!empty($product_name))<div style="padding-bottom:5px;"><p style="margin:0;">{{ $product_name }}</p></div>@endif
                                <div style="text-align: center;width:100%">
                                    <img src="{{ 'data:image/png;base64,' . DNS1D::getBarcodePNG($barcode, 'EAN13') }}" alt="barcode" style="width: 100%;"  />
                                </div>
                                <div style="letter-spacing: 4.2px;">{{ $barcode }}</div>
                                
                                @if(!empty($product_price))<div class="price barcode-price"><b>M.R.P. :</b> {{ (config('settings.currency_position') == 1) ? config('settings.currency_symbol').' '.$product_price : $product_price.config('settings.currency_symbol') }}</div>@endif
                            </div>
                        </td>
                        <?php if ($counter == 5) { ?>
                        </tr> 
                        <?php $counter = 0; ?>
                    <?php } ?>
                    <?php $counter++; ?>
                    <?php
                }
                ?>
                </tbody>
            </table>
            @endif
        </div>
    </div>
</div>