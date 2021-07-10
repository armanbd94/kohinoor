<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Modules\Sale\Entities\Sale;
use Modules\Customer\Entities\Customer;
use Modules\Purchase\Entities\Purchase;
use Modules\Supplier\Entities\Supplier;

class HomeController extends Controller
{

    protected function setPageData(string $page_title, string $sub_title=null, string $page_icon=null, $breadcrumb=null)
    {
        view()->share(['page_title' => $page_title, 'sub_title' => $sub_title ?? $page_title, 'page_icon' => $page_icon, 'breadcrumb' => $breadcrumb]);
    }

    public function index()
    {
        if (permission('dashboard-access')){
            $this->setPageData('Dashboard','Dashboard','fas fa-technometer');
            // $menus = Session::get('user_menu');
            // dd($menus[0]->children[10]->children);
            return view('home');
        }else{
            return redirect('unauthorized')->with(['status'=>'error','message'=>'Unauthorized Access Blocked']);
        }
    }

    public function dashboard_data(Request $request)
    {
        if ($request->ajax()) {
            $customer = Customer::toBase()->where('status',1);
            $supplier = Supplier::toBase()->where('status',1);
            $sale = Sale::toBase();
            $purchase = Purchase::toBase();

            if($request->value == 1){
                $customer = $customer->whereDate('created_at',Carbon::today());
                $supplier = $supplier->whereDate('created_at',Carbon::today());
                $sale     = $sale->whereDate('sale_date',Carbon::today());
                $purchase = $purchase->whereDate('purchase_date',Carbon::today());
            }elseif ($request->value == 2) {
                $customer = $customer->whereBetween('created_at', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()]);;
                $supplier = $supplier->whereBetween('created_at', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()]);;
                $sale     = $sale->whereBetween('sale_date', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()]);;
                $purchase = $purchase->whereBetween('purchase_date', [Carbon::now()->startOfWeek(), Carbon::now()->endOfWeek()]);;
            }elseif ($request->value == 3) {
                $customer = $customer->whereMonth('created_at',Carbon::now()->month);
                $supplier = $supplier->whereMonth('created_at',Carbon::now()->month);
                $sale     = $sale->whereMonth('sale_date',Carbon::now()->month);
                $purchase = $purchase->whereMonth('purchase_date',Carbon::now()->month);
            }elseif ($request->value == 4) {
                $customer = $customer->whereYear('created_at',Carbon::now()->year);
                $supplier = $supplier->whereYear('created_at',Carbon::now()->year);
                $sale     = $sale->whereYear('sale_date',Carbon::now()->year);
                $purchase = $purchase->whereYear('purchase_date',Carbon::now()->year);
            }else{
                $customer = $customer->get();
                $supplier = $supplier->get();
                $sale     = $sale->get();
                $purchase = $purchase->get();
            }

            $data = [
                'total_customer' => $customer->count(),
                'total_supplier' => $supplier->count(),
                'total_sale' => $sale->sum('grand_total'),
                'total_purchase' => $purchase->sum('grand_total'),
            ];
            return response()->json($data);
        }
    }

    public function unauthorized()
    {
        $this->setPageData('Unauthorized','Unauthorized','fas fa-ban',[['name' => 'Unauthorized']]);
        return view('unauthorized');
    }


}
