<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\ScheduleStoreRequest;
use App\Http\Requests\ScheduleUpdateRequest;
use App\Interfaces\ScheduleRepositoryInterface;
use App\Models\Lawyer;
use App\Models\Schedule;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class ScheduleController extends Controller
{
    private ScheduleRepositoryInterface $scheduleRepository;
    private Response $response;

    public function __construct(ScheduleRepositoryInterface $scheduleRepository) {
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
                'data' => Schedule::all(),
                'message' => 'All Schedules!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store(ScheduleStoreRequest $request) {
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

    public function update(ScheduleUpdateRequest $request, $id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $schedule = Schedule::with('lawyer')->find($id);

            if(!$schedule) {
                return $this->response->badRequest('Data is not valid!', ['id' => 'Schedule record with this id is not found!']);
            } else if ($schedule->lawyer->email != $request->email) {
                return $this->response->notAuthorized('This lawyer wasn\'t authorized to update this record!');
            }

            $schedule = $this->scheduleRepository->update($request, $schedule);

            $schedule->save();

            DB::commit();

            return $this->response->ok([
                'data' => $schedule,
                'message' => 'Schedule was updated successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function show(EmailAuthOrGivenRequest $request, $id) {

        try {
            $schedule = Schedule::with('lawyer')->find($id);

            if(!$schedule) {
                return $this->response->badRequest('Data is not valid!', ['id' => 'Schedule record with this ID is not found!']);
            } else if ($schedule->lawyer->email != $request->email) {
                return $this->response->notAuthorized('This lawyer wasn\'t authorized to access this record!');
            }

            return $this->response->ok([
                'data' => $schedule,
                'message' => 'Schedule by ID!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function showByUserEmail(EmailAuthOrGivenRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        try {

            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();
            $schedules = $this->scheduleRepository->findByLawyerId($lawyer->id);

            if(!$schedules) {
                return $this->response->badRequest('No schedules found!');
            }

            return $this->response->ok([
                'data' => $schedules->toarray(),
                'message' => 'Schedules owned by this lawyer!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function destory(EmailAuthOrGivenRequest $request, $id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        try {

            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();

            $schedule = $this->scheduleRepository->delete($id, $lawyer);

            if(is_int($schedule) && $schedule == -1) {
                return $this->response->notAuthorized('This lawyer wasn\'t authorized to delete this record!');
            }

            return $this->response->ok([
                'data' => $schedule,
                'message' => 'Schedule was deleted by ID!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
