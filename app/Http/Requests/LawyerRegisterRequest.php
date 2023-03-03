<?php

namespace App\Http\Requests;

// use Illuminate\Foundation\Http\FormRequest;
// use Illuminate\Validation\Rules\Password;

class LawyerRegisterRequest extends ValidationRulesRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return parent::authorizeRule('lawyer');
    }

    public function rules()
    {
        return [
            'fname' => parent::nameRule(),
            'lname' => parent::nameRule(),
            'email' => array_merge(['unique:lawyers,email'], parent::emailRule()),
            'password' => parent::passwordRule('register'),
            'gender' => parent::genderRule(),
            'description' => parent::descriptionRule(),
            'date_of_birth' => parent::dateOfBirthRule(),
            'card' => parent::cardRule(),
            'card_id' => parent::cardIdRule(),
            'avatar' => array_merge(['required'], parent::avatarRule()),
            'national_id' => parent::nationalIdRule(),
            'attachments' => 'required',
            'attachments.*' => parent::attachmentRule(),
            'phones' => 'required',
            'phones.*' => parent::phoneRule(),
            // 'subcategories' => 'exists:subcategories,name',
            // 'subcategories.*' => parent::subcategoryRule(),
        ];
    }
}
