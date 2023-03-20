<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

interface ScheduleRepositoryInterface {
    public function store(Request $request, Model &$user);
    public function update(Request $request, Model &$schedule);

    public function delete($id, Model &$user);

    public function findByLawyerId($lawyer_id);
}
