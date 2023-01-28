<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;

interface AuthRepositoryInterface {
    public function checkCredentials(array $credentials) : Model;

    public function generateToken(Model &$user) : String;
}
