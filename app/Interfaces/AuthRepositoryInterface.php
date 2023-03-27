<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;

interface AuthRepositoryInterface {
    public function checkCredentials(array $credentials) : Model|NULL;

    public function generateToken(Model &$user) : String;
}
