<?php

namespace App\Http\Controllers\Lawyer;

use App\Http\Requests\AttachmentDestroyRequest;
use App\Http\Requests\AttachmentStoreRequest;
use App\Http\Requests\LawyerUpdateRequest;
use App\Http\Requests\PhoneStoreRequest;
use App\Repositories\AttachmentRepository;
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
        return (new AttachmentController(new AttachmentRepository))->store($request);
    }

    public function destroyAttachment(AttachmentDestroyRequest $request) {
        return (new AttachmentController(new AttachmentRepository))->destroy($request);
    }

    public function addPhone(PhoneStoreRequest $request) {
        return (new PhoneController(new LawyerRepository(new AttachmentRepository)))->store($request);
    }

    public function destroyPhone(PhoneStoreRequest $request) {
        return (new PhoneController(new LawyerRepository(new AttachmentRepository)))->destroy($request);
    }
}
