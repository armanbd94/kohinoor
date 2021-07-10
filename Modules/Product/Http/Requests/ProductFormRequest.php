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
        $this->rules['product_name']      = ['required','string','unique:products,product_name'];
        $this->rules['type']              = ['required','integer'];
        $this->rules['product_image']     = ['nullable','image','mimes:png,jpg,jpeg'];
        $this->rules['category_id']       = ['required','integer'];
        $this->rules['tax_id']            = ['required','integer'];
        $this->rules['tax_method']        = ['required','integer'];
        $this->rules['description']       = ['nullable','string'];

        if(request()->update_id){
            $this->rules['product_name'][2] = 'unique:products,product_name,'.request()->update_id;
        }

        $collection = collect(request());
        if($collection->has('materials')){
            foreach (request()->materials as $key => $value) {
                $this->rules   ['materials.'.$key.'.id']           = ['required','integer'];

                $this->messages['materials.'.$key.'.id.required']  = 'The material name field is required';
                $this->messages['materials.'.$key.'.id.integer']   = 'The material name field value must be integer';
            }
        }

        if($collection->has('variants')){
            foreach (request()->variants as $key => $value) {
                $this->rules   ['variants.'.$key.'.size_id']           = ['required','integer'];
                $this->messages['variants.'.$key.'.size_id.required']  = 'The size field is required';
                $this->messages['variants.'.$key.'.size_id.integer']   = 'The size field value must be integer';

                $this->rules   ['variants.'.$key.'.code']              = ['required','min:8','max:13','string','unique:finish_goods,code'];
                if(request()->update_id){
                    if(isset($value['id'])){
                        $this->rules['variants.'.$key.'.code'][4] = 'unique:finish_goods,code,'.$value['id'];
                    }
                    
                }

                $this->messages['variants.'.$key.'.code.required']         = 'This field is required';
                $this->messages['variants.'.$key.'.code.min:8']            = 'Value length must be minimum 8';
                $this->messages['variants.'.$key.'.code.max:13']           = 'Value length must be maximum 13';
                $this->messages['variants.'.$key.'.code.string']           = 'Value must be string';
                $this->messages['variants.'.$key.'.code.unique']           = 'This value has alredy been taken. Try another';

                $this->rules    ['variants.'.$key.'.cost']                 = ['nullable','numeric','gte:0'];
                $this->messages['variants.'.$key.'.cost.numeric']          = 'Value must be numeric';
                $this->messages['variants.'.$key.'.cost.gte:0']            = 'Value must be greater than or equal 0';

                $this->rules    ['variants.'.$key.'.price']                = ['required','numeric','gt:0'];
                $this->messages['variants.'.$key.'.price.required']        = 'This field is required';
                $this->messages['variants.'.$key.'.price.numeric']         = 'Value must be numeric';
                $this->messages['variants.'.$key.'.price.gt:0']            = 'Value must be greater than or equal 0';

                $this->rules    ['variants.'.$key.'.unit_id']              = ['required','string'];
                $this->messages['variants.'.$key.'.unit_id.required']      = 'This field is required';
                $this->messages['variants.'.$key.'.unit_id.string']        = 'Value must be string';

                $this->rules    ['variants.'.$key.'.sale_unit_id']         = ['required','string'];
                $this->messages['variants.'.$key.'.sale_unit_id.required'] = 'This field is required';
                $this->messages['variants.'.$key.'.sale_unit_id.string']   = 'Value must be string';

                $this->rules    ['variants.'.$key.'.qty']                  = ['nullable','numeric','gte:0'];
                $this->messages['variants.'.$key.'.qty.required']          = 'This field is required';
                $this->messages['variants.'.$key.'.qty.numeric']           = 'Value must be numeric';
                $this->messages['variants.'.$key.'.qty.gt:0']              = 'Value must be greater than or equal 0';

                $this->rules    ['variants.'.$key.'.alert_qty']            = ['nullable','numeric','gte:0'];
                $this->messages['variants.'.$key.'.alert_qty.numeric']     = 'Value must be numeric';
                $this->messages['variants.'.$key.'.alert_qty.gt:0']        = 'Value must be greater than or equal 0';
                
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
