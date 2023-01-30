<?php

namespace App\Http\Requests;

// use Illuminate\Foundation\Http\FormRequest;
// use Illuminate\Validation\Rules\Password;

class ClientRegisterRequest extends ValidationRulesRequest
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
        return [
            'fname' => parent::nameRule(),
            'lname' => parent::nameRule(),
            'email' => array_merge(['unique:clients,email'], parent::emailRule()),
            'password' => parent::passwordRule('register'),
            'gender' => parent::genderRule(),
            'date_of_birth' => parent::dateOfBirthRule(),
            'avatar' => parent::avatarRule(),
            'phone' => parent::phoneRule(),
            'payment_methods.*' => parent::paymentMethodRule(),
        ];
    }
}
