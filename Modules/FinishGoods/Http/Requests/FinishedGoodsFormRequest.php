<?php

namespace Modules\FinishGoods\Http\Requests;

use App\Http\Requests\FormRequest;

class FinishedGoodsFormRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'product_id'   => 'required',
            'code'         => 'required|string|unique:finish_goods,code,'.request()->update_id,
            'size_id'      => 'required',
            'cost'         => 'nullable|numeric|gte:0',
            'price'        => 'required|numeric|gt:0',
            'unit_id'      => 'required',
            'sale_unit_id' => 'required',
            'qty'          => 'required|numeric|gte:0',
            'alert_qty'    => 'nullable|numeric|gte:0',
        ];
    }

    public function messages()
    {
        return [
            'product_id.required' => 'The product field is required',
            'size_id.required' => 'The size field is required',
            'unit_id.required' => 'The unit field is required',
            'sale_unit_id.required' => 'The sale unit field is required',
            'qty.required' => 'The quantity field is required',
            'qty.numeric' => 'The quantity field value must be numeric',
            'qty.gte:0' => 'The quantity field value must be greater than or equal 0',
            'alert_qty.numeric' => 'The alert quantity field value must be numeric',
            'alert_qty.gte:0' => 'The alert quantity field value must be greater than or equal 0',
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
