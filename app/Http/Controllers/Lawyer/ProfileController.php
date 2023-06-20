<?php

namespace App\Http\Controllers\Lawyer;

use App\Http\Controllers\AttachmentController;
use App\Http\Controllers\ConsultationController;
use App\Http\Controllers\Controller;
use App\Http\Controllers\LawyerController;
use App\Http\Requests\AttachmentStoreRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\LawyerUpdateRequest;
use App\Http\Requests\PhoneStoreRequest;
use App\Interfaces\AttachmentRepositoryInterface;
use App\Interfaces\ConsultationRepositoryInterface;
use App\Interfaces\LawyerRepositoryInterface;

class ProfileController extends Controller
{

    private AttachmentController $attachmentController;
    private PhoneController $phoneController;
    private EmailAuthOrGivenRequest $request;
    private LawyerController $lawyerController;
    private ConsultationRepositoryInterface $consultationRepository;
    private ConsultationController $consultationController;

    public function __construct(AttachmentRepositoryInterface $attachmentRepository, LawyerRepositoryInterface $lawyerRepository, ConsultationRepositoryInterface $consultationRepository) {
        $this->attachmentController = new AttachmentController($attachmentRepository);
        $this->phoneController = new PhoneController($lawyerRepository);
        $this->request = new EmailAuthOrGivenRequest;
        $this->lawyerController = new LawyerController($lawyerRepository, $attachmentRepository);
        $this->consultationRepository = $consultationRepository;
        $this->consultationController = new ConsultationController($this->consultationRepository);
    }

    public function getAllConsultations() {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->consultationController->index($this->request);
    }

    public function showConsultation($id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->consultationController->show($this->request, $id);
    }

    public function index() {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerController->show($this->request);
    }

    public function update(LawyerUpdateRequest $request) {
        return $this->lawyerController->update($request);
    }

    public function addAttachment(AttachmentStoreRequest $request) {
        return $this->attachmentController->store($request);
    }

    public function destroyAttachment($filename) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->attachmentController->destroy($this->request, $filename);
    }

    public function addPhone(PhoneStoreRequest $request) {
        return $this->phoneController->store($request);
    }

    public function destroyPhone($phone) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->phoneController->destroy($this->request, $phone);
    }

    public function destroy() {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerController->destroy($this->request);
    }
}
