<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

interface UserRepositoryInterface extends AuthRepositoryInterface, SocialiteAuthRepositoryInterface {
    public function store(Request $request) : Model;

    public function update(Request $request, $email) : Model;

    public function destroy($email) : Model;

    public function storeAvatar($file, Model &$user);

    public function updateAvatar($file, Model &$user);

    public function deleteAvatar($filename, Model &$user);

    public function verifyEmail(Request $request, String $token);

    public function resetPassword($new_password, String $token, Model &$user, $user_type);
}
