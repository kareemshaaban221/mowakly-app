<?php

$link = NULL;
$host = env('APP_URL') . '/';
if(isset($_REQUEST['user_type'])) {
    $directs = explode('/', request()->getUri());
    $last = count($directs) - 1;
    $directs[$last] = explode('?', $directs[$last])[0];
    $register = array_search('register', $directs);
    $callback = array_search('callback', $directs);

    // dd($directs);

    if($register) {
        if(request()->user_type == 'lawyer') {
            $link = $host . 'api/lawyer/google/callback?user_type=lawyer&register=true';
        } else {
            $link = $host . 'api/google/callback?user_type=client&register=true';
        }
    } else {
        if(!$callback) {
            if(request()->user_type == 'lawyer') {
                $link = $host . 'api/lawyer/google/callback?user_type=lawyer&register=false';
            } else {
                $link = $host . 'api/google/callback?user_type=client&register=false';
            }
        } else {
            $link = request()->url()
                . '?user_type='
                . request()->user_type
                . '&'
                . (request()->register == 'true' ? 'register=true' : 'register=false');
        }
    }
}

// deployment
if($link[4] != 's') {
    $link = substr_replace($link, 's', 4, 0);
}

// dd($link);

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'mailgun' => [
        'domain' => env('MAILGUN_DOMAIN'),
        'secret' => env('MAILGUN_SECRET'),
        'endpoint' => env('MAILGUN_ENDPOINT', 'api.mailgun.net'),
        'scheme' => 'https',
    ],

    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

    'google' => [
        'client_id' => '851641971720-qrle12rssaal27g3qfk3gus31ldiueka.apps.googleusercontent.com',
        'client_secret' => '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',
        'redirect' => !is_null($link) ? $link : $host,
    ],

];
