<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\AppointmentRepositoryInterface;
use App\Models\Appointment;

class AppointmentController extends Controller
{
    private AppointmentRepositoryInterface $scheduleRepository;
    private Response $response;

    public function __construct(AppointmentRepositoryInterface $scheduleRepository) {
        $this->response = new Response;
        $this->scheduleRepository = $scheduleRepository;
    }

    public function index(EmailAuthOrGivenRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        try {

            return $this->response->ok([
                'data' => Appointment::with('schedule')->all(),
                'message' => 'All Appointments!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store() {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();
            $schedule = $this->scheduleRepository->store($request, $lawyer);

            $schedule->save();

            DB::commit();

            return $this->response->ok([
                'data' => $schedule->toarray(),
                'message' => 'Consultation relation was added successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function show() {

    }

    public function destroy() {

    }
}
