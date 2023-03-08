<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SubcategoryStoreRequest extends ValidationRulesRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        // TODO: Admin Auth
        return [
            'subcategories' => 'required',
            'subcategories.*.subcategory' => array_merge(parent::categoryRule('subcategories', true), ['distinct']),
            'subcategories.*.parent_category' => parent::categoryRule(exists: true),
        ];
    }
}
