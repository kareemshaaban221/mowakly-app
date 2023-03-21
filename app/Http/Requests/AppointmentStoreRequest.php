<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AppointmentStoreRequest extends ValidationRulesRequest
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
            'email' => parent::emailRule(),
            'subject' => 'required|string|min:3|max:255',
            'from' => parent::dateOfBirthRule(),
            'to' => parent::dateOfBirthRule(from: request()->from)
        ];
    }
}
