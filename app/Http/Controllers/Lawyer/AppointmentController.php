<?php

namespace App\Http\Controllers\Lawyer;

use App\Http\Controllers\AppointmentController as ControllersAppointmentController;
use App\Http\Controllers\Controller;
use App\Http\Requests\AppointmentStoreRequest;
use App\Http\Requests\AppointmentUpdateRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\AppointmentRepositoryInterface;
use Illuminate\Http\Request;

class AppointmentController extends Controller
{
    private ControllersAppointmentController $appointmentController;
    private EmailAuthOrGivenRequest $request;

    public function __construct(AppointmentRepositoryInterface $appointmentRepository) {
        $this->appointmentController = new ControllersAppointmentController($appointmentRepository);
        $this->request = new EmailAuthOrGivenRequest;
    }

    public function index() {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->appointmentController->index($this->request);
    }

    public function store(AppointmentStoreRequest $request, $schedule_id) {
        return $this->appointmentController->store($request, $schedule_id);
    }

    public function update(AppointmentUpdateRequest $request, $appointment_id) {
        return $this->appointmentController->update($request, $appointment_id);
    }

    public function show($appointment_id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->appointmentController->show($this->request, $appointment_id);
    }

    public function destroy($appointment_id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->appointmentController->destroy($this->request, $appointment_id);
    }
}
