<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class LawyerCategoryDetailsRequest extends ValidationRulesRequest
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
        parent::checkEmailRule();
        return [
            'categories' => 'required',
            'categories.*.mean_of_consultation' => parent::meansRule(),
            'categories.*.category_name' => parent::categoryRule(exists: true),
            'prices' => 'required',
            'prices.*' => parent::priceRule(),
            'email' => parent::emailRule(exists: 'lawyers'),
        ];
    }
}
