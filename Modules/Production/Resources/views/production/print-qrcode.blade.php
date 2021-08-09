<div class="col-md-12 col-lg-12">
<div id="printableArea">
    <style>
        @media print {

body,
html {
    background: #fff !important;
    -webkit-print-color-adjust: exact !important;
    font-family: sans-serif;
    /* font-size: 12px !important; */
    margin: 0 !important;
    padding: 0 !important;
}
svg{
    margin-top:10px; 
}

.m-0 {
    margin: 0 !important;
}

h1,
h2,
h3,
h4,
h5,
h6 {
    margin: 0 !important;
}

.no_screen {
    display: block !important;
}

.no_print {
    display: none;
}

a {
    content: none !important;
    text-decoration: none !important;
    color: #036 !important;
}

.text-center {
    text-align: center !important;
}

.text-left {
    text-align: left !important;
}

.text-right {
    text-align: right !important;
}

.float-left {
    float: left !important;
}

.float-right {
    float: right !important;
}

.text-bold {
    font-weight: bold !important;
}

.invoice {
    /* font-size: 11px!important; */
    overflow: hidden !important;
    background: #fff !important;
    margin-bottom: 100px !important;
}

.invoice footer {
    position: absolute;
    bottom: 0;
    left: 0;
    /* page-break-after: always */
}

/* .invoice>div:last-child {
    page-break-before: always
} */
.hidden-print {
    display: none !important;
}
.dashed-border{
    width:180px;height:2px;margin:0 auto;padding:0;border-top:1px dashed #454d55 !important;
}
table{
    width: 100%;
}
table td{
    width: 100%;
    margin: 0 !important;
    padding: 0 !important;
}
}

@page {
/* size: auto; */
margin: 0.5mm;

}
    </style>
    @if (!empty($coupons))
    <table>

            <?php
            $counter = 0;
            foreach ($coupons as $coupon) {
                ?>
                <?php if ($counter == $row_qty) { ?>
                    <tr> 
                        <?php $counter = 0; ?>
                    <?php } ?>
                    <td style="text-align:center;width:38mm;height:24mm;margin:0 10px 0 0;padding:0;vertical-align: middle;">     
                        {{-- <div style="text-align:center;padding-top:10px;"> --}}
                            {!! QrCode::size(70)->generate("ID:$coupon->id;CODE:$coupon->coupon_code"); !!}
                            <div style="background-color:black;color:white;text-align:center;width:100px;margin:5px auto;font-size:14px;padding: 5px 0;">{{ number_format($coupon->coupon_price,2,'.','') }}Tk</div>
                        {{-- </div> --}}
                    </td>
                    <?php if ($counter == 7) { ?>
                    </tr> 
                    <?php $counter = 0; ?>
                <?php } ?>
                <?php $counter++; ?>
                <?php
            }
        ?>
    </table>
    @endif
</div>
</div>