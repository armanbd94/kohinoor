<?php

namespace Modules\ASM\Http\Controllers;

use Illuminate\Http\Request;
use Modules\ASM\Entities\Upazila;
use App\Http\Controllers\BaseController;

class UpazilaController extends BaseController
{
    public function __construct(Upazila $model)
    {
        parent::__construct($model);
    }

    public function index()
    {
        $this->setPageData('Upazila','Upazila','fas fa-map-marker-alt',[['name' => 'Location'],['name'=>'Upazila']]);
        return view('asm::upazila.index');
    }

    public function get_datatable_data(Request $request)
    {
        if($request->ajax()){
            if (!empty($request->upazila_name)) {
                $this->model->setName($request->upazila_name);
            }
            $this->set_datatable_default_properties($request);//set datatable default properties
            $list = $this->model->getDatatableList();//get table data
            $data = [];
            $no = $request->input('start');
            foreach ($list as $value) {
                $no++;

                $row       = [];
                $row []    = $no;
                $row []    = $value->name;
                $row []    = STATUS_LABEL[$value->status];
                $data[]    = $row;
            }
            return $this->datatable_draw($request->input('draw'),$this->model->count_all(),
             $this->model->count_filtered(), $data);
        }else{
            return response()->json($this->unauthorized());
        }
    }
}
