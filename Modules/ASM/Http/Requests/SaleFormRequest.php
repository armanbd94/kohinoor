<?php

namespace Modules\ASM\Http\Requests;

use App\Http\Requests\FormRequest;

class SaleFormRequest extends FormRequest
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
        $this->rules['salesmen_id']     = ['required'];
        $this->rules['route_id']     = ['required'];
        $this->rules['customer_id']     = ['required'];
        $this->rules['order_discount']  = ['numeric','gte:0'];
        $this->rules['shipping_cost']   = ['numeric','gte:0'];

        if(request()->has('products'))
        {
            foreach (request()->products as $key => $value) {
                $this->rules['products.'.$key.'.qty']             = ['required','numeric','gt:0','lte:'.$value['stock_qty']];
                $this->messages['products.'.$key.'.qty.required'] = 'This field is required';
                $this->messages['products.'.$key.'.qty.numeric']  = 'The value must be numeric';
                $this->messages['products.'.$key.'.qty.gt']       = 'The value must be greater than 0';
            }
        }

        if(!request()->has('sale_id'))
        {
            $this->rules['payment_status'] = ['required'];
            if(!empty(request()->payment_status) && request()->payment_status != 3)
            {
                $this->rules['paid_amount'] = ['required','numeric','gte:0','lte:'.request()->net_total];
                if(request()->payment_status == 1)
                {
                    $this->rules['paid_amount'][2] = 'min:'.request()->net_total;
                    $this->rules['paid_amount'][3] = 'max:'.request()->net_total;
                }
                $this->rules['payment_method'] = ['required'];
                $this->rules['account_id'] = ['required'];
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
