<?php

namespace Modules\Production\Http\Requests;

use App\Http\Requests\FormRequest;

class ProductionFinishedGoodsUpdateRequest extends FormRequest
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
        $this->rules['production_qty'] = ['required','numeric','gt:0'];
        if(request()->has('materials'))
        {
            foreach (request()->materials as $key => $value) {
                $total_qty   = $value['total_qty'] ? $value['total_qty'] : 0;
                $used_qty    = $value['used_qty'] ? $value['used_qty'] : 0;
                $damaged_qty = $value['damaged_qty'] ? $value['damaged_qty'] : 0;
                if($value['reupdate'] == 1){
                    $this->rules   ['materials.'.$key.'.total_qty']         = ['numeric','gt:0'];
                }else{
                    $this->rules   ['materials.'.$key.'.total_qty']         = ['numeric','gt:0','lte:'.$value['remaining_qty']];
                }
                
                $this->messages['materials.'.$key.'.total_qty.numeric'] = 'Value must be numeric';
                $this->messages['materials.'.$key.'.total_qty.gt']      = 'Value must be greater than or equal 0';
                $this->messages['materials.'.$key.'.total_qty.lte']      = 'Value must be less than or equal '.$value['remaining_qty'];

                $this->rules   ['materials.'.$key.'.used_qty']         = ['numeric','gte:0','lte:'.($total_qty)];
                $this->messages['materials.'.$key.'.used_qty.numeric'] = 'Value must be numeric';
                $this->messages['materials.'.$key.'.used_qty.gte']      = 'Value must be greater than or equal 0';
                $this->messages['materials.'.$key.'.used_qty.lte']      = 'Value must be less than or equal '.$total_qty;

                $this->rules   ['materials.'.$key.'.damaged_qty']         = ['numeric','gte:0','lte:'.($total_qty - $used_qty)];
                $this->messages['materials.'.$key.'.damaged_qty.numeric'] = 'Value must be numeric';
                $this->messages['materials.'.$key.'.damaged_qty.gte']      = 'Value must be greater than or equal 0';
                $this->messages['materials.'.$key.'.damaged_qty.lte']      = 'Value must be less than or equal '.($total_qty - $used_qty);

                $this->rules   ['materials.'.$key.'.odd_qty']         = ['numeric','gte:0','lte:'.($total_qty - ($used_qty + $damaged_qty))];
                $this->messages['materials.'.$key.'.odd_qty.numeric'] = 'Value must be numeric';
                $this->messages['materials.'.$key.'.odd_qty.gte']      = 'Value must be greater than or equal 0';
                $this->messages['materials.'.$key.'.odd_qty.lte']      = 'Value must be less than or equal '.($total_qty - ($used_qty + $damaged_qty));
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
