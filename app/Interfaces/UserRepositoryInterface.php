<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

interface UserRepositoryInterface extends AuthRepositoryInterface, SocialiteAuthRepositoryInterface {
    public function store(Request $request) : Model;

    public function storeFile(String $fieldname, $file, Model &$user);

    public function storeAvatar($file, Model &$user);
}
