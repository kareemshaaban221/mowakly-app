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

    protected function nameRule(Int $min = 3, Int $max = 255, String $regex = '/\w/u', $update = false) {
        if ($update) {
            return ['min:' . $min, 'max:' . $max, 'alpha', 'regex:' . $regex];
        }

        return ['required', 'min:' . $min, 'max:' . $max, 'alpha', 'regex:' . $regex];
    }

    protected function emailRule($update = false) {
        if ($update) {
            return ['email', 'max:255'];
        }

        return ['required', 'email', 'max:255'];
    }

    protected function passwordRule($case, $update = false) {
        $rules = $update ? [] : ['required'];
        if($case == 'login') {
            array_push($rules, Password::min(8));
        } else if($case == 'register' || $case == 'update') {
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

    protected function genderRule($update = false) {
        if ($update) {
            return ['in:male,female'];
        }

        return ['required', 'in:male,female'];
    }

    protected function descriptionRule($update = false) {
        if ($update) {
            return ['min:50', 'max:255'];
        }

        return ['required', 'min:50', 'max:255'];
    }

    protected function dateOfBirthRule(String $format = 'Y-m-d', $update = false) {
        if ($update) {
            return ['date', 'date_format:' . $format];
        }

        return ['required', 'date', 'date_format:' . $format];
    }

    protected function avatarRule(String $mimes = 'png,jpg,jpeg', Int $max = 5000) {
        return ['file', 'mimes:' . $mimes, 'max:' . $max];
    }

    protected function phoneRule(Int $digits = 10, String $regex = '/1[5210]\d{8}/u', $update = false) {
        if ($update) {
            return ['digits:' . $digits, 'regex:' . $regex];
        }

        return ['required', 'digits:' . $digits, 'regex:' . $regex];
    }

    protected function paymentMethodRule(Int $min = 3, Int $max = 255, $update = false) {
        if ($update) {
            return ['string', 'min:' . $min, 'max:' . $max];
        }

        return ['required', 'string', 'min:' . $min, 'max:' . $max];
    }

    protected function cardRule(String $mimes = 'png,jpg,jpeg', Int $max = 5000, $update = false) {
        if ($update) {
            return ['file', 'mimes:' . $mimes, 'max:' . $max];
        }

        return ['required', 'file', 'mimes:' . $mimes, 'max:' . $max];
    }

    protected function cardIdRule(Int $digits = 20, $update = false) {
        if ($update) {
            return ['numeric', 'digits_between:0,' . $digits];
        }

        return ['required', 'numeric', 'digits_between:0,' . $digits];
    }

    protected function attachmentRule(String $mimes = 'pdf,csv,xls,xlsx,doc,docx,txt,pptx', $max = 5000, $update = false) {
        if ($update) {
            return ['file', 'mimes:' . $mimes, 'max:' . $max];
        }

        return ['required', 'file', 'mimes:' . $mimes, 'max:' . $max];
    }

    protected function priceRule(Float $min = 0, Float $max = 9999.99, $update = false) {
        if ($update) {
            return ['numeric', 'between:' . $min . ',' . $max];
        }

        return ['required', 'numeric', 'between:' . $min . ',' . $max];
    }

    protected function categoryRule($table = 'main_categories', $store = false, $exists = false) {
        $rules = ['required', 'string'];

        if($store) array_push($rules, 'min:3', "unique:$table,name");

        if($exists) array_push($rules, "exists:$table,name");


        // dd($rules);
        return $rules;
    }

    protected function subcategoryRule($store = false) {
        return ['required', 'string'];
    }

    protected function meansRule($store = false) {
        return ['required', 'in:call,chat,appointment'];
    }

    protected function nationalIdRule(Int $digits = 14, String $regex = '/\d{14}/u', $update = false) {
        if ($update) {
            return ['digits:' . $digits, 'regex:' . $regex];
        }

        return ['required', 'digits:' . $digits, 'regex:' . $regex];
    }

    protected function checkEmailRule() {
        if(auth()->check() && !$this->request->has('email'))
            $this->request->set('email', auth()->user()->email);
    }

    public function messages() {
        return [
            'email.exists' => 'The email doesn\'t exist.',
            'filename.exists' => 'The file does\'t exist.',
            'categories.exists' => 'The category does\'t exist.',
            'subcategoies.exists' => 'The subcategory does\'t exist.',
        ];
    }
}
