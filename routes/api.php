<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthLawyerController;
use App\Http\Controllers\Auth\AuthClientController;
use App\Helpers\Response;
use App\Http\Controllers\Auth\FacebookController;
use App\Http\Controllers\Auth\GoogleController;
use App\Http\Controllers\Lawyer\LawyerController;
use App\Http\Controllers\Lawyer\ProfileController as LawyerProfileController;
use App\Http\Controllers\Client\ProfileController as ClientProfileController;
use App\Http\Controllers\Lawyer\LawyerMainCategoryController;
use App\Http\Controllers\Lawyer\LawyerSubcategoryController;
use App\Http\Controllers\MainCategoryController;
use App\Http\Controllers\SubcategoryController;

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
    // facebook auth routes
    Route::get('/facebook/register', [FacebookController::class, 'access'])->name('lawyer.facebook.register');
    Route::get('/facebook/login', [FacebookController::class, 'access'])->name('lawyer.facebook.login');
    Route::get('/facebook/callback', [FacebookController::class, 'callback'])->name('lawyer.facebook.callback');
    // verification action route
    Route::get('/email/verify/{token}', [AuthLawyerController::class, 'verify'])->name('lawyer.email.verify');
    // reset password route
    Route::post('/password/reset/link', [AuthLawyerController::class, 'resetPasswordLink'])->name('lawyer.password.reset.link');
    Route::post('/password/reset/{token}', [AuthLawyerController::class, 'resetPassword'])->name('lawyer.password.reset');
});

Route::middleware('isClient')->group(function () {
    // auth routes
    Route::post('/register', [AuthClientController::class, 'register'])->name('client.register');
    Route::post('/login', [AuthClientController::class, 'login'])->name('client.login');
    // google auth routes
    Route::get('/google/register', [GoogleController::class, 'access'])->name('client.google.register');
    Route::get('/google/login', [GoogleController::class, 'access'])->name('client.google.login');
    Route::get('/google/callback', [GoogleController::class, 'callback'])->name('client.google.callback');
    // facebook auth routes
    Route::get('/facebook/register', [FacebookController::class, 'access'])->name('client.facebook.register');
    Route::get('/facebook/login', [FacebookController::class, 'access'])->name('client.facebook.login');
    Route::get('/facebook/callback', [FacebookController::class, 'callback'])->name('client.facebook.callback');
    // verification action route
    Route::get('/email/verify/{token}', [AuthClientController::class, 'verify'])->name('client.email.verify');
    // reset password route
    Route::post('/password/reset/link', [AuthClientController::class, 'resetPasswordLink'])->name('client.password.reset.link');
    Route::post('/password/reset/{token}', [AuthClientController::class, 'resetPassword'])->name('client.password.reset');
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
        Route::post('profile/delete', [LawyerProfileController::class, 'destroy'])->name('lawyer.profile.destroy');

        Route::post('maincategories', [LawyerMainCategoryController::class, 'show'])->name('lawyer.maincategories.show');
        Route::post('maincategories/category/{id}', [LawyerMainCategoryController::class, 'showByCategory'])->name('lawyer.maincategories.category.show');
        Route::post('maincategories/mean/{mean}', [LawyerMainCategoryController::class, 'showByConsultationMean'])->name('lawyer.maincategories.mean.show');
        Route::post('maincategories/category/{id}/mean/{mean}', [LawyerMainCategoryController::class, 'showSpecific'])->name('lawyer.maincategories.category.mean.show');
        Route::post('maincategories/store', [LawyerMainCategoryController::class, 'store'])->name('lawyer.maincategories.store');
        Route::post('maincategories/update', [LawyerMainCategoryController::class, 'update'])->name('lawyer.maincategories.update');
        Route::post('maincategories/category/{id}/delete', [LawyerMainCategoryController::class, 'destroy'])->name('lawyer.maincategories.category.delete');
        Route::post('maincategories/category/{id}/mean/{mean}/delete', [LawyerMainCategoryController::class, 'destroySpecific'])->name('lawyer.maincategories.category.mean.delete');

        Route::post('subcategories', [LawyerSubcategoryController::class, 'show'])->name('lawyer.subcategories.show');
        Route::post('subcategories/store', [LawyerSubcategoryController::class, 'store'])->name('lawyer.subcategories.store');
        Route::post('subcategories/category/{id}/delete', [LawyerSubcategoryController::class, 'destroy'])->name('lawyer.subcategories.category.delete');

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
        Route::post('profile/delete', [ClientProfileController::class, 'destroy'])->name('client.profile.destroy');

    });

});

// categories routes
Route::post('/categories', [MainCategoryController::class, 'store'])->name('maincategories.store');
Route::get('/categories', [MainCategoryController::class, 'index'])->name('maincategories.index');

// subcategories routes
Route::post('/subcategories', [SubcategoryController::class, 'store'])->name('subcategories.store');
Route::get('/subcategories', [SubcategoryController::class, 'index'])->name('subcategories.index');

// Route::get('/lawyers', [LawyerController::class, 'index'])->name('lawyer.index');
// Route::get('/lawyers/show/{email}', [LawyerController::class, 'show'])->name('lawyer.show');
// Route::get('/lawyers/update/{email}', [LawyerController::class, 'update'])->name('lawyer.update');
// Route::get('/lawyers/delete/{email}', [LawyerController::class, 'delete'])->name('lawyer.delete');

//? This route for any invalid request ;)
Route::any('{any}', function () {
    // dd(request()->getUri());
    return (new Response)->notFound(NULL, 'resource');
})->where('any', '.*');
