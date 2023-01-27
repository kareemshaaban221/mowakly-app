<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Password;

class LawyerRegisterRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return request()->user_type == 'lawyer';
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */

    public $validator = NULL;
    protected function failedValidation(\Illuminate\Contracts\Validation\Validator $validator)
    {
        $this->validator = $validator;
    }

    public function rules()
    {
        return [
            'fname' => 'required|min:3|max:255|alpha',
            'lname' => 'required|min:3|max:255|alpha',
            'email' => 'required|email|unique:lawyers,email',
            'password' => [
                'required',
                'confirmed',
                Password::min(8)
                    ->letters()
                    ->mixedCase()
                    ->numbers()
                    ->symbols()
                    ->uncompromised()
            ],
            'gender' => 'required|in:male,female',
            'description' => 'required|min:50|max:255',
            'date_of_birth' => 'required|date',
            'card' => 'required|mimes:png,jpg||max:5000',
            'card_id' => 'required|max:20',
            'avatar' => 'required|mimes:png,jpg|max:5000',
            'chat_price' => 'required|numeric|between:0,9999.99',
            'video_price' => 'required|numeric|between:0,9999.99',
            'phone_price' => 'required|numeric|between:0,9999.99',
            'attachments' => 'required',
            'attachments.*' => 'required|file|max:5000|mimes:pdf,csv,xls,xlsx,doc,docx,txt,pptx',
            'phones' => 'required',
            'phones.*' => 'digits:10|regex:/1[5210]\d{8}/u'
        ];
    }
}
