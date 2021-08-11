<?php

namespace Modules\Transfer\Http\Requests;

use App\Http\Requests\FormRequest;

class TransferRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $rules = [];
        $rules['chalan_no']           = ['required','unique:transfers,chalan_no'];
        $rules['transfer_date']       = ['required','date','date_format:Y-m-d'];
        $rules['warehouse_in']        = ['required'];
        $rules['total_unit_qty']      = ['required','numeric','gt:0'];
        $rules['total_base_unit_qty'] = ['required','numeric','gt:0'];
        $rules['total']               = ['required','numeric','gt:0'];
        $rules['grand_total']         = ['required','numeric','gt:0'];
        $rules['transfer_status']     = ['required'];
        $rules['shipping_cost']       = ['nullable','numeric','gt:0'];
        $rules['labor_cost']          = ['nullable','numeric','gt:0'];
        $rules['received_by']         = ['required'];
        $rules['carried_by']          = ['required'];
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
