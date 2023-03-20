<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Interfaces\ScheduleRepositoryInterface;

class ScheduleController extends Controller
{
    private ScheduleRepositoryInterface $scheduleRepository;
    private Response $response;

    public function __construct(ScheduleRepositoryInterface $scheduleRepository) {
        $this->response = new Response;
        $this->scheduleRepository = $scheduleRepository;
    }

    public function index() {
        try {

            $schedules = $this->scheduleRepository->findByLawyerId(auth()->user()->id);

            if(!$schedules) {
                return $this->response->badRequest('No schedules found!');
            }

            return $this->response->ok([
                'data' => $schedules,
                'message' => 'All Schedules!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
