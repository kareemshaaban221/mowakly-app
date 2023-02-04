<?php

namespace App\Helpers;

use App\Mail\VerficationMail;
use App\Models\VerifyEmail;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;

Trait Functions
{
    public function explodeAndPop(string $str, string $delimiter = ' ') {
        $arr = explode($delimiter, $str);
        return array_pop($arr);
    }

    public function getFileExtension(string $filename) {
        return $this->explodeAndPop($filename, '.');
    }

    public function removeSpecialCharacters(string $str, string $replacement) {
        return preg_replace('/[^A-Za-z0-9]+/i', $replacement, $str);
    }

    public function concatFilenameWithEmail(string $prefix, string $email, string $filename) {
        return $prefix . $this->removeSpecialCharacters($email, '_') . '.' . $this->getFileExtension($filename);
    }

    public function sendVerificationLink($user, $response = new Response, $auth = null) {
        $token = '';
        if($auth) {
            $record = null;
            if($auth == 'lawyer') {
                $record = VerifyEmail::where('email', $user->email)->where('user_type', 'lawyer')->first();
            } else if ($auth == 'client') {
                $record = VerifyEmail::where('email', $user->email)->where('user_type', 'client')->first();
            } else {
                return null;
            }

            if(!$record) {
                return 'verified';
            }

            $token = $record->token;
        } else {
            $token = Str::random(64);

            VerifyEmail::create([
                'user_type' => request()->user_type,
                'email' => $user->email,
                'token' => $token
            ]);
        }

        return Mail::to($user->email)->send(new VerficationMail($user, request()->user_type, $token));
    }
}
