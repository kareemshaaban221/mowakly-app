<?php

namespace App\Repositories;

use Laravel\Socialite\Facades\Socialite;

abstract class UserRepository {
    public function socialiteAccessLink(String $driver) {
        return Socialite::driver($driver)->stateless()->redirect()->getTargetUrl();
    }

    public function socialiteRegisterCallback(string $driver, bool $avatar = true) {
        $user = Socialite::driver($driver)->stateless()->user()->user;

        return array_merge([
            'fname' => $user['given_name'],
            'lname' => $user['family_name'],
            'email' => $user['email'],
        ], $avatar ? ['avatar' => $user['picture']] : []);
    }

    public function socialiteLoginCallback(String $driver) {
        return Socialite::driver($driver)->stateless()->user()->user;
    }
}
