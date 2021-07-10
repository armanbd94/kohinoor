<?php

namespace App\Http\Controllers\API;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Modules\SalesMen\Entities\SalesMenDailyRoute;

class SalesmenController extends Controller
{
    public function daily_route_list(int $salesmen_id)
    {
        $data    = [];
        $message = "";
        $status  = true;
        try {
            if(auth()->user()->id == $salesmen_id){
                $routes = SalesMenDailyRoute::with('route')->where('salesmen_id',$salesmen_id)->get();
                if($routes){
                    foreach ($routes as $value) {
                        $data[] = [
                            'id' => $value->id,
                            'route_name' => DAYS[$value->day].' - '.$value->route->name
                        ];
                    }
                    $message = "Data found Successfully";
                }
            }else{
                $status = false;
                $message = 'Invalid User';
            }
            
            // $data =   $daily_routes;
        } catch (Exception $e) {
            $status  = false;
            $message = $e->getMessage();
        }
        
        return $this->sendResult($message,$data,$status);
    }

    public function route_customer_list(int $daily_route_id)
    {
        $data    = [];
        $message = "";
        $status  = true;
        try {
            $route = DB::table('sales_men_daily_routes')->where(['id' => $daily_route_id, 'salesmen_id' => auth()->user()->id])->first();
            if($route)
            {
                $customers = DB::table('customers')->where(['route_id'=>$route->route_id,'status'=>1])->get();
                if($customers){
                    foreach ($customers as $value) {
                        $data[] = [
                            'id' => $value->id,
                            'name' => $value->shop_name.' - '.$value->name
                        ];
                    }
                    $message = "Data found Successfully";
                }else{
                    $status  = false;
                    $message = "No Records Found";
                }
            }else{
                $status  = false;
                $message = "No Records Found";
            }
            
        } catch (Exception $e) {
            $status  = false;
            $message = $e->getMessage();
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
