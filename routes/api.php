<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthLawyerController;
use App\Http\Controllers\Auth\AuthClientController;
use App\Helpers\Response;
use App\Http\Controllers\Auth\GoogleController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::prefix('lawyer')->middleware('isLawyer')->group(function () {
    // auth routes
    Route::post('/register', [AuthLawyerController::class, 'register'])->name('lawyer.register');
    Route::post('/login', [AuthLawyerController::class, 'login'])->name('lawyer.login');
    // google auth routes
    Route::get('/google/register', [GoogleController::class, 'access'])->name('lawyer.google.register');
    Route::get('/google/login', [GoogleController::class, 'access'])->name('lawyer.google.login');
    Route::get('/google/callback', [GoogleController::class, 'callback'])->name('lawyer.google.callback');
    // verification action route
    Route::get('/email/verify/{token}', [AuthLawyerController::class, 'verify'])->name('lawyer.email.verify');
});

Route::middleware('isClient')->group(function () {
    // auth routes
    Route::post('/register', [AuthClientController::class, 'register'])->name('client.register');
    Route::post('/login', [AuthClientController::class, 'login'])->name('client.login');
    // google auth routes
    Route::get('/google/register', [GoogleController::class, 'access'])->name('client.google.register');
    Route::get('/google/login', [GoogleController::class, 'access'])->name('client.google.login');
    Route::get('/google/callback', [GoogleController::class, 'callback'])->name('client.google.callback');
    // verification action route
    Route::get('/email/verify/{token}', [AuthClientController::class, 'verify'])->name('client.email.verify');
});

Route::middleware('auth:sanctum')->group(function () {

    // lawyers routes
    Route::prefix('lawyer')->middleware('isLawyer')->group(function () {

        // logout route
        Route::get('/logout', [AuthLawyerController::class, 'logout'])->name('lawyer.logout');

        // verification link request route
        Route::get('/email/send/verify/link', [AuthLawyerController::class, 'verificationLink'])->name('lawyer.email.verification.link');

    });

    // clients routes
    Route::middleware('isClient')->group(function () {

        // logout route
        Route::get('/logout', [AuthClientController::class, 'logout'])->name('client.logout');

        // verification link request route
        Route::get('/email/send/verify/link', [AuthClientController::class, 'verificationLink'])->name('client.email.verification.link');

    });

});

//? This route for any invalid request ;)
Route::any('{any}', function () {
    return (new Response)->notFound(NULL, 'resource');
})->where('any', '.*');
