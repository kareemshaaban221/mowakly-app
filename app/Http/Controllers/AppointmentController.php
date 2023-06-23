<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Requests\AppointmentStoreRequest;
use App\Http\Requests\AppointmentUpdateRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\AppointmentRepositoryInterface;
use App\Models\Appointment;
use App\Models\Lawyer;
use App\Models\Schedule;
use Illuminate\Support\Facades\DB;

class AppointmentController extends Controller
{
    private AppointmentRepositoryInterface $appointmentRepository;
    private Response $response;

    public function __construct(AppointmentRepositoryInterface $appointmentRepository) {
        $this->response = new Response;
        $this->appointmentRepository = $appointmentRepository;
    }

    public function index(EmailAuthOrGivenRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        try {
            $lawyer = Lawyer::where('email', $request->email)->first();

            return $this->response->ok([
                'data' => $lawyer->appointments,
                'message' => 'All Lawyer Appointments!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store(AppointmentStoreRequest $request, $schedule_id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $schedule = Schedule::find($schedule_id);

            if (!$schedule)
                return $this->response->notFound(obj: 'schedule');
            
            if($schedule->lawyer->email != $request->email) {
                return $this->response->notAuthorized('Not authorized to use this schedule_id!');
            }

            $appointment = $this->appointmentRepository->store($request, $schedule);

            if(is_int($appointment) && $appointment == -1) {
                return $this->response->badRequest('From & To dates is invalid!', ['date' => 'date mustn\'t conflict with other lawyer appointment!']);
            }

            $appointment->save();

            DB::commit();

            return $this->response->created(['data' => $appointment->toarray()], 'appointment');

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function update(AppointmentUpdateRequest $request, $appointment_id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $appointment = Appointment::find($appointment_id);
            if(!$appointment) {
                return $this->response->badRequest('This appointment is not found!');
            }

            if($appointment->lawyer()->email != $request->email) {
                $this->response->notAuthorized('Not authorized to access this appointment!');
            }

            $appointment = $this->appointmentRepository->update($request, $appointment);

            if(is_int($appointment) && $appointment == -2) {
                return $this->response->badRequest('It is not allowed to update an appointment on same or previous day!');
            }

            if(is_int($appointment) && $appointment == -1) {
                return $this->response->badRequest('From & To dates is invalid!', ['date' => 'date mustn\'t conflict with other lawyer appointment!']);
            }

            $appointment->save();

            DB::commit();

            return $this->response->ok([
                'data' => $appointment->toarray(),
                'message' => 'Appointment has been updated successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function show(EmailAuthOrGivenRequest $request, $appointment_id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        try {

            $appointment = Appointment::with('schedule')->find($appointment_id);
            if(!$appointment) {
                return $this->response->badRequest('This appointment is not found!');
            }

            if($appointment->lawyer()->email != $request->email) {
                $this->response->notAuthorized('Not authorized to access this appointment!');
            }

            return $this->response->ok([
                'data' => array_merge($appointment->toarray(), [
                    'lawyer' => $appointment->lawyer(),
                    'clients' => $appointment->schedule->clients
                ]),
                'message' => 'Appointment By ID!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function destroy(EmailAuthOrGivenRequest $request, $appointment_id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $appointment = Appointment::find($appointment_id);
            if(!$appointment) {
                return $this->response->badRequest('This appointment is not found!');
            }

            if($appointment->lawyer()->email != $request->email) {
                $this->response->notAuthorized('Not authorized to delete this appointment!');
            }

            $appointment->delete();

            DB::commit();

            return $this->response->ok([
                'data' => $appointment->toarray(),
                'message' => 'Appointment has been deleted successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
