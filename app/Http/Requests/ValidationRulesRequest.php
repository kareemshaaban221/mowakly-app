<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rules\Password;

class ValidationRulesRequest extends FormRequest
{
    public function authorizeRule($user_type)
    {
        return request()->user_type = $user_type;
    }

    public $validator = NULL;
    protected function failedValidation(\Illuminate\Contracts\Validation\Validator $validator)
    {
        $this->validator = $validator;
    }

    protected function nameRule(Int $min = 3, Int $max = 255, String $regex = '/\w/u') {
        return ['required', 'min:' . $min, 'max:' . $max, 'alpha', 'regex:' . $regex];
    }

    protected function emailRule() {
        return ['required', 'email', 'max:255'];
    }

    protected function passwordRule($case) {
        $rules = ['required'];
        if($case == 'login') {
            array_push($rules, Password::min(8));
        } else if($case == 'register') {
            $rules = array_merge($rules, [
                'confirmed',
                Password::min(8)
                    ->letters()
                    ->mixedCase()
                    ->numbers()
                    ->symbols()
                    ->uncompromised()
            ]);
        }

        return $rules;
    }

    protected function genderRule() {
        return ['required', 'in:male,female'];
    }

    protected function descriptionRule() {
        return ['required', 'min:50', 'max:255'];
    }

    protected function dateOfBirthRule(String $format = 'Y-m-d') {
        return ['required', 'date', 'date_format:' . $format];
    }

    protected function avatarRule(String $mimes = 'png,jpg,jpeg', Int $max = 5000) {
        return ['file', 'mimes:' . $mimes, 'max:' . $max];
    }

    protected function phoneRule(Int $digits = 10, String $regex = '/1[5210]\d{8}/u') {
        return ['required', 'digits:' . $digits, 'regex:' . $regex];
    }

    protected function paymentMethodRule(Int $min = 3, Int $max = 255) {
        return ['required', 'string', 'min:' . $min, 'max:' . $max];
    }

    protected function cardRule(String $mimes = 'png,jpg,jpeg', Int $max = 5000) {
        return ['required', 'file', 'mimes:' . $mimes, 'max:' . $max];
    }

    protected function cardIdRule(Int $digits = 20) {
        return ['required', 'numeric', 'digits_between:0,' . $digits];
    }

    protected function attachmentRule(String $mimes = 'pdf,csv,xls,xlsx,doc,docx,txt,pptx', $max = 5000) {
        return ['required', 'file', 'mimes:' . $mimes, 'max:' . $max];
    }

    protected function priceRule(Float $min = 0, Float $max = 9999.99) {
        return ['required', 'numeric', 'between:' . $min . ',' . $max];
    }

    public function messages() {
        return [
            'email.exists' => 'The email doesn\'t exist.'
        ];
    }
}
