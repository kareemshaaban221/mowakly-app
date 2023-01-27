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
            'fname' => 'required|min:3|max:255|alpha',
            'lname' => 'required|min:3|max:255|alpha',
            'email' => array_merge(['unique:clients,email'], parent::emailRule()),
            'password' => parent::passwordRule('register'),
            'gender' => 'required|in:male,female',
            'date_of_birth' => 'required|date',
            'avatar' => 'file|mimes:png,jpg|max:5000',
            'phone' => 'required|digits:10|regex:/1[5210]\d{8}/u'
        ];
    }
}
