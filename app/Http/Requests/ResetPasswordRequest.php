<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ResetPasswordRequest extends ValidationRulesRequest
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
        // dd(parent::passwordRule(case: 'update'));
        return [
            'email' => parent::emailRule(exists: $_REQUEST['user_type'] . 's'),
            'new_password' => parent::passwordRule(case: 'update'),
        ];
    }
}
