<?php

namespace App\Http\Controllers\Client;

use App\Helpers\Response;
use App\Http\Controllers\ConsultationController as ControllersConsultationController;
use App\Http\Controllers\Controller;
use App\Http\Requests\ConsultationStoreRequest;
use App\Http\Requests\ConsultationUpdateRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\ConsultationRepositoryInterface;
use Illuminate\Http\Request;

class ConsultationController extends Controller
{
    private Response $response;
    private ConsultationRepositoryInterface $consultationRepository;
    private ControllersConsultationController $consultationController;
    private EmailAuthOrGivenRequest $request;

    public function __construct(ConsultationRepositoryInterface $consultationRepository) {
        $this->response = new Response;
        $this->consultationRepository = $consultationRepository;
        $this->consultationController = new ControllersConsultationController($this->consultationRepository);
        $this->request = new EmailAuthOrGivenRequest;
    }

    public function index() {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->consultationController->showByUserEmail($this->request);
    }

    public function store(ConsultationStoreRequest $request) {
        return $this->consultationController->store($request);
    }

    public function update(ConsultationUpdateRequest $request, $id) {
        return $this->consultationController->update($request, $id);
    }

    public function show($id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->consultationController->show($this->request, $id);
    }


    // public function destroy($id) {
    //     // No destroy method for this object
    //     // return $this->consultationController->destroy($this->request, $id);
    // }
}
