<?php

namespace Modules\Production\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Product\Entities\Product;
use Modules\Setting\Entities\Warehouse;
use App\Http\Controllers\BaseController;

class ProductionController extends BaseController
{
    
    public function create()
    {
        if(permission('production-add')){
            $this->setPageData('Add Production','Add Production','fas fa-industry',[['name' => 'Add Production']]);
            $data = [
                'products'   => DB::table('products')->where('status', 1)->pluck('name','id'),
                'warehouses' => Warehouse::activeWarehouses(),
            ];
            return view('production::production.create',$data);
        }else{
            return $this->access_blocked(); 
        }
    }

    public function product_material_list(Request $request)
    {
        $tab = $request->tab;
        $materials = DB::table('product_material as pm')
                    ->join('materials as m','pm.material_id','=','m.id')
                    ->leftJoin('units as u','m.unit_id','=','u.id')
                    ->select('pm.*','m.material_name','m.material_code','m.cost','m.qty','m.type','m.unit_id','u.unit_name','u.unit_code')
                    ->where('pm.product_id',$request->product_id)
                    ->get();
        return view('production::production.materials',compact('materials','tab'))->render();
    }
}
