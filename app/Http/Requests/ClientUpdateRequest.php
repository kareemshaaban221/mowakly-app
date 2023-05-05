<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ClientUpdateRequest extends ValidationRulesRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return parent::authorizeRule('client');
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
            'fname' => parent::nameRule(update: true),
            'lname' => parent::nameRule(update: true),
            'email' => parent::emailRule(update: true, exists: 'clients'),
            // 'password' => parent::passwordRule('update'),
            'gender' => parent::genderRule(update: true),
            'date_of_birth' => parent::dateOfBirthRule(update: true),
            'avatar' => parent::imageRule(update: true),
            'phone' => parent::phoneRule(update: true),
            'payment_methods.*' => parent::paymentMethodRule(update: true),
        ];
    }
}
