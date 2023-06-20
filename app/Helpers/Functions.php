<?php

namespace App\Helpers;

use App\Mail\ResetPasswordMail;
use App\Mail\VerficationMail;
use App\Models\PasswordReset;
use App\Models\VerifyEmail;
use Carbon\Carbon;
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

    public function sendResetPasswordCode($user, $user_type) {
        $record = PasswordReset::where('email', $user->email)
            ->where('user_type', $user_type)
            ->first();

        if($record) {
            $delete_at = Carbon::parse($record->delete_at);
            if(now()->isAfter($delete_at)) {
                $record->delete();
                $record = null;
            }
        }

        $code = '';
        if(!$record) {
            $code = Str::random(6);
            $token = Str::random(64);

            $record = PasswordReset::create([
                'user_type' => $user_type,
                'email' => $user->email,
                'code' => $code,
                'token' => $token,
                'delete_at' => now()->addHours(8)
            ]);
        } else {
            $code = $record->code;
        }

        $remain = Carbon::parse($record->delete_at)->diff(now())->h;
        return Mail::to($user->email)->send(new ResetPasswordMail($user, $code, $remain));
    }

    public function checkResetPasswordCode($user, $code, $user_type) {
        $record = PasswordReset::where('email', $user->email)
            ->where('user_type', $user_type)
            ->first();

        if(!$record) return -1;
        else {
            if($code == $record->code) {
                if(now()->isAfter($record->delete_at)) {
                    $record->delete();
                    return -3;
                }
                return $record;
            }
            else return -2;
        }
    }

    public function storeFile(String $fieldname, $file, Model &$model, $dirname) {
        $uploads_path = NULL;

        if ($dirname == 'lawyer')
            $uploads_path = $this->uploads_path('lawyers');
        else if ($dirname == 'client')
            $uploads_path = $this->uploads_path('clients');
        else if ($dirname == 'article')
            $uploads_path = $this->uploads_path('articles');
        else
            throw new \Exception('App\Helpers\Functions::storeFile() Invalid Directory Name!');

        if ($dirname == 'article')
            $filename = Str::random(32) . '_' . $file->getClientOriginalName();
        else
            $filename = Str::random(32) . '_' . $file->getClientOriginalName();

        $file->move($uploads_path, $filename);

        return ("uploads/{$dirname}s/{$filename}");
    }

    public function deleteFile($filename, Model &$user, $dirname) {
        $uploads_path = NULL;

        if ($dirname == 'lawyer')
            $uploads_path = $this->uploads_path('lawyers');
        else if ($dirname == 'client')
            $uploads_path = $this->uploads_path('clients');
        else if ($dirname == 'article')
            $uploads_path = $this->uploads_path('articles');
        else
            throw new \Exception('App\Helpers\Functions::deleteFile() Invalid User Type!');

        if(file_exists($uploads_path . '/' . $filename)) {
            unlink($uploads_path . '/' . $filename);
            return $filename;
        } else {
            throw new \Exception('App\Helpers\Functions::deleteFile() File not found');
        }
	}
}
