<?php

namespace Modules\ASM\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Modules\ASM\Entities\Sale;
use Illuminate\Routing\Controller;
use Modules\ASM\Entities\Customer;
use Modules\ASM\Entities\SalesPerson;
use Modules\ASM\Entities\ReceivedCoupon;
use Illuminate\Contracts\Support\Renderable;
use Illuminate\Support\Facades\Auth;

class DashboardController extends Controller
{
    protected function setPageData(string $page_title, string $sub_title=null, string $page_icon=null, $breadcrumb=null)
    {
        view()->share(['page_title' => $page_title, 'sub_title' => $sub_title ?? $page_title, 'page_icon' => $page_icon, 'breadcrumb' => $breadcrumb]);
    }
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index()
    {
        $this->setPageData('Dashboard','Dashboard','fas fa-technometer');
        return view('asm::dashboard');
    }

    public function dashboard_data(Request $request)
    {
        if ($request->ajax()) {
            $customer = Customer::toBase()->where([['status',1],['district_id',Auth::guard('asm')->user()->district_id]]);
            $salesmen = SalesPerson::toBase()->where([['status',1],['asm_id',Auth::guard('asm')->user()->id]]);
            $sale = Sale::toBase()->where('asm_id',Auth::guard('asm')->user()->id);
            $coupon = ReceivedCoupon::toBase()->where('asm_id',Auth::guard('asm')->user()->id);

            if($request->value == 1){
                $customer = $customer->whereDate('created_at',Carbon::today());
                $salesmen = $salesmen->whereDate('created_at',Carbon::today());
                $sale     = $sale->whereDate('sale_date',Carbon::today());
                $coupon = $coupon->whereDate('created_at',Carbon::today());
            }elseif ($request->value == 2) {
                $customer = $customer->whereBetween('created_at', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()]);;
                $salesmen = $salesmen->whereBetween('created_at', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()]);;
                $sale     = $sale->whereBetween('sale_date', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()]);;
                $coupon = $coupon->whereBetween('created_at', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()]);;
            }elseif ($request->value == 3) {
                $customer = $customer->whereMonth('created_at',Carbon::now()->month);
                $salesmen = $salesmen->whereMonth('created_at',Carbon::now()->month);
                $sale     = $sale->whereMonth('sale_date',Carbon::now()->month);
                $coupon = $coupon->whereMonth('created_at',Carbon::now()->month);
            }elseif ($request->value == 4) {
                $customer = $customer->whereYear('created_at',Carbon::now()->year);
                $salesmen = $salesmen->whereYear('created_at',Carbon::now()->year);
                $sale     = $sale->whereYear('sale_date',Carbon::now()->year);
                $coupon = $coupon->whereYear('created_at',Carbon::now()->year);
            }else{
                $customer = $customer->get();
                $salesmen = $salesmen->get();
                $sale     = $sale->get();
                $coupon = $coupon->get();
            }

            $data = [
                'total_customer' => $customer->count(),
                'total_salesmen' => $salesmen->count(),
                'total_sale' => $sale->sum('grand_total'),
                'total_coupon' => $coupon->sum('coupon_price'),
            ];
            return response()->json($data);
        }
    }

}
