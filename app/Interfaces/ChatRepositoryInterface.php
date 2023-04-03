<?php

namespace App\Interfaces;

use App\Models\Client;
use App\Models\Lawyer;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

interface ChatRepositoryInterface {

    public function store(Request $request, Model $from, Model $to);

    public function storeFromLawyer(Request $request, Lawyer $from, Client $to);

    public function storeFromClient(Request $request, Client $from, Lawyer $to);

}
