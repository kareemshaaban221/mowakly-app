<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ScheduleStoreRequest extends ValidationRulesRequest
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
            'title' => parent::titleRule(),
            'description' => parent::descriptionRule(min: 3)
        ];
    }
}
