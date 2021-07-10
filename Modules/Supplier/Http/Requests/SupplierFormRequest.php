<?php

namespace Modules\Supplier\Http\Requests;

use App\Http\Requests\FormRequest;

class SupplierFormRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $rulse['name']             = ['required','string','max:100'];
        $rulse['company_name']     = ['nullable','string','max:100'];
        $rulse['mobile']           = ['required','string','max:15','unique:suppliers,mobile'];
        $rulse['email']            = ['nullable','email','string','max:100','unique:suppliers,email'];
        $rulse['phone']            = ['nullable','string','unique:suppliers,phone'];
        $rulse['city']             = ['nullable','string'];
        $rulse['state']            = ['nullable','string'];
        $rulse['zip']              = ['nullable','string'];
        $rulse['country']          = ['nullable','string'];
        $rulse['address']          = ['nullable','string'];
        $rulse['previous_balance'] = ['nullable','numeric'];

        if(request()->update_id){
            $rulse['mobile'][3]           = 'unique:suppliers,mobile,'.request()->update_id;
            $rulse['email'][4]            = 'unique:suppliers,email,'.request()->update_id;
            $rulse['phone'][2]            = 'unique:suppliers,phone,'.request()->update_id;
        }
        return $rulse;
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
