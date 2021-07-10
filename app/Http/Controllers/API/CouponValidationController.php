<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\Production\Entities\ProductionCoupon;
use Modules\Production\Entities\ProductionFinishedGoods;

class CouponValidationController extends Controller
{
    public function index(Request $request)
    {
        // $text = 'ID:4;CODE:VZHNT437X7';
        $data    = [];
        $message = "";
        $status  = true;
        $qrcode_text = $request->qrcode;
        if($qrcode_text){
            $id = explode(':',explode(';',$qrcode_text)[0])[1];
            $code     = explode(':',explode(';',$qrcode_text)[1])[1];
            $production_coupon = ProductionCoupon::with('production','production_finished_good')->where(['id'=>$id,'coupon_code'=>$code])->first();
            if($production_coupon)
            {
                if($production_coupon->status == 2)
                {
                    if($production_coupon->production_finished_good->coupon_exp_date)
                    {
                        if($production_coupon->production_finished_good->coupon_exp_date < date('Y-m-d'))
                        {
                            $status  = false;
                            $message = "This Coupon Code Has Expired";
                        }
                    }else{
                        $status  = true;
                        $finished_goods = FinishGood::with('product','size')->find($production_coupon->production_finished_good->finish_goods_id);
                        $data = [
                            'product_name'    => $finished_goods->product->product_name.' '.$finished_goods->size->size.$finished_goods->size->unit->unit_code,
                            'product_image'   => asset('storage/'.PRODUCT_IMAGE_PATH.$finished_goods->product->product_image),
                            'batch_no'        => $production_coupon->batch_no,
                            'coupon_id'       => $id,
                            'coupon_code'     => $code,
                            'coupon_amount'   => number_format($production_coupon->production_finished_good->coupon_price,2),
                            'coupon_exp_date' => $production_coupon->production_finished_good->coupon_exp_date ? date('d-M-Y',strtotime($production_coupon->production_finished_good->coupon_exp_date)) : 'No Exp Date'
                        ];
                        $message = "This Coupon Code is Valid";
                    }
                }else{
                    $status  = false;
                    $message = "This Coupon Code is Already Used!";
                }
            }else{
                $status  = false;
                $message = "This Coupon Code is Invalid!";
            }
        }else{
            $status  = false;
            $message = "Invalid QR Code!";
        }
        return $this->sendResult($message,$data,$status);
    }

    protected function sendResult($message,$data,$status = true)
    {
        $result = [
            "status" => $status,
            "data" => $data,
            "message" => $message,
        ];
        return response()->json($result);
    }
}
