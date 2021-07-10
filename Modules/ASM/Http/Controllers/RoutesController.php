<?php

namespace Modules\ASM\Http\Controllers;

use Illuminate\Http\Request;
use Modules\ASM\Entities\Route;
use Modules\ASM\Entities\Upazila;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\BaseController;
use Modules\ASM\Http\Requests\RouteFormRequest;

class RoutesController extends BaseController
{
    public function __construct(Route $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Route','Route','fas fa-map-marker-alt',[['name' => 'Location'],['name'=>'Route']]);
        $upazilas  = Upazila::where(['type' => 2,'status' => 1,'parent_id' => Auth::guard('asm')->user()->district_id])->get();
        return view('asm::upazila-route.index',compact('upazilas'));
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if (!empty($request->route_name)) {
                $this->model->setName($request->route_name);
            }
            if (!empty($request->parent_id)) {
                $this->model->setParentID($request->parent_id);
            }

            $this->set_datatable_default_properties($request);//set datatable default properties
            $list = $this->model->getDatatableList();//get table data
            $data = [];
            $no = $request->input('start');
            foreach ($list as $value) {
                $no++;
                $action = '';
                $action .= ' <a class="dropdown-item edit_data" data-id="' . $value->id . '">'.self::ACTION_BUTTON['Edit'].'</a>';
                $action .= ' <a class="dropdown-item delete_data"  data-id="' . $value->id . '" data-name="' . $value->name . '">'.self::ACTION_BUTTON['Delete'].'</a>';
                
                $row = [];
                $row[] = row_checkbox($value->id);//custom helper function to show the table each row checkbox
                $row[] = $no;
                $row[] = $value->name;
                $row[] = $value->upazila->name;
                $row[] =  change_status($value->id,$value->status, $value->name);
                $row[] = action_button($action);//custom helper function for action button
                $data[] = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
             $this->model->count_filtered(), $data);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function store_or_update_data(RouteFormRequest $request)
    {
        if($request->ajax()){
            $collection   = collect($request->validated());
            $collection   = $this->track_data($collection,$request->update_id);
            $result       = $this->model->updateOrCreate(['id'=>$request->update_id],$collection->all());
            $output       = $this->store_message($result, $request->update_id);
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

    public function delete(Request $request)
    {
        if($request->ajax()){
            $route = $this->model->find($request->id);
            $result = $route->delete();
            $output = $this->delete_message($result);
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function bulk_delete(Request $request)
    {
        if($request->ajax()){
                $result = $this->model->destroy($request->ids);
                $output = $this->bulk_delete_message($result);
                // $delete_list = [];
                // $undelete_list = [];
                // foreach ($request->ids as $id) {
                //     $upazila = $this->model->with('upazilas','routes')->find($id);
                //     if(!$route->routes->isEmpty()){
                //         array_push($undelete_list,$route->name);
                //     }else{
                //         array_push($delete_list,$id);
                //     }
                // } 
                // if(!empty($delete_list)){
                //         $result = $route->destroy($delete_list);
                //         $output = $result ?  ['status'=>'success','message'=> 'Selected Data Has Been Deleted Successfully. '. (!empty($undelete_list) ? 'Except these menus('.implode(',',$undelete_list).')'.' because they are associated with others data.' : '')] 
                //         : ['status'=>'error','message'=>'Failed To Delete Data.'];
                // }else{
                //     $output = ['status'=>'error','message'=> !empty($undelete_list) ? 'These upazilas('.implode(',',$undelete_list).')'.' 
                //     can\'t delete because they are associated with others data.' : ''];
                // }
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function change_status(Request $request)
    {
        if($request->ajax()){
            $result   = $this->model->find($request->id)->update(['status' => $request->status]);
            $output   = $result ? ['status' => 'success','message' => 'Status Has Been Changed Successfully']
            : ['status' => 'error','message' => 'Failed To Change Status'];
            return response()->json($output);
        }else{
            return response()->json($this->unauthorized());
        }
    }

    public function upazila_id_wise_route_list(int $id)
    {
        $routes = $this->model->upazila_id_wise_route_list($id);
        return json_encode($routes);
    }
}
