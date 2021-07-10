<?php

namespace Modules\Supplier\Http\Requests;

use App\Http\Requests\FormRequest;

class SupplierAdvanceFormRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'supplier' => 'required',
            'type'     => 'required',
            'amount'   => 'required|numeric|gt:0'
        ];
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
