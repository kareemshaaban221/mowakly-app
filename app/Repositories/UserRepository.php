<?php

namespace App\Repositories;

use Laravel\Socialite\Facades\Socialite;

abstract class UserRepository {
    public function socialiteAccessLink(String $driver) {
        return Socialite::driver($driver)->stateless()->redirect()->getTargetUrl();
    }

    public function socialiteRegisterCallback(string $driver) {
        $user = Socialite::driver($driver)->stateless()->user()->user;

        return [
            'fname' => $user['given_name'],
            'lname' => $user['family_name'],
            'avatar' => $user['picture'],
            'email' => $user['email'],
        ];
    }

    public function socialiteLoginCallback(String $driver) {
        return Socialite::driver($driver)->stateless()->user()->user;
    }
}
