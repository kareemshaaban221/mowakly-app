<?php

namespace App\Repositories;
use App\Interfaces\AppointmentRepositoryInterface;
use App\Models\Appointment;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class AppointmentRepository implements AppointmentRepositoryInterface {

    public function store(Request $request, Model &$schedule) {
        $appointment = new Appointment;

        $appointment->subject = $request->subject;
        $appointment->from = $request->from;
        $appointment->to = $request->to;
        $appointment->schedule_id = $schedule->id;

        return $appointment;
    }

    public function update(Request $request, Model &$appointment) {
        $appointment->subject = $request->has('subject') ? $request->subject : $appointment->subject;
        $appointment->from = $request->has('from') ? $request->from : $appointment->from;
        $appointment->to = $request->has('to') ? $request->to : $appointment->to;

        return $appointment;
    }

    public function delete($id, Model &$lawyer) {
        $appointment = Appointment::find($id);

        if($appointment->schedule->lawyer_id == $lawyer->id) {
            $appointment->delete();
            return $appointment;
        }

        return -1;
    }

}
