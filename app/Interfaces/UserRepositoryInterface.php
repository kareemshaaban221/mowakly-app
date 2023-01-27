<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;

interface UserRepositoryInterface {
    public function store() : Model;

    public function storeAvatar(Model $user) : bool;
}
