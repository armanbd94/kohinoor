<?php

namespace Modules\Transfer\Http\Controllers;

use Exception;
use App\Models\ASM;
use App\Models\Tax;
use App\Models\Unit;
use App\Models\Warehouse;
use App\Traits\UploadAble;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Modules\Transfer\Entities\Transfer;
use App\Http\Controllers\BaseController;
use Modules\FinishGoods\Entities\FinishGood;
use Modules\FinishGoods\Entities\WarehouseFinishGoods;
use Modules\Transfer\Http\Requests\TransferFormRequest;

class TransferController extends BaseController
{
    use UploadAble;
    private const CHALAN_NO = 1001;
    public function __construct(Transfer $model)
    {
        parent::__construct($model);
    }
    
    public function index()
    {
        if(permission('transfer-access')){
            $this->setPageData('Transfer Manage','Transfer Manage','fas fa-share-square',[['name' => 'Transfer Manage']]);
            $warehouses = Warehouse::where('status',1)->get();
            return view('transfer::index',compact('warehouses'));
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if(permission('transfer-access')){

                if (!empty($request->chalan_no)) {
                    $this->model->setChalanNo($request->chalan_no);
                }
                if (!empty($request->from_date)) {
                    $this->model->setFromDate($request->from_date);
                }
                if (!empty($request->to_date)) {
                    $this->model->setToDate($request->to_date);
                }
                if (!empty($request->from_warehouse_id)) {
                    $this->model->setFromWarehouseID($request->from_warehouse_id);
                }
                if (!empty($request->to_warehouse_id)) {
                    $this->model->setToWarehouseID($request->to_warehouse_id);
                }
                if (!empty($request->transfer_status)) {
                    $this->model->setTransferStatus($request->transfer_status);
                }


                $this->set_datatable_default_properties($request);//set datatable default properties
                $list = $this->model->getDatatableList();//get table data
                $data = [];
                $no = $request->input('start');
                foreach ($list as $value) {
                    $no++;
                    $action = '';
                    if(permission('transfer-edit')){
                        $action .= ' <a class="dropdown-item" href="'.route("transfer.edit",$value->id).'">'.self::ACTION_BUTTON['Edit'].'</a>';
                    }
                    if(permission('transfer-view')){
                        $action .= ' <a class="dropdown-item view_data" href="'.route("transfer.show",$value->id).'">'.self::ACTION_BUTTON['View'].'</a>';
                    }
                    if(permission('transfer-delete')){
                        $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->chalan_no . '">'.self::ACTION_BUTTON['Delete'].'</a>';
                    }
                    
                    $row = [];
                    if(permission('transfer-bulk-delete')){
                        $row[] = row_checkbox($value->id);//custom helper function to show the table each row checkbox
                    }
                    $row[] = $no;
                    $row[] = $value->chalan_no;
                    $row[] = $value->from_warehouse->name;
                    $row[] = $value->to_warehouse->name;
                    $row[] = $value->item;
                    $row[] = number_format($value->total_cost,2);
                    $row[] = $value->total_labor_cost ? number_format($value->total_labor_cost,2) : 0;
                    $row[] = $value->shipping_cost ? number_format($value->shipping_cost,2) : 0;
                    $row[] = number_format($value->grand_total,2);
                    $row[] = date(config('settings.date_format'),strtotime($value->transfer_date));
                    $row[] = TRANSFER_STATUS_LABEL[$value->transfer_status];
                    $row[] = action_button($action);//custom helper function for action button
                    $data[] = $row;
                }
                return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
                $this->model->count_filtered(), $data);
            }
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function create()
    {
        if(permission('transfer-add')){
            $this->setPageData('Add Transfer','Add Transfer','fas fa-share-square',[['name' => 'Add Transfer']]);
            $transfer = $this->model->select('chalan_no')->orderBy('chalan_no','desc')->first();
            $data = [
                'warehouses' => Warehouse::activeWarehouses(),
                'taxes'      => Tax::activeTaxes(),
                'asms'       => ASM::where('status',1)->get(),
                'chalan_no'  => 'TINV-'.($transfer ? explode('TINV-',$transfer->chalan_no)[1] + 1 : self::CHALAN_NO)
            ];
            return view('transfer::create',$data);
        }else{
            return $this->access_blocked();
        }
        
    }

    public function store(TransferFormRequest $request)
    {
        if($request->ajax()){
            if(permission('transfer-add')){
                DB::beginTransaction();
                try {
                    $transfer_data = [
                        'chalan_no'         => $request->chalan_no,
                        'from_warehouse_id' => $request->from_warehouse_id,
                        'to_warehouse_id'   => $request->to_warehouse_id,
                        'item'              => $request->item,
                        'total_qty'         => $request->total_qty,
                        'total_tax'         => $request->total_tax,
                        'total_cost'        => $request->total_cost,
                        'shipping_cost'     => $request->shipping_cost ? $request->shipping_cost : 0,
                        'total_labor_cost'  => $request->labor_cost ? $request->labor_cost : 0,
                        'grand_total'       => $request->grand_total,
                        'transfer_status'   => $request->transfer_status,
                        'note'              => $request->note,
                        'transfer_date'     => $request->transfer_date,
                        'carried_by'        => $request->carried_by,
                        'received_by'       => $request->received_by,
                        'created_by'        => Auth::user()->name
                    ];
                    if($request->hasFile('document')){
                        $transfer_data['document'] = $this->upload_file($request->file('document'),TRANSFER_DOCUMENT_PATH);
                    }

                    $finish_goods = [];
                    if($request->has('products'))
                    {
                        foreach ($request->products as $key => $value) {
                            $unit = Unit::where('unit_name',$value['unit'])->first();
                            if($request->transfer_status != 2)
                            {
                                if($unit->operator == '*'){
                                    $qty = $value['qty'] * $unit->operation_value;
                                }else{
                                    $qty = $value['qty'] / $unit->operation_value;
                                }
                            }else{
                                $qty = 0;
                            }

                            $finish_goods[$value['id']] = [
                                'qty'              => $value['qty'],
                                'unit_id'          => $unit ? $unit->id : null,
                                'net_unit_cost'    => $value['net_unit_cost'],
                                'tax_rate'         => $value['tax_rate'],
                                'tax'              => $value['tax'],
                                'total'            => $value['subtotal']
                            ];
                            if($request->transfer_status != 2)
                            {
                                $finish_goods_data = FinishGood::find($value['id']);
                                if($request->from_warehouse_id == 1)
                                {
                                    if($finish_goods_data){
                                        $finish_goods_data->qty -= $qty;
                                        $finish_goods_data->save();
                                    }
                                }
                                //Minus Finish Goods Qty From Warehosue
                                $from_warehouse_finish_goods = WarehouseFinishGoods::where(['warehouse_id'=>$request->from_warehouse_id,'finish_goods_id'=>$value['id']])->first();
                                if($from_warehouse_finish_goods){
                                    $from_warehouse_finish_goods->qty -= $qty;
                                    $from_warehouse_finish_goods->save();
                                }
                            }
                            if($request->transfer_status == 1)
                            {
                                //Add Finish Goods Qty To Warehosue
                                $to_warehouse_finish_goods = WarehouseFinishGoods::where(['warehouse_id'=>$request->to_warehouse_id,'finish_goods_id'=>$value['id']])->first();
                                if($to_warehouse_finish_goods){
                                    $to_warehouse_finish_goods->qty += $qty;
                                    $to_warehouse_finish_goods->save();
                                }else{
                                    WarehouseFinishGoods::create([
                                        'warehouse_id'    => $request->to_warehouse_id,
                                        'product_id'      => $finish_goods_data->product_id,
                                        'finish_goods_id' => $value['id'],
                                        'qty'             => $qty
                                    ]);
                                }
                            }

                        }
                    }
                    $result  = $this->model->create($transfer_data);
                    if(!$result)
                    {
                        if($request->hasFile('document')){
                            $this->delete_file($transfer_data['document'], TRANSFER_DOCUMENT_PATH);
                        }
                    }
                    $transfer = $this->model->with('transfer_products')->find($result->id);
                    $transfer->transfer_products()->sync($finish_goods);
                    $output  = $this->store_message($result, null);
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollback();
                    $output = ['status' => 'error','message' => $e->getMessage()];
                }
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function show(int $id)
    {
        if(permission('transfer-view')){
            $this->setPageData('Transfer Details','Transfer Details','fas fa-file',[['name'=>'Transfer','link' => route('purchase')],['name' => 'Transfer Details']]);
            $transfer = $this->model->with('transfer_products','from_warehouse','to_warehouse','asm')->find($id);
            return view('transfer::details',compact('transfer'));
        }else{
            return $this->access_blocked();
        }
    }
    public function edit(int $id)
    {

        if(permission('transfer-edit')){
            $this->setPageData('Edit Transfer','Edit Transfer','fas fa-edit',[['name'=>'Transfer','link' => route('purchase')],['name' => 'Edit Transfer']]);
            $data = [
                'transfer'   => $this->model->with('transfer_products')->find($id),
                'warehouses' => Warehouse::activeWarehouses(),
                'taxes'      => Tax::activeTaxes(),
                'asms'       => ASM::where('status',1)->get(),
            ];
            return view('transfer::edit',$data);
        }else{
            return $this->access_blocked();
        }
    }

    public function update(TransferFormRequest $request)
    {
        if($request->ajax()){
            if(permission('transfer-edit')){
                DB::beginTransaction();
                try {
                    $transfer_data = [
                        'chalan_no'         => $request->chalan_no,
                        'from_warehouse_id' => $request->from_warehouse_id,
                        'to_warehouse_id'   => $request->to_warehouse_id,
                        'item'              => $request->item,
                        'total_qty'         => $request->total_qty,
                        'total_tax'         => $request->total_tax,
                        'total_cost'        => $request->total_cost,
                        'shipping_cost'     => $request->shipping_cost ? $request->shipping_cost : 0,
                        'total_labor_cost'  => $request->labor_cost ? $request->labor_cost : 0,
                        'grand_total'       => $request->grand_total,
                        'transfer_status'   => $request->transfer_status,
                        'note'              => $request->note,
                        'transfer_date'     => $request->transfer_date,
                        'carried_by'        => $request->carried_by,
                        'received_by'       => $request->received_by,
                        'updated_by'        => Auth::user()->name
                    ];
                    if($request->hasFile('document')){
                        $transfer_data['document'] = $this->upload_file($request->file('document'),TRANSFER_DOCUMENT_PATH);
                    }

                    $transferData = $this->model->with('transfer_products')->find($request->transfer_id);
                    $old_document = $transferData ? $transferData->document : '';
                    if(!$transferData->transfer_products->isEmpty() && $transferData->transfer_status != 2)
                    {
                        foreach ($transferData->transfer_products as  $transfer_product) {
                            $old_transfer_qty = $transfer_product->pivot->qty;
                            $transfer_unit = Unit::find($transfer_product->pivot->unit_id);
                            if($transfer_unit->operator == '*'){
                                $old_transfer_qty = $old_transfer_qty * $transfer_unit->operation_value;
                            }else{
                                $old_transfer_qty = $old_transfer_qty / $transfer_unit->operation_value;
                            }
    
                            if($transferData->transfer_status != 2)
                            {
                                $finish_goods_data = FinishGood::find($transfer_product->id);
                                if($transferData->from_warehouse_id == 1)
                                {
                                    if($finish_goods_data){
                                        $finish_goods_data->qty += $old_transfer_qty;
                                        $finish_goods_data->save();
                                    }
                                }
                                $from_warehouse_product = WarehouseFinishGoods::where([
                                    'warehouse_id'    => $transferData->from_warehouse_id,
                                    'product_id'      => $transfer_product->product_id,
                                    'finish_goods_id' => $transfer_product->id,
                                    ])->first();
                                $from_warehouse_product->qty += $old_transfer_qty;
                                $from_warehouse_product->update();
                            }

                            if($transferData->transfer_status == 1)
                            {
                                $to_warehouse_product = WarehouseFinishGoods::where([
                                    'warehouse_id'    => $transferData->to_warehouse_id,
                                    'product_id'      => $transfer_product->product_id,
                                    'finish_goods_id' => $transfer_product->id,
                                    ])->first();
                                $to_warehouse_product->qty -= $old_transfer_qty;
                                $to_warehouse_product->update();
                            }
                        }
                    }
                    $finish_goods = [];
                    if($request->has('products'))
                    {
                        foreach ($request->products as $key => $value) {
                            $unit = Unit::where('unit_name',$value['unit'])->first();
                            if($request->transfer_status != 2)
                            {
                                if($unit->operator == '*'){
                                    $qty = $value['qty'] * $unit->operation_value;
                                }else{
                                    $qty = $value['qty'] / $unit->operation_value;
                                }
                            }else{
                                $qty = 0;
                            }

                            $finish_goods[$value['id']] = [
                                'qty'              => $value['qty'],
                                'unit_id'          => $unit ? $unit->id : null,
                                'net_unit_cost'    => $value['net_unit_cost'],
                                'tax_rate'         => $value['tax_rate'],
                                'tax'              => $value['tax'],
                                'total'            => $value['subtotal']
                            ];
                            if($request->transfer_status != 2)
                            {
                                $finish_goods_data = FinishGood::find($value['id']);
                                if($request->from_warehouse_id == 1)
                                {
                                    if($finish_goods_data){
                                        $finish_goods_data->qty -= $qty;
                                        $finish_goods_data->save();
                                    }
                                }
                                //Minus Finish Goods Qty From Warehosue
                                $from_warehouse_finish_goods = WarehouseFinishGoods::where(['warehouse_id'=>$request->from_warehouse_id,'finish_goods_id'=>$value['id']])->first();
                                if($from_warehouse_finish_goods){
                                    $from_warehouse_finish_goods->qty -= $qty;
                                    $from_warehouse_finish_goods->save();
                                }
                            }
                            if($request->transfer_status == 1)
                            {
                                //Add Finish Goods Qty To Warehosue
                                $to_warehouse_finish_goods = WarehouseFinishGoods::where(['warehouse_id'=>$request->to_warehouse_id,'finish_goods_id'=>$value['id']])->first();
                                if($to_warehouse_finish_goods){
                                    $to_warehouse_finish_goods->qty += $qty;
                                    $to_warehouse_finish_goods->save();
                                }else{
                                    WarehouseFinishGoods::create([
                                        'warehouse_id'    => $request->to_warehouse_id,
                                        'product_id'      => $finish_goods_data->product_id,
                                        'finish_goods_id' => $value['id'],
                                        'qty'             => $qty
                                    ]);
                                }
                            }

                        }
                    }
                    $transfer = $transferData->update($transfer_data);
                    if($transfer && $old_document != '')
                    {
                        $this->delete_file($old_document,TRANSFER_DOCUMENT_PATH);
                    }
                    $transferData->transfer_products()->sync($finish_goods);
                    $output  = $this->store_message($transfer, $request->transfer_id);
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollback();
                    $output = ['status' => 'error','message' => $e->getMessage()];
                }
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function delete(Request $request)
    {
        if($request->ajax()){
            if(permission('transfer-delete')){
                DB::beginTransaction();
                try {
                    $transferData = $this->model->with('transfer_products')->find($request->id);
                    $old_document = $transferData ? $transferData->document : '';
                    if(!$transferData->transfer_products->isEmpty())
                    {
                        if($transferData->transfer_status != 2){
                            foreach ($transferData->transfer_products as  $transfer_product) {
                                $old_transfer_qty = $transfer_product->pivot->qty;
                                $transfer_unit = Unit::find($transfer_product->pivot->unit_id);
                                if($transfer_unit->operator == '*'){
                                    $old_transfer_qty = $old_transfer_qty * $transfer_unit->operation_value;
                                }else{
                                    $old_transfer_qty = $old_transfer_qty / $transfer_unit->operation_value;
                                }
        
                                if($transferData->transfer_status != 2)
                                {
                                    $finish_goods_data = FinishGood::find($transfer_product->id);
                                    if($transferData->from_warehouse_id == 1)
                                    {
                                        if($finish_goods_data){
                                            $finish_goods_data->qty += $old_transfer_qty;
                                            $finish_goods_data->save();
                                        }
                                    }
                                    $from_warehouse_product = WarehouseFinishGoods::where([
                                        'warehouse_id'    => $transferData->from_warehouse_id,
                                        'product_id'      => $transfer_product->product_id,
                                        'finish_goods_id' => $transfer_product->id,
                                        ])->first();
                                    $from_warehouse_product->qty += $old_transfer_qty;
                                    $from_warehouse_product->update();
                                }

                                if($transferData->transfer_status == 1)
                                {
                                    $to_warehouse_product = WarehouseFinishGoods::where([
                                        'warehouse_id'    => $transferData->to_warehouse_id,
                                        'product_id'      => $transfer_product->product_id,
                                        'finish_goods_id' => $transfer_product->id,
                                        ])->first();
                                    $to_warehouse_product->qty -= $old_transfer_qty;
                                    $to_warehouse_product->update();
                                }
                            }
                        }
                        $transferData->transfer_products()->detach();
                    }
                    $result = $transferData->delete();
                    if($result)
                    {
                        if($old_document != '')
                        {
                            $this->delete_file($old_document,TRANSFER_DOCUMENT_PATH);
                        }
                        $output = ['status' => 'success','message' => 'Data has been deleted successfully'];
                    }else{
                        $output = ['status' => 'error','message' => 'failed to delete data'];
                    }
                    
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollBack();
                    $output = ['status'=>'error','message'=>$e->getMessage()];
                }
                return response()->json($output);
            }else{
                $output = $this->access_blocked();
            }
            return response()->json($output);
        }else{
            return response()->json($this->access_blocked());
        }
    }

    public function bulk_delete(Request $request)
    {
        if($request->ajax()){
            if(permission('transfer-bulk-delete')){
                foreach ($request->ids as $id) {
                    DB::beginTransaction();
                    try {
                        $transferData = $this->model->with('transfer_products')->find($id);
                        $old_document = $transferData ? $transferData->document : '';
                        if(!$transferData->transfer_products->isEmpty())
                        {
                            if($transferData->transfer_status != 2){
                                foreach ($transferData->transfer_products as  $transfer_product) {
                                    $old_transfer_qty = $transfer_product->pivot->qty;
                                    $transfer_unit = Unit::find($transfer_product->pivot->unit_id);
                                    if($transfer_unit->operator == '*'){
                                        $old_transfer_qty = $old_transfer_qty * $transfer_unit->operation_value;
                                    }else{
                                        $old_transfer_qty = $old_transfer_qty / $transfer_unit->operation_value;
                                    }
            
                                    if($transferData->transfer_status != 2)
                                    {
                                        $finish_goods_data = FinishGood::find($transfer_product->id);
                                        if($transferData->from_warehouse_id == 1)
                                        {
                                            if($finish_goods_data){
                                                $finish_goods_data->qty += $old_transfer_qty;
                                                $finish_goods_data->save();
                                            }
                                        }
                                        $from_warehouse_product = WarehouseFinishGoods::where([
                                            'warehouse_id'    => $transferData->from_warehouse_id,
                                            'product_id'      => $transfer_product->product_id,
                                            'finish_goods_id' => $transfer_product->id,
                                            ])->first();
                                        $from_warehouse_product->qty += $old_transfer_qty;
                                        $from_warehouse_product->update();
                                    }
    
                                    if($transferData->transfer_status == 1)
                                    {
                                        $to_warehouse_product = WarehouseFinishGoods::where([
                                            'warehouse_id'    => $transferData->to_warehouse_id,
                                            'product_id'      => $transfer_product->product_id,
                                            'finish_goods_id' => $transfer_product->id,
                                            ])->first();
                                        $to_warehouse_product->qty -= $old_transfer_qty;
                                        $to_warehouse_product->update();
                                    }
                                }
                            }
                            $transferData->transfer_products()->detach();
                        }
                        $result = $transferData->delete();
                        if($result)
                        {
                            if($old_document != '')
                            {
                                $this->delete_file($old_document,TRANSFER_DOCUMENT_PATH);
                            }
                            $output = ['status' => 'success','message' => 'Data has been deleted successfully'];
                        }else{
                            $output = ['status' => 'error','message' => 'failed to delete data'];
                        }
                        DB::commit();
                    } catch (Exception $e) {
                        DB::rollBack();
                        $output = ['status'=>'error','message'=>$e->getMessage()];
                    }
                    return response()->json($output);
                }
            }else{
                $output = $this->access_blocked();
            }
            return response()->json($output);
        }else{
            return response()->json($this->access_blocked());
        }
    }


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
                $product['cost']       = $finish_goods_data->cost;
                
                
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
                        if($finish_goods_data->unit_id == $unit->id)
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
