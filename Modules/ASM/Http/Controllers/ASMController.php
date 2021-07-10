<?php

namespace Modules\ASM\Http\Controllers;

use App\Models\ASM;
use App\Traits\UploadAble;
use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use App\Models\Warehouse;
use Modules\ASM\Http\Requests\ASMFormRequest;
use Modules\Location\Entities\District;

class ASMController extends BaseController
{
    use UploadAble;
    public function __construct(ASM $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        if(permission('asm-access')){
            $this->setPageData('ASM','ASM','fas fa-user-shield',[['name' => 'ASM']]);
            $data = [
                'warehouses' => Warehouse::where('status',1)->get(),
                'districts' => District::where(['type'=>1,'status'=>1])->get(),
            ];
            return view('asm::index',$data);
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
            if (!empty($request->warehouse_id)) {
                $this->model->setWarehouseID($request->warehouse_id);
            }
            if (!empty($request->district_id)) {
                $this->model->setDistrictID($request->district_id);
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
                if(permission('asm-edit')){
                $action .= ' <a class="dropdown-item edit_data" data-id="' . $value->id . '">'.self::ACTION_BUTTON['Edit'].'</a>';
                }
                if(permission('asm-view')){
                $action .= ' <a class="dropdown-item view_data" data-id="' . $value->id . '" data-name="' . $value->name . '">'.self::ACTION_BUTTON['View'].'</a>';
                }
                if(permission('asm-delete')){
                    $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->name . '">'.self::ACTION_BUTTON['Delete'].'</a>';
                }


                $row = [];
                if(permission('asm-bulk-delete')){
                    $row[] = row_checkbox($value->id);//custom helper function to show the table each row checkbox
                }
                $row[] = $no;
                $row[] = $this->table_image(ASM_AVATAR_PATH,$value->avatar,$value->name,'Male');
                $row[] = $value->name;
                $row[] = $value->username;
                $row[] = $value->warehouse->name;
                $row[] = $value->district->name;
                $row[] = $value->phone;
                $row[] = $value->email ? $value->email : '<span class="label label-danger label-pill label-inline" style="min-width:70px !important;">No Email</span>';
                $row[] = permission('asm-edit') ? change_status($value->id,$value->status, $value->name) : STATUS_LABEL[$value->status];
                $row[] = action_button($action);//custom helper function for action button
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
             $this->model->count_filtered(), $data);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function store_or_update_data(ASMFormRequest $request)
    {
        if($request->ajax()){
            if(permission('asm-add') || permission('asm-edit')){
                if($request->update_id)
                {
                    $warehouse_asm_exist  = $this->model->where('warehouse_id',$request->warehouse_id)->where('id','!=',$request->update_id)->get()->count();
                }else{
                    $warehouse_asm_exist  = $this->model->where('warehouse_id',$request->warehouse_id)->get()->count();
                }
                
                if($warehouse_asm_exist > 0){
                    return response()->json(['status'=>'error','message'=>'This warehouse has already assigned one ASM. Try another']);
                }else{
                    $collection   = collect($request->validated())->except('password','password_confirmation');
                    $collection   = $this->track_data($collection,$request->update_id);
                    $avatar = !empty($request->old_avatar) ? $request->old_avatar : null;
                    if($request->hasFile('avatar')){
                        $avatar  = $this->upload_file($request->file('avatar'),ASM_AVATAR_PATH);
                        if(!empty($request->old_avatar)){
                            $this->delete_file($request->old_avatar, ASM_AVATAR_PATH);
                        }  
                    }
                    $collection        = $collection->merge(compact('avatar'));
                    if(!empty($request->password)){
                        $collection   = $collection->merge(['password'=>$request->password]);
                    }
                    $result       = $this->model->updateOrCreate(['id'=>$request->update_id],$collection->all());
                    $output       = $this->store_message($result, $request->update_id);
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
            if(permission('asm-edit')){
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
            if(permission('asm-view')){
                $asm   = $this->model->with('warehouse','district')->findOrFail($request->id);
                return view('asm::view-data',compact('asm'))->render();
            }
        }
    }

    public function delete(Request $request)
    {
        if($request->ajax()){
            if(permission('asm-delete')){
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
            if(permission('asm-bulk-delete')){
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
            if(permission('asm-edit')){
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
}
