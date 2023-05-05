<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;

class ArticleUpdateRequest extends ValidationRulesRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return Auth::check();
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
            'email' => parent::emailRule(exists: 'lawyers'),
            'title' => parent::titleRule(update: true),
            'body' => parent::descriptionRule(update: true),
            'image' => parent::imageRule(update: true)
        ];
    }
}
