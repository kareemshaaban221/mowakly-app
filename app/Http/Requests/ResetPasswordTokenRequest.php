<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ResetPasswordTokenRequest extends ValidationRulesRequest
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
        return [
            'email' => parent::emailRule(exists: $_REQUEST['user_type'] . 's'),
            'code' => 'required|string|exists:password_resets,code'
        ];
    }
}
