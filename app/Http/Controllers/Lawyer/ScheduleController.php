<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Controllers\ScheduleController as ControllersScheduleController;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\ScheduleStoreRequest;
use App\Http\Requests\ScheduleUpdateRequest;
use App\Interfaces\ScheduleRepositoryInterface;

class ScheduleController extends Controller
{
    private ScheduleRepositoryInterface $scheduleRepository;
    private Response $response;
    private ControllersScheduleController $scheduleController;
    private EmailAuthOrGivenRequest $request;

    public function __construct(ScheduleRepositoryInterface $scheduleRepository) {
        $this->response = new Response;
        $this->scheduleRepository = $scheduleRepository;
        $this->scheduleController = new ControllersScheduleController($this->scheduleRepository);
        $this->request = new EmailAuthOrGivenRequest;
    }

    public function index() {
        $this->request->email = auth()->user()->email;
        return $this->scheduleController->showByUserEmail($this->request);
    }

    public function store(ScheduleStoreRequest $request) {
        return $this->scheduleController->store($request);
    }

    public function show($id) {
        $this->request->email = auth()->user()->email;
        return $this->scheduleController->show($this->request, $id);
    }

    public function update(ScheduleUpdateRequest $request, $id) {
        return $this->scheduleController->update($request, $id);
    }

    public function destroy($id) {
        $this->request->email = auth()->user()->email;
        return $this->scheduleController->destory($this->request, $id);
    }
}
