<?php

namespace App\Repositories;
use App\Interfaces\ScheduleRepositoryInterface;
use App\Models\Schedule;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class ScheduleRepository implements ScheduleRepositoryInterface {

	public function store(Request $request, Model &$lawyer) {
        $schedule = new Schedule;

        $schedule->title = $request->title;
        $schedule->description = $request->description;
        $schedule->lawyer_id = $lawyer->id;

        return $schedule;
	}

	public function update(Request $request, Model &$schedule) {
        $schedule->title = $request->has('title') ? $request->title : $schedule->title;
        $schedule->description = $request->has('description') ? $request->description : $schedule->description;

        return $schedule;
	}

    public function delete($id, Model &$lawyer) {
        $schedule = Schedule::find($id);

        if($schedule->lawyer_id == $lawyer->id) {
            $schedule->delete();
            return $schedule;
        }

        return -1;
    }

    public function findByLawyerId($lawyer_id) {
        return Schedule::where('lawyer_id', $lawyer_id)->get();
    }
}
