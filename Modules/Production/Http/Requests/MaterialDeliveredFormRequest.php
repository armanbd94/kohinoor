<?php

namespace Modules\Production\Http\Requests;

use App\Http\Requests\FormRequest;


class MaterialDeliveredFormRequest extends FormRequest
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
        $this->rules['material_delivered_status']=['required'];

        $collection = collect(request());
        if($collection->has('delivry_material')){
            foreach (request()->delivry_material as $key => $value) {
                $this->rules    ['delivry_material.'.$key.'.delivered_qty']         = ['required','numeric','gte:0'];
                $this->messages['delivry_material.'.$key.'.delivered_qty.required'] = 'The quantity field is required';
                $this->messages['delivry_material.'.$key.'.delivered_qty.numeric']  = 'The quantity field value must be numeric';
                $this->messages['delivry_material.'.$key.'.delivered_qty.gte']  = 'The quantity field value must be greater than or equal 0';
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
