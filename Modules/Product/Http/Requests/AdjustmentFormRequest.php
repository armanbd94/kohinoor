<?php

namespace Modules\Product\Http\Requests;

use App\Http\Requests\FormRequest;

class AdjustmentFormRequest extends FormRequest
{
    protected $rules;
    protected $messages;
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $this->rules['adjustment_no']    = ['required'];

        if(request()->has('products'))
        {
            foreach (request()->products as $key => $value) {
                $this->rules   ['products.'.$key.'.qty']          = ['required','numeric','gt:0'];
                $this->messages['products.'.$key.'.qty.required'] = 'This field is required';
                $this->messages['products.'.$key.'.qty.numeric']  = 'The value must be numeric';
                $this->messages['products.'.$key.'.qty.gt']       = 'The value must be greater than 0';
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
