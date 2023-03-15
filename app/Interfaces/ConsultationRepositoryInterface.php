<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

interface ConsultationRepositoryInterface {
    public function store(Request $request, Model &$client, Model &$lawyer);

    public function update(Request $request, Model &$consultation);

    public function showByEmail(Request $request);
}
