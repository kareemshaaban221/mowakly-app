<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ScheduleUpdateRequest extends ValidationRulesRequest
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
        parent::checkEmailRule();
        return [
            'email' => parent::emailRule(),
            'title' => parent::titleRule(update: true),
            'description' => parent::descriptionRule(update: true, min: 3)
        ];
    }
}
