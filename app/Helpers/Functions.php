<?php

namespace App\Helpers;

use App\Mail\ResetPasswordMail;
use App\Mail\VerficationMail;
use App\Models\PasswordReset;
use App\Models\VerifyEmail;
use Illuminate\Database\Eloquent\Model;
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

    public function sendVerificationLink($user, $auth = null) {
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

    public function sendResetPasswordLink($user, $user_type) {
        $record = PasswordReset::where('email', $user->email)
            ->where('user_type', $user_type)
            ->first();

        $token = '';
        if(!$record) {
            $token = Str::random(64);

            PasswordReset::create([
                'user_type' => $user_type,
                'email' => $user->email,
                'token' => $token
            ]);
        } else {
            $token = $record->token;
        }

        return Mail::to($user->email)->send(new ResetPasswordMail($user, $user_type, $token));
    }

    public function storeFile(String $fieldname, $file, Model &$user, $user_type) {
        $uploads_path = NULL;

        if ($user_type == 'lawyer')
            $uploads_path = $this->uploads_path('lawyers');
        else if ($user_type == 'client')
            $uploads_path = $this->uploads_path('clients');
        else
            throw new \Exception('App\Helpers\Functions::storeFile() Invalid User Type!');

        $filename = $this->concatFilenameWithEmail('_'.$fieldname.'_', $user->email, $file->getClientOriginalName());

        $file->move($uploads_path . '/' . $user->id, $filename);

        return $filename;
    }

    public function deleteFile($filename, Model &$user, $user_type) {
        $uploads_path = NULL;

        if ($user_type == 'lawyer')
            $uploads_path = $this->uploads_path('lawyers');
        else if ($user_type == 'client')
            $uploads_path = $this->uploads_path('clients');
        else
            throw new \Exception('App\Helpers\Functions::deleteFile() Invalid User Type!');

        $uploads_path = $uploads_path . '/' . $user->id;

        if(file_exists($uploads_path . '/' . $filename)) {
            unlink($uploads_path . '/' . $filename);
            return $filename;
        } else {
            throw new \Exception('File not found');
        }
	}
}
