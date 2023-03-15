<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ConsultationStoreRequest extends ValidationRulesRequest
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
            'email' => parent::emailRule(exists: 'clients'),
            'main_category' => parent::categoryRule(exists: true),
            'lawyer_email' => parent::emailRule(exists: 'lawyers'),
            'mean_of_consultation' => parent::meansRule(),
            'review' => 'string|min:10|max:255',
            'rating' => 'numeric|min:0|max:5',
        ];
    }
}
