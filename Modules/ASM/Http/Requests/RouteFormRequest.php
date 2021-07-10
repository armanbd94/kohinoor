<?php

namespace Modules\ASM\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class RouteFormRequest extends FormRequest
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
        $this->rules['name']      = ['required','string'];
        $this->rules['type']      = ['integer'];
        $this->rules['parent_id'] = ['required'];
        $this->rules['grand_parent_id'] = ['integer'];
        $this->messages['parent_id.requierd'] =  'The upazila field is required';
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
