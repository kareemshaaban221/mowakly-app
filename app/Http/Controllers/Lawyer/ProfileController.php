<?php

namespace App\Http\Controllers\Lawyer;

use App\Http\Controllers\Controller;
use App\Http\Requests\AttachmentDestroyRequest;
use App\Http\Requests\AttachmentStoreRequest;
use App\Http\Requests\LawyerUpdateRequest;
use App\Repositories\LawyerRepository;

class ProfileController extends LawyerController
{
    public function showProfile() {
        return parent::show(auth()->user()->email);
    }

    public function updateProfile(LawyerUpdateRequest $request) {
        return parent::update($request, auth()->user()->email);
    }

    public function addAttachment(AttachmentStoreRequest $request) {
        return (new AttachmentController(new LawyerRepository))->store(auth()->user()->email, $request);
    }

    public function destroyAttachment(AttachmentDestroyRequest $request) {
        return (new AttachmentController(new LawyerRepository))->destroy(auth()->user()->email, $request);
    }
}
