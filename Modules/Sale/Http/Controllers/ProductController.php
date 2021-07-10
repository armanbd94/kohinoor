<?php

namespace Modules\Sale\Http\Controllers;

use App\Models\Unit;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Auth;
use Modules\Product\Entities\Product;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\FinishGoods\Entities\WarehouseFinishGoods;

class ProductController extends Controller
{
    public function product_autocomplete_search(Request $request)
    {
        if($request->ajax())
        {
            if(!empty($request->search))
            {
                $output = [];
                $search_text = $request->search;
                $data =  WarehouseFinishGoods::with('product','finish_goods')->where([
                    [ 'warehouse_id',$request->warehouse_id],['qty','>',0]
                ])->where(function($subQuery) use ($search_text)
                {   
                    $subQuery->whereHas('finish_goods', function ($query) use ($search_text){
                        $query->where('code', 'like','%'.$search_text.'%' );
                    })
                    ->orWhereHas('product', function ($query) use ($search_text){
                        $query->where('product_name','like','%'.$search_text.'%');
                    });
                })->get();
                

                if(!$data->isEmpty())
                {
                    foreach ($data as $value) {
                        $item['id'] = $value->product->id;
                        $item['value'] = $value->finish_goods->code;
                        $item['label'] = $value->finish_goods->code.' - '.$value->product->product_name.' '.$value->finish_goods->size->size.$value->finish_goods->size->unit->unit_name;
                        $output[] = $item;
                    }
                }else{
                    $output['value'] = '';
                    $output['label'] = 'No Record Found';
                }
                
                
                return $output;
            }
        }
    }

    public function product_search(Request $request)
    {
        if($request->ajax())
        {
            $finish_goods_data = FinishGood::with('product','size')->where('code',$request['data'])->first();
            if($finish_goods_data)
            {
                $product['id']         = $finish_goods_data->id;
                $product['name']       = $finish_goods_data->product->product_name.' '.$finish_goods_data->size->size.$finish_goods_data->size->unit->unit_name ;
                $product['code']       = $finish_goods_data->code;
                $product['price']      = $finish_goods_data->price;
                
                
                $product['tax_rate']   = $finish_goods_data->product->tax->rate;
                $product['tax_name']   = $finish_goods_data->product->tax->name;
                $product['tax_method'] = $finish_goods_data->product->tax_method;

                $warehouse_product = WarehouseFinishGoods::where([
                    'warehouse_id'=> $request->warehouse_id,'product_id'=>$finish_goods_data->product_id,'finish_goods_id'=>$finish_goods_data->id])->first();
                $product['qty'] = $warehouse_product ? $warehouse_product->qty : 0;
                

    
                $units = Unit::where('base_unit',$finish_goods_data->unit_id)->orWhere('id',$finish_goods_data->unit_id)->get();
                $unit_name            = [];
                $unit_operator        = [];
                $unit_operation_value = [];
                if($units)
                {
                    foreach ($units as $unit) {
                        if($finish_goods_data->sale_unit_id == $unit->id)
                        {
                            array_unshift($unit_name,$unit->unit_name);
                            array_unshift($unit_operator,$unit->operator);
                            array_unshift($unit_operation_value,$unit->operation_value);
                        }else{
                            $unit_name           [] = $unit->unit_name;
                            $unit_operator       [] = $unit->operator;
                            $unit_operation_value[] = $unit->operation_value;
                        }
                    }
                }
                $product['unit_name'] = implode(',',$unit_name).',';
                $product['unit_operator'] = implode(',',$unit_operator).',';
                $product['unit_operation_value'] = implode(',',$unit_operation_value).',';
                return $product;
            }
        }
    }
}
