<?php

namespace Modules\Production\Http\Requests;

use App\Http\Requests\FormRequest;

class ProductionFormRequest extends FormRequest
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
        if(empty(request()->update_id)){
            $this->rules['batch_no'] = ['required','numeric','unique:productions,batch_no'];
        }else{
            $this->rules['batch_no'] = ['required','numeric','unique:productions,batch_no,'.request()->update_id];
        }
        $this->rules['warehouse_id'] = ['required'];
        if(request()->update_id){
            $this->rules['start_date']   = ['required','date','date_format:Y-m-d'];
            // $this->rules['end_date']     = ['required','date','date_format:Y-m-d','after_or_equal:start_date'];
            $this->rules['mfg_date']     = ['required','date','date_format:Y-m-d'];
            $this->rules['exp_date']     = ['required','date','date_format:Y-m-d','after_or_equal:mfg_date'];
        }else{
            $this->rules['start_date']   = ['required','date','date_format:Y-m-d','after_or_equal:'.date('Y-m-d')];
            // $this->rules['end_date']     = ['required','date','date_format:Y-m-d','after_or_equal:start_date'];
            $this->rules['mfg_date']     = ['required','date','date_format:Y-m-d','after_or_equal:'.date('Y-m-d')];
            $this->rules['exp_date']     = ['required','date','date_format:Y-m-d','after_or_equal:mfg_date'];
        }
        
        $this->rules['product_id']   = ['required'];
        $this->rules['description']  = ['nullable','string'];

        

        $collection = collect(request());
        if($collection->has('materials')){
            foreach (request()->materials as $key => $value) {
                $this->rules    ['materials.'.$key.'.id']          = ['required'];
                $this->rules    ['materials.'.$key.'.qty']         = ['required','numeric','gt:0'];
                $this->messages['materials.'.$key.'.id.required']  = 'The material name field is required';
                $this->messages['materials.'.$key.'.qty.required'] = 'The quantity field is required';
                $this->messages['materials.'.$key.'.qty.numeric']  = 'The quantity field value must be numeric';
                $this->messages['materials.'.$key.'.qty.numeric']  = 'The quantity field value must be greater than 0';
            }
        }

        if($collection->has('variants')){
            foreach (request()->variants as $key => $value) {

                $this->rules   ['variants.'.$key.'.total_coupon']         = ['nullable','numeric','gt:0'];
                $this->messages['variants.'.$key.'.total_coupon.numeric'] = 'Value must be numeric';
                $this->messages['variants.'.$key.'.total_coupon.gt']      = 'Value must be greater than or equal 0';

                if(!empty($value['total_coupon'])){
                    $this->rules ['variants.'.$key.'.coupon_price'] = ['required','numeric','gt:0'];
                }else{
                    $this->rules ['variants.'.$key.'.coupon_price'] = ['nullable','numeric','gt:0'];
                }
                $this->messages['variants.'.$key.'.coupon_price.required'] = 'This  field is requierd';
                $this->messages['variants.'.$key.'.coupon_price.numeric']  = 'Value must be numeric';
                $this->messages['variants.'.$key.'.coupon_price.gt']       = 'Value must be greater than or equal 0';
                if(request()->update_id){
                    $this->rules ['variants.'.$key.'.coupon_expiration_date'] = ['nullable','date','date_format:Y-m-d'];
                }else{
                    $this->rules ['variants.'.$key.'.coupon_expiration_date'] = ['nullable','date','date_format:Y-m-d','after_or_equal:'.date('Y-m-d')];
                }
                
                $this->messages['variants.'.$key.'.coupon_expiration_date.date']           = 'Value must be date';
                $this->messages['variants.'.$key.'.coupon_expiration_date.after_or_equal'] = 'Value must be a date after or equal to '.date('Y-m-d');
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
