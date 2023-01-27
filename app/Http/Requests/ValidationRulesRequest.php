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
        ;
    }
}
