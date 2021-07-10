<?php

namespace Modules\ASM\Http\Requests;

use App\Http\Requests\FormRequest;
use Illuminate\Support\Facades\Auth;


class ProfileUpdateFormRequest extends FormRequest
{
    protected $rules = [];
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $this->rules['name']                  = ['required', 'string'];
        $this->rules['address']               = ['required', 'string'];
        $this->rules['phone']                 = ['required', 'string', 'max:15', 'unique:asms,phone,'.Auth::guard('asm')->user()->id];
        $this->rules['email']                 = ['nullable', 'string', 'email', 'unique:asms,email,'.Auth::guard('asm')->user()->id];
        return $this->rules;
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
