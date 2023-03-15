<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class LawyerUpdateRequest extends ValidationRulesRequest
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

    public $validator = NULL;
    protected function failedValidation(\Illuminate\Contracts\Validation\Validator $validator)
    {
        $this->validator = $validator;
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
            'fname' => parent::nameRule(update: true),
            'lname' => parent::nameRule(update: true),
            'email' => parent::emailRule(update: true, exists: 'lawyers'),
            // 'password' => parent::passwordRule('update', update: true),
            'gender' => parent::genderRule(update: true),
            'description' => parent::descriptionRule(update: true),
            'date_of_birth' => parent::dateOfBirthRule(update: true),
            'card' => parent::cardRule(update: true),
            'card_id' => parent::cardIdRule(update: true),
            'avatar' => parent::avatarRule(),
            'national_id' => parent::nationalIdRule(update: true),
            // 'chat_price' => parent::priceRule(update: true),
            // 'video_price' => parent::priceRule(update: true),
            // 'phone_price' => parent::priceRule(update: true),
            // 'attachments.*' => parent::attachmentRule(update: true),
            // 'phones.*' => parent::phoneRule(update: true),
        ];
    }
}
