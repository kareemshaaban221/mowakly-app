<?php

namespace App\Repositories;
use App\Interfaces\AppointmentRepositoryInterface;
use App\Models\Appointment;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class AppointmentRepository implements AppointmentRepositoryInterface {

    public function store(Request $request, Model &$schedule) {
        if(! $this->validateAppointment($request, $schedule->lawyer->appointments))
            return -1;

        $appointment = new Appointment;

        $appointment->subject = $request->subject;
        $appointment->from = $request->from;
        $appointment->to = $request->to;
        $appointment->schedule_id = $schedule->id;

        return $appointment;
    }

    public function update(Request $request, Model &$appointment) {
        $appointment->subject = $request->has('subject') ? $request->subject : $appointment->subject;
        if($request->has('from')) {
            if(strtotime(date('Y-m-d', strtotime($appointment->from))) <= strtotime(now()->today()->toDateString()))
                return -2;
            if(! $this->validateAppointment($request, $appointment->lawyer()->appointments))
                return -1;

            $appointment->from = $request->from;
            $appointment->to = $request->to;
        }

        return $appointment;
    }

    public function delete($id, Model &$lawyer) {
        $appointment = Appointment::find($id);

        if($appointment->lawyer()->id == $lawyer->id) {
            $appointment->delete();
            return $appointment;
        }

        return -1;
    }

    private function validateAppointment($request, $appointments) {
        $from = Carbon::createFromFormat('Y-m-d H:i', $request->from);
        $to = Carbon::createFromFormat('Y-m-d H:i', $request->to);
        foreach($appointments as $appointment) {
            $ffrom = Carbon::createFromFormat('Y-m-d H:i:s', $appointment->from);
            $tto = Carbon::createFromFormat('Y-m-d H:i:s', $appointment->to);
            if ($to->between($ffrom, $tto) || $from->between($ffrom, $tto)) {
                return false;
            }
        }

        return true;
    }
}
