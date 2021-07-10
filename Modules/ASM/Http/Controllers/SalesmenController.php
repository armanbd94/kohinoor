<?php

namespace Modules\ASM\Http\Controllers;

use Exception;
use App\Models\ASM;
use App\Traits\UploadAble;
use Illuminate\Http\Request;
use Modules\ASM\Entities\Route;
use Modules\ASM\Entities\Upazila;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\BaseController;
use Modules\ASM\Entities\SalesPerson;
use Modules\SalesMen\Entities\SalesMenDailyRoute;
use Modules\SalesMen\Http\Requests\SalesMenFormRequest;

class SalesmenController extends BaseController
{
    use UploadAble;
    public function __construct(SalesPerson $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Sales Representative','Sales Representative','fas fa-user-secret',[['name' => 'Sales Representative']]);
        $upazilas  = Upazila::where(['parent_id'=> Auth::guard('asm')->user()->district_id,'type'=>2,'status'=>1])->get();
        return view('asm::salesmen.index',compact('upazilas'));
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

                $action .= ' <a class="dropdown-item edit_data" data-id="' . $value->id . '">'.self::ACTION_BUTTON['Edit'].'</a>';
                $action .= ' <a class="dropdown-item view_data" data-id="' . $value->id . '">'.self::ACTION_BUTTON['View'].'</a>';
               
                $row = [];
                $row[] = $no;
                $row[] = $this->table_image(SALESMEN_AVATAR_PATH,$value->avatar,$value->name,'Male');
                $row[] = $value->name;
                $row[] = $value->username;
                $row[] = $value->phone;
                $row[] = $value->upazila->name;
                $row[] = $value->email ? $value->email : '<span class="label label-danger label-pill label-inline" style="min-width:70px !important;">No Email</span>';
                $row[] = STATUS_LABEL[$value->status];
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
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function edit(Request $request)
    {
        if($request->ajax()){
            $data   = $this->model->findOrFail($request->id);
            $output = $this->data_message($data); //if data found then it will return data otherwise return error message
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function show(Request $request)
    {
        if($request->ajax()){
            $salesmen   = $this->model->with('asm','district','upazila','routes')->findOrFail($request->id);
            return view('asm::salesmen.view-data',compact('salesmen'))->render();
        }
    }


    public function upazila_route_list(Request $request)
    {
        if ($request->ajax()) {
            $routes = Route::where('parent_id',$request->upazila_id)->get();
            $salesmen_routes = SalesMenDailyRoute::with('route')->where('salesmen_id',$request->salesmen_id)->get();
            return view('asm::salesmen.route-list',compact('routes','salesmen_routes'))->render();
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
