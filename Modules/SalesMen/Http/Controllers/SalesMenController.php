<?php

namespace Modules\SalesMen\Http\Controllers;

use Exception;
use App\Models\ASM;
use App\Models\Salesmen;
use App\Traits\UploadAble;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Location\Entities\Route;
use Modules\Location\Entities\Upazila;
use Modules\Location\Entities\District;
use App\Http\Controllers\BaseController;
use Modules\SalesMen\Entities\SalesMenDailyRoute;
use Modules\SalesMen\Http\Requests\SalesMenFormRequest;

class SalesMenController extends BaseController
{
    use UploadAble;
    public function __construct(Salesmen $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('sales-representative-access')){
            $this->setPageData('Sales Representative','Sales Representative','fas fa-user-secret',[['name' => 'Sales Representative']]);
            $asms      = ASM::with('warehouse')->where('status',1)->get();
            $upazilas  = Upazila::where(['type'=>2,'status'=>1])->get();
            return view('salesmen::index',compact('asms','upazilas'));
        }else{
            return $this->access_blocked();
        }
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if (!empty($request->name)) {
                $this->model->setName($request->name);
            }
            if (!empty($request->username)) {
                $this->model->setUsername($request->username);
            }
            if (!empty($request->phone)) {
                $this->model->setPhone($request->phone);
            }
            if (!empty($request->email)) {
                $this->model->setEmail($request->email);
            }
            if (!empty($request->asm_id)) {
                $this->model->setASMID($request->asm_id);
            }
            if (!empty($request->district_id)) {
                $this->model->setDistrictID($request->district_id);
            }
            if (!empty($request->upazila_id)) {
                $this->model->setUpazilaID($request->upazila_id);
            }
            if (!empty($request->status)) {
                $this->model->setStatus($request->status);
            }

            $this->set_datatable_default_properties($request);//set datatable default properties
            $list = $this->model->getDatatableList();//get table data
            $data = [];
            $no = $request->input('start');
            foreach ($list as $value) {
                $no++;
                $action = '';
                if(permission('sales-representative-edit')){
                $action .= ' <a class="dropdown-item edit_data" data-id="' . $value->id . '">'.self::ACTION_BUTTON['Edit'].'</a>';
                }
                if(permission('sales-representative-view')){
                $action .= ' <a class="dropdown-item view_data" data-id="' . $value->id . '">'.self::ACTION_BUTTON['View'].'</a>';
                }
                if(permission('sales-representative-delete')){
                    $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->name . '">'.self::ACTION_BUTTON['Delete'].'</a>';
                }


                $row = [];
                if(permission('sales-representative-bulk-delete')){
                    $row[] = row_checkbox($value->id);//custom helper function to show the table each row checkbox
                }
                $row[] = $no;
                $row[] = $this->table_image(SALESMEN_AVATAR_PATH,$value->avatar,$value->name,'Male');
                $row[] = $value->name;
                $row[] = $value->username;
                $row[] = $value->phone;
                $row[] = $value->asm->name.' - '.$value->asm->warehouse->name;
                $row[] = $value->district->name;
                $row[] = $value->upazila->name;
                $row[] = $value->email ? $value->email : '<span class="label label-danger label-pill label-inline" style="min-width:70px !important;">No Email</span>';
                $row[] = permission('sales-representative-edit') ? change_status($value->id,$value->status, $value->name) : STATUS_LABEL[$value->status];
                $row[] = action_button($action);//custom helper function for action button
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
             $this->model->count_filtered(), $data);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function store_or_update_data(SalesMenFormRequest $request)
    {
        if($request->ajax()){
            if(permission('sales-representative-add') || permission('sales-representative-edit')){
                DB::beginTransaction();
                try {
                    $collection   = collect($request->validated())->except('password','password_confirmation');
                    $collection   = $this->track_data($collection,$request->update_id);
                    $avatar = !empty($request->old_avatar) ? $request->old_avatar : null;
                    if($request->hasFile('avatar')){
                        $avatar  = $this->upload_file($request->file('avatar'),SALESMEN_AVATAR_PATH);
                        if(!empty($request->old_avatar)){
                            $this->delete_file($request->old_avatar, SALESMEN_AVATAR_PATH);
                        }  
                    }
                    $routes = [];
                    if($request->has('routes'))
                    {
                        foreach ($request->routes as $key => $value) {
                            $routes[$value['route_id']] = [
                                'day' => $value['day']
                            ];
                        }
                    }
                    $collection        = $collection->merge(compact('avatar'));
                    if(!empty($request->password)){
                        $collection   = $collection->merge(['password'=>$request->password]);
                    }
                    $result       = $this->model->updateOrCreate(['id'=>$request->update_id],$collection->all());
                    $salesmen = $this->model->with('routes')->find($result->id);
                    $salesmen->routes()->sync($routes);
                    $output       = $this->store_message($result, $request->update_id);
                    DB::commit();
                } catch (Exception $e) {
                    DB::rollBack();
                    $output       = ['status' => 'error','message' => $e->getMessage()];
                }
                
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function edit(Request $request)
    {
        if($request->ajax()){
            if(permission('sales-representative-edit')){
                $data   = $this->model->findOrFail($request->id);
                $output = $this->data_message($data); //if data found then it will return data otherwise return error message
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function show(Request $request)
    {
        if($request->ajax()){
            if(permission('sales-representative-view')){
                $salesmen   = $this->model->with('asm','district','upazila','routes')->findOrFail($request->id);
                // dd($salesmen->routes[0]);
                return view('salesmen::view-data',compact('salesmen'))->render();
            }
        }
    }

    public function delete(Request $request)
    {
        if($request->ajax()){
            if(permission('sales-representative-delete')){
                $result   = $this->model->find($request->id)->delete();
                $output   = $this->delete_message($result);
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function bulk_delete(Request $request)
    {
        if($request->ajax()){
            if(permission('sales-representative-bulk-delete')){
                $result   = $this->model->destroy($request->ids);
                $output   = $this->bulk_delete_message($result);
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function change_status(Request $request)
    {
        if($request->ajax()){
            if(permission('sales-representative-edit')){
                $result   = $this->model->find($request->id)->update(['status' => $request->status]);
                $output   = $result ? ['status' => 'success','message' => 'Status Has Been Changed Successfully']
                : ['status' => 'error','message' => 'Failed To Change Status'];
            }else{
                $output       = $this->unauthorized();
            }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function upazila_route_list(Request $request)
    {
        if ($request->ajax()) {
            $routes = Route::where('parent_id',$request->upazila_id)->get();
            $salesmen_routes = SalesMenDailyRoute::with('route')->where('salesmen_id',$request->salesmen_id)->get();
            return view('salesmen::route-list',compact('routes','salesmen_routes'))->render();
        }
    }

    public function daily_route_list(Request $request)
    {
        if ($request->ajax()) {
            $routes = SalesMenDailyRoute::with('route')->where('salesmen_id',$request->id)->get();
            $output = '';
            if($routes)
            {
                $output .= '<option value="">Select Please</option>';
                foreach ($routes as $key => $value) {
                    $output .= '<option value="'.$value->route_id.'">'.DAYS[$value->day].' - '.$value->route->name.'</option>';
                }
            }

            return $output;
        }
    }
}
