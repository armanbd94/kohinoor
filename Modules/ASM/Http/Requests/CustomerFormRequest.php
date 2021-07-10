<?php

namespace Modules\ASM\Http\Requests;

use App\Http\Requests\FormRequest;


class CustomerFormRequest extends FormRequest
{
    protected $rules = [];
    protected $messages = [];
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $this->rules['name']              = ['required','string','max:100'];
        $this->rules['shop_name']         = ['required','string','max:100'];
        $this->rules['mobile']            = ['required','string','max:15','unique:customers,mobile'];
        $this->rules['email']             = ['nullable','email','string','max:100','unique:customers,email'];
        $this->rules['customer_group_id'] = ['required'];
        $this->rules['district_id']       = ['required'];
        $this->rules['upazila_id']        = ['required'];
        $this->rules['route_id']          = ['required'];
        $this->rules['postal_code']       = ['nullable','string'];
        $this->rules['address']           = ['required','string'];
        $this->rules['previous_balance']  = ['nullable','numeric'];

        if(request()->update_id){
            $this->rules['mobile'][3] = 'unique:customers,mobile,'.request()->update_id;
            $this->rules['email'][4]  = 'unique:customers,email,'.request()->update_id;
        }
        return $this->rules;
    }

    public function messages()
    {
        $this->messages['customer_group_id.required'] = 'This customer group field is required';
        $this->messages['district_id.required']       = 'This district field is required';
        $this->messages['upazila_id.required']        = 'This upazila field is required';
        $this->messages['route_id.required']          = 'This route field is required';
        return $this->messages;
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
