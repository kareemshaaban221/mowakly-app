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
        if(auth()->check())
            $this->request->set('email', auth()->user()->email);
        return [
            'price_of_consultation' => parent::priceRule(),
            'mean_of_consultation' => parent::MeansRule(),
            'email' => parent::emailRule(),
            'category' => parent::categoryRule(exists: true),
        ];
    }
}
