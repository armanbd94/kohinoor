<?php

namespace App\Http\Requests;

use Illuminate\Validation\Rule;
use App\Http\Requests\FormRequest;


class CategoryFormRequest extends FormRequest
{

    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        $rules['name'] = ['required','string',Rule::unique('categories')->where(function($query) {
                                                $query->where('name', '=', request()->name)->where('type',request()->type);
                                                })
                        ];
        if(request()->update_id)
        {
            $rules['name'][2] = Rule::unique('categories')->where(function($query) {
                $query->where('name', '=', request()->name)->where('id', '!=', request()->update_id)->where('type',request()->type);
                });
        }

        return $rules;
    }
}
