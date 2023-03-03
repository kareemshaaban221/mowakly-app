<?php

namespace App\Repositories;

use App\Models\PasswordReset;
use Illuminate\Database\Eloquent\Model;
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

    public function resetPassword($new_password, String $token, Model &$user) {
        $record = PasswordReset::where('email', $user->email)->where('token', $token)->first();

        if(!$record) {
            return false;
        }

        $record->delete();

        $user->password = bcrypt($new_password);

        return true;
    }
}
