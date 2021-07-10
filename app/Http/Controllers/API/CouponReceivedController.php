<?php

namespace App\Http\Controllers\API;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\Production\Entities\ProductionCoupon;
use Modules\SalesMen\Entities\ReceivedCoupon;

class CouponReceivedController extends Controller
{
    public function store_received_coupon(Request $request)
    {
        $errors  = [];
        $data    = [];
        $message = "";
        $status  = true;

        $validator = Validator::make($request->all(), [
            'coupon_id'   => 'required|integer',
            'coupon_code' => 'required|string|min:10|max:10',
            'customer_id' => 'required|integer'
        ]);

        if ($validator->fails()) {
            $status  = false;
            $errors  = $validator->errors();
            $message = "Validation Errors";
            return $this->sendResult($message,$data,$errors,$status);
        }else{
            DB::beginTransaction();
            try {
                $coupon = ProductionCoupon::with('production_finished_good')->where(['id' => $request->coupon_id,'status' => 2])->first();
                if($coupon){
                    $received = ReceivedCoupon::create([
                        'asm_id'       => auth()->user()->asm_id,
                        'salesmen_id'  => auth()->user()->id,
                        'customer_id'  => $request->customer_id,
                        'coupon_id'    => $request->coupon_id,
                        'coupon_price' => $coupon->production_finished_good->coupon_price
                    ]);
                    $status_changed = $coupon->update(['status' => 1]);
                    if($received && $status_changed)
                    {
                        $status  = true;
                        $message = "Coupon Data Stored Successfully";
                    }else{
                        $status  = false;
                        $message = "Failed To Store Coupon Data";
                    }
                }else{
                    $status  = false;
                    $message = "Invalid Coupon";
                }
                DB::commit();
            } catch (Exception $e) {
                DB::rollBack();
                $status = false;
                $message = $e->getMessage();
            }
            return $this->sendResult($message,$data,$errors,$status);
        }
    }

    protected function sendResult($message,$data = [],$errors = [],$status = true)
    {
        $result = [
            "status"  => $status,
            "data"    => $data,
            "message" => $message,
            "errors"  => $errors
        ];
        return response()->json($result);
    }
}
