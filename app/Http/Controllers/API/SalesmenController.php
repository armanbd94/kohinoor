<?php

namespace App\Http\Controllers\API;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\API\APIController;
use Modules\SalesMen\Entities\SalesMenDailyRoute;

class SalesmenController extends APIController
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
        } catch (Exception $e) {
            $status  = false;
            $message = $e->getMessage();
        }
        
        return $this->sendResult($message,$data,$status);
    }

    public function route_area_list(int $route_id)
    {
        $data    = [];
        $message = "";
        $status  = true;
        try {
            $route = DB::table('sales_men_daily_routes')->where(['id' => $route_id, 'salesmen_id' => auth()->user()->id])->first();
            if($route)
            {
                $customers = DB::table('locations')->where(['parent_id'=>$route->route_id,'status'=>1])->pluck('name','id');
                if($customers){
                    foreach ($customers as $id => $name) {
                        $data[] = [
                            'id'   => $id,
                            'name' => $name
                        ];
                    }
                    $message = "Data found Successfully";
                }else{
                    $status  = false;
                    $message = "No Records Found";
                }
            }else{
                $status  = false;
                $message = "Invalid route";
            }
            
        } catch (Exception $e) {
            $status  = false;
            $message = $e->getMessage();
        }
        return $this->sendResult($message,$data,$status);
    }

    public function area_customer_list(int $area_id)
    {
        $data    = [];
        $message = "";
        $status  = true;
        try {
            $customers = DB::table('customers')->where(['area_id'=>$area_id,'status'=>1])->get();
            if($customers){
                foreach ($customers as $value) {
                    $data[] = [
                        'id' => $value->id,
                        'name' => $value->shop_name.' ('.$value->name.')'
                    ];
                }
                $message = "Data found Successfully";
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

}
