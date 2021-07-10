<?php

namespace Modules\Product\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\Product\Http\Requests\BarcodeFormRequest;

class BarcodeController extends BaseController
{
    public function __construct(FinishGood $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('print-barcode-access')){
            $this->setPageData('Print Barcode','Print Barcode','fas fa-barcode',[['name'=>'Product','link'=> route('product')],['name' => 'Print Barcode']]);
            $data = [
                // 'materials'  => Material::where('status',1)->get(),
                // 'categories' => Category::allProductCategories(),
                // 'units'      => Unit::allUnits(),
                // 'taxes'      => Tax::activeTaxes(),
                // 'sizes'      => Size::activeSizes(),
                'finished_goods' => $this->model->with('product:id,product_name','size')->get()
            ];
            // dd($this->generateEAN(1166));
            return view('product::barcode.index',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function generateBarcode(BarcodeFormRequest $request)
    {
        if($request->ajax())
        {
            $data = [
                'barcode'       => $request->product,
                'product_name'  => $request->product_name,
                'product_price' => $request->product_price,
                'barcode_qty'   => $request->barcode_qty,
                'row_qty'       => $request->row_qty
            ];
            return view('product::barcode.print-area',$data)->render();
        }
    }

    public function generateEAN($number)
    {
        $code = '894' . str_pad($number, 9, '0');
        $weightflag = true;
        $sum = 0;
        // Weight for a digit in the checksum is 3, 1, 3.. starting from the last digit. 
        // loop backwards to make the loop length-agnostic. The same basic functionality 
        // will work for codes of different lengths.
        for ($i = strlen($code) - 1; $i >= 0; $i--)
        {
            $sum += (int)$code[$i] * ($weightflag?3:1);
            $weightflag = !$weightflag;
        }
        $code .= (10 - ($sum % 10)) % 10;
        return $code;
    }
}
