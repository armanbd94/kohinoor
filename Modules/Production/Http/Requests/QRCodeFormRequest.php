<?php

namespace Modules\Production\Http\Requests;

use App\Http\Requests\FormRequest;


class QRCodeFormRequest extends FormRequest
{
    public function rules()
    {
        return [
            'row_qty'     => 'required|integer|gt:0',
        ];
    }

    public function messages()
    {
        return [
            'row_qty.required'    => 'The each row field is required',
            'row_qty.integer'     => 'The each row value must be integer',
            'row_qty.gt:0'        => 'The each row value must be greater than 0',
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
