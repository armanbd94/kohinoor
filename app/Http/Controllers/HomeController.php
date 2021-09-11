<?php

namespace App\Http\Controllers;


use Illuminate\Support\Facades\DB;
use App\Http\Controllers\BaseController;


class HomeController extends BaseController
{
    public function index()
    {

        if (permission('dashboard-access')){

            $this->setPageData('Dashboard','Dashboard','fas fa-technometer');
            $start_date = date('Y-m-d');
            $end_date   = date('Y-m-d');
            $sale = DB::table('sales')
                    ->whereDate('sale_date','>=',$start_date)
                    ->whereDate('sale_date','<=',$end_date)
                    ->sum('grand_total');
            $purchase = DB::table('purchases')->whereDate('purchase_date','>=',$start_date)
                        ->whereDate('purchase_date','<=',$end_date)
                        ->sum('grand_total');
            $income = DB::table('sales')
                        ->whereDate('sale_date','>=',$start_date)
                        ->whereDate('sale_date','<=',$end_date)
                        ->sum('paid_amount');
            $expense = DB::table('expenses')
            ->whereDate('date','>=',$start_date)
            ->whereDate('date','<=',$end_date)
            ->sum('amount');


             //Yearly Report
             $start = strtotime(date('Y').'-01-01');
             $end = strtotime(date('Y').'-12-31');
 
             $yearly_sale_amount = [];
             $yearly_purchase_amount = [];
             while ($start < $end) {
                 $start_date  = date('Y').'-'.date('m',$start).'-01';
                 $end_date  = date('Y').'-'.date('m',$start).'-31';
 
                 $sale_amount = DB::table('sales')->whereDate('created_at','>=',$start_date)
                 ->whereDate('created_at','<=',$end_date)->sum('grand_total');
 
                 $purchase_amount = DB::table('purchases')->whereDate('created_at','>=',$start_date)
                 ->whereDate('created_at','<=',$end_date)->sum('grand_total');
 
                 $yearly_sale_amount[] = number_format($sale_amount,2,'.','');
                 $yearly_purchase_amount[] = number_format($purchase_amount,2,'.','');
                 $start = strtotime('+1 month',$start);
             }
            return view('home',compact('sale','purchase','income',
            'expense','yearly_sale_amount','yearly_purchase_amount'));
        }else{
            return redirect('unauthorized')->with(['status'=>'error','message'=>'Unauthorized Access Blocked']);
        }
    }

    public function dashboard_data($start_date,$end_date)
    {
        if($start_date && $end_date)
        {
            $sale = DB::table('sales')
                    ->whereDate('sale_date','>=',$start_date)
                    ->whereDate('sale_date','<=',$end_date)
                    ->sum('grand_total');
            $purchase = DB::table('purchases')->whereDate('purchase_date','>=',$start_date)
                        ->whereDate('purchase_date','<=',$end_date)
                        ->sum('grand_total');
            $income = DB::table('sales')
                        ->whereDate('sale_date','>=',$start_date)
                        ->whereDate('sale_date','<=',$end_date)
                        ->sum('paid_amount');
            $expense = DB::table('expenses')
            ->whereDate('date','>=',$start_date)
            ->whereDate('date','<=',$end_date)
            ->sum('amount');
            $data = [
                'sale'     => $sale,
                'purchase' => $purchase,
                'income'   => $income,
                'expense'  => $expense,

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
