<?php

namespace Modules\Product\Http\Requests;

use App\Http\Requests\FormRequest;

class ProductFormRequest extends FormRequest
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
        $this->rules['name']        = ['required','string','unique:products,name'];
        if(empty(request()->update_id)){
            $this->rules['type']        = ['required'];
        }else{
            $this->rules['name'][2] = 'unique:products,name,'.request()->update_id;
        }
        $this->rules['product_type']      = ['required'];
        $this->rules['category_id']       = ['required'];
        $this->rules['barcode_symbology'] = ['required'];
        $this->rules['tax_id']            = ['nullable','numeric'];
        $this->rules['tax_method']        = ['required','numeric'];
        $this->rules['description']       = ['nullable','string'];
        $this->rules['image']             = ['nullable','image','mimes:png,jpg,jpeg,svg,webp'];
        if(request()->type == 1){
            if(request()->update_id){
                $this->rules['name'][2]        = 'unique:products,name,'.request()->update_id;
                $this->rules['code']           = ['required','string','unique:products,code,'.request()->update_id];
                
            }else{
                $this->rules['code'] = ['required','string','unique:products,code'];
            }
            $this->rules['base_unit_id']    = ['required'];
            $this->rules['unit_id']         = ['required'];
            $this->rules['alert_quantity']  = ['nullable','numeric','gte:0'];
            $this->rules['base_unit_mrp']   = ['required','numeric','gt:0'];
            $this->rules['base_unit_price'] = ['required','numeric','gt:0'];
            $this->rules['unit_mrp']        = ['required','numeric','gt:0'];
            $this->rules['unit_price']      = ['required','numeric','gt:0'];
            $this->messages['unit_id.required']      = 'The unit field is required';
            $this->messages['base_unit_id.required'] = 'The base unit field is required';
        }else{
            if(request()->has('attribute'))
            {
                foreach (request()->attribute as $key => $value) {
                    $this->rules['attribute.'.$key.'.id']    = ['required'];
                    $this->rules['attribute.'.$key.'.value'] = ['required'];
                    $this->messages['attribute.'.$key.'.qty.required']   = 'This field is required';
                    $this->messages['attribute.'.$key.'.value.required'] = 'This field is required';
                }
            }
            if(request()->has('variants'))
            {
                foreach (request()->variants as $key => $value) {
                    $this->rules['variants.'.$key.'.name']  = ['required'];
                    if(request()->update_id){
                        $this->rules['variants.'.$key.'.code']  = ['required','unique:product_variants,item_code,'.$value['id']];
                    }else{
                        $this->rules['variants.'.$key.'.code']  = ['required','unique:product_variants,item_code'];
                    }
                    $this->rules['variants.'.$key.'.item_base_unit_id']    = ['required'];
                    $this->rules['variants.'.$key.'.item_unit_id']         = ['required'];
                    $this->rules['variants.'.$key.'.alert_qty']            = ['nullable','numeric','gte:0'];
                    $this->rules['variants.'.$key.'.item_base_unit_mrp']   = ['required','numeric','gt:0'];
                    $this->rules['variants.'.$key.'.item_base_unit_price'] = ['required','numeric','gt:0'];
                    $this->rules['variants.'.$key.'.item_unit_mrp']        = ['required','numeric','gt:0'];
                    $this->rules['variants.'.$key.'.item_unit_price']      = ['required','numeric','gt:0'];

                    $this->messages['variants.'.$key.'.name.required']                 = 'This field is required';
                    $this->messages['variants.'.$key.'.code.required']                 = 'This field is required';
                    $this->messages['variants.'.$key.'.code.unique']                   = 'This code already used. Try another';
                    $this->messages['variants.'.$key.'.item_base_unit_id.required']    = 'This field is required';
                    $this->messages['variants.'.$key.'.item_unit_id.required']         = 'This field is required';
                    $this->messages['variants.'.$key.'.item_base_unit_mrp.required']   = 'This field is required';
                    $this->messages['variants.'.$key.'.item_base_unit_mrp.numeric']    = 'The value must be numeric';
                    $this->messages['variants.'.$key.'.item_base_unit_mrp.gt']         = 'The value must be greater than 0';
                    $this->messages['variants.'.$key.'.item_base_unit_price.required'] = 'This field is required';
                    $this->messages['variants.'.$key.'.item_base_unit_price.numeric']  = 'The value must be numeric';
                    $this->messages['variants.'.$key.'.item_base_unit_price.gt']       = 'The value must be greater than 0';
                    $this->messages['variants.'.$key.'.item_unit_mrp.required']        = 'This field is required';
                    $this->messages['variants.'.$key.'.item_unit_mrp.numeric']         = 'The value must be numeric';
                    $this->messages['variants.'.$key.'.item_unit_mrp.gt']              = 'The value must be greater than 0';
                    $this->messages['variants.'.$key.'.item_unit_price.required']      = 'This field is required';
                    $this->messages['variants.'.$key.'.item_unit_price.numeric']       = 'The value must be numeric';
                    $this->messages['variants.'.$key.'.item_unit_price.gt']            = 'The value must be greater than 0';
                    $this->messages['variants.'.$key.'.alert_qty.numeric']             = 'The value must be numeric';
                    $this->messages['variants.'.$key.'.alert_qty.gte']                 = 'The value must be greater than or equal 0';
                }
            }
        }
        $collection = collect(request());
        if($collection->has('materials')){
            foreach (request()->materials as $key => $value) {
                $this->rules   ['materials.'.$key.'.id']           = ['required','integer'];

                $this->messages['materials.'.$key.'.id.required']  = 'The material name field is required';
                $this->messages['materials.'.$key.'.id.integer']   = 'The material name field value must be integer';
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
