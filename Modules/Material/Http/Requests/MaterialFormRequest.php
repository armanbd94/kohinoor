<?php

namespace Modules\Material\Http\Requests;

use App\Http\Requests\FormRequest;

class MaterialFormRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $rules['material_name']    = ['required','string','unique:materials,material_name'];
        $rules['type']             = ['required','integer'];
        $rules['material_code']    = ['required','string','unique:materials,material_code'];
        $rules['material_image']   = ['nullable','image','mimes:png,jpg,jpeg,svg'];
        $rules['category_id']      = ['required','integer'];
        $rules['purchase_price']   = ['required','numeric','gte:0'];
        $rules['unit_id']          = ['required','string'];
        $rules['purchase_unit_id'] = ['required','string'];
        $rules['qty']              = ['nullable','numeric','gte:0'];
        $rules['alert_qty']        = ['nullable','numeric','gte:0'];
        $rules['tax_id']           = ['nullable','numeric'];
        $rules['tax_method']       = ['required','numeric'];

        if(request()->update_id){
            $rules['material_name'][2] = 'unique:materials,material_name,'.request()->update_id;
            $rules['material_code'][2] = 'unique:materials,material_code,'.request()->update_id;
        }
        return $rules;
    }

    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }
}
