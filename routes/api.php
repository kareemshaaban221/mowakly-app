<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthLawyerController;
use App\Http\Controllers\Auth\AuthClientController;
use App\Helpers\Response;
use App\Http\Controllers\Auth\GoogleController;
use App\Http\Controllers\Lawyer\LawyerController;
use App\Http\Controllers\Lawyer\ProfileController as LawyerProfileController;
use App\Http\Controllers\Client\ProfileController as ClientProfileController;

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

        // profile management routes
        Route::get('/profile', [LawyerProfileController::class, 'showProfile'])->name('lawyer.profile');
        Route::post('profile/update', [LawyerProfileController::class, 'updateProfile'])->name('lawyer.profile.update');
        Route::post('profile/attachments/add', [LawyerProfileController::class, 'addAttachment'])->name('lawyer.profile.attachments.add');
        Route::post('profile/attachments/delete', [LawyerProfileController::class, 'destroyAttachment'])->name('lawyer.profile.attachments.delete');
        Route::post('profile/phones/add', [LawyerProfileController::class, 'addPhone'])->name('lawyer.profile.phones.add');
        Route::post('profile/phones/delete', [LawyerProfileController::class, 'destroyPhone'])->name('lawyer.profile.phones.delete');
    });

    // clients routes
    Route::middleware('isClient')->group(function () {

        // logout route
        Route::get('/logout', [AuthClientController::class, 'logout'])->name('client.logout');

        // verification link request route
        Route::get('/email/send/verify/link', [AuthClientController::class, 'verificationLink'])->name('client.email.verification.link');

        // profile management routes
        Route::get('/profile', [ClientProfileController::class, 'showProfile'])->name('client.profile');
        Route::post('profile/update', [ClientProfileController::class, 'updateProfile'])->name('client.profile.update');
        Route::post('profile/payment_methods/add', [ClientProfileController::class, 'addPaymentMethod'])->name('client.profile.payment_methods.add');
        Route::post('profile/payment_methods/delete', [ClientProfileController::class, 'destroyPaymentMethod'])->name('client.profile.payment_methods.delete');

    });

});

// Route::get('/lawyers', [LawyerController::class, 'index'])->name('lawyer.index');
// Route::get('/lawyers/show/{email}', [LawyerController::class, 'show'])->name('lawyer.show');
// Route::get('/lawyers/update/{email}', [LawyerController::class, 'update'])->name('lawyer.update');
// Route::get('/lawyers/delete/{email}', [LawyerController::class, 'delete'])->name('lawyer.delete');

//? This route for any invalid request ;)
Route::any('{any}', function () {
    // dd(request()->getUri());
    return (new Response)->notFound(NULL, 'resource');
})->where('any', '.*');
