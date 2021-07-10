<?php

namespace Modules\Production\Http\Requests;

use App\Http\Requests\FormRequest;

class MaterialReturnedFormRequest extends FormRequest
{
    protected $rules    = [];
    protected $messages = [];
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $collection = collect(request());
        if($collection->has('delivry_material')){
            foreach (request()->delivry_material as $key => $value) {
                $this->rules    ['delivry_material.'.$key.'.used_qty']           = ['numeric','gte:0'];
                $this->messages['delivry_material.'.$key.'.used_qty.numeric']    = 'The value must be numeric';
                $this->messages['delivry_material.'.$key.'.used_qty.gte']        = 'The value must be greater than or equal 0';
                $this->rules    ['delivry_material.'.$key.'.odd_qty']            = ['numeric','gte:0'];
                $this->messages['delivry_material.'.$key.'.odd_qty.numeric']     = 'The value must be numeric';
                $this->messages['delivry_material.'.$key.'.odd_qty.gte']         = 'The value must be greater than or equal 0';
                $this->rules    ['delivry_material.'.$key.'.damaged_qty']        = ['numeric','gte:0'];
                $this->messages['delivry_material.'.$key.'.damaged_qty.numeric'] = 'The value must be numeric';
                $this->messages['delivry_material.'.$key.'.damaged_qty.gte']     = 'The value must be greater than or equal 0';
            }
        }
        return $this->rules;
    }

    public function messages()
    {
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
