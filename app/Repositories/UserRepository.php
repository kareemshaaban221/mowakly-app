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

        if($driver == 'facebook') {
            $name = explode(' ', trim($user['name']));
            $fname = $name[0];
            $lname = array_pop($name);

            return [
                'fname' => $fname,
                'lname' => $lname,
                'email' => $user['email'],
            ];
        }

        if($driver == 'google') {
            return array_merge([
                'fname' => $user['given_name'],
                'lname' => $user['family_name'],
                'email' => $user['email'],
            ], $avatar ? ['avatar' => $user['picture']] : []);
        }
    }

    public function socialiteLoginCallback(String $driver) {
        return Socialite::driver($driver)->stateless()->user()->user;
    }

    public function resetPassword($new_password, String $token, Model &$user, $user_type) {
        $record = PasswordReset::where('email', $user->email)
            ->where('user_type', $user_type)->first();

        if(!$record) {
            return -1;
        }

        if($record->token != $token) {
            return -2;
        }

        $record->delete();

        $user->password = bcrypt($new_password);

        return 1;
    }
}
