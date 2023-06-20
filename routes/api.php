<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthLawyerController;
use App\Http\Controllers\Auth\AuthClientController;
use App\Helpers\Response;
use App\Http\Controllers\Auth\FacebookController;
use App\Http\Controllers\Auth\GoogleController;
use App\Http\Controllers\Client\ClientLawyerChatController as ClientClientLawyerChatController;
use App\Http\Controllers\Client\ConsultationController as ClientConsultationController;
use App\Http\Controllers\Lawyer\ProfileController as LawyerProfileController;
use App\Http\Controllers\Client\ProfileController as ClientProfileController;
use App\Http\Controllers\ClientLawyerChatController;
use App\Http\Controllers\Lawyer\AppointmentController as LawyerAppointmentController;
use App\Http\Controllers\Lawyer\ArticleCommentController;
use App\Http\Controllers\Lawyer\ArticleController;
use App\Http\Controllers\Lawyer\LawyerClientChatController as LawyerLawyerClientChatController;
use App\Http\Controllers\Lawyer\LawyerMainCategoryController;
use App\Http\Controllers\Lawyer\LawyerSubcategoryController;
use App\Http\Controllers\Lawyer\ScheduleController as LawyerScheduleController;
use App\Http\Controllers\LawyerClientChatController;
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
    Route::post('/password/reset/code', [AuthLawyerController::class, 'resetPasswordCode'])->name('lawyer.password.reset.code');
    Route::post('/password/reset/token', [AuthLawyerController::class, 'resetPasswordToken'])->name('lawyer.password.reset.token');
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
    Route::post('/password/reset/code', [AuthClientController::class, 'resetPasswordCode'])->name('client.password.reset.code');
    Route::post('/password/reset/token', [AuthClientController::class, 'resetPasswordToken'])->name('client.password.reset.token');
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
        Route::get('/profile', [LawyerProfileController::class, 'index'])->name('lawyer.profile.index');
        Route::put('profile/update', [LawyerProfileController::class, 'update'])->name('lawyer.profile.update');
        Route::post('profile/attachments/add', [LawyerProfileController::class, 'addAttachment'])->name('lawyer.profile.attachments.add');
        Route::delete('profile/attachments/{filename}/delete', [LawyerProfileController::class, 'destroyAttachment'])->name('lawyer.profile.attachments.delete');
        Route::post('profile/phones/add', [LawyerProfileController::class, 'addPhone'])->name('lawyer.profile.phones.add');
        Route::delete('profile/phones/{phone_num}/delete', [LawyerProfileController::class, 'destroyPhone'])->name('lawyer.profile.phones.delete');
        Route::delete('profile/delete', [LawyerProfileController::class, 'destroy'])->name('lawyer.profile.destroy');

        // consultations
        Route::get('/consultations', [LawyerProfileController::class, 'getAllConsultations'])->name('lawyer.consultations.index');
        Route::get('/consultations/{id}', [LawyerProfileController::class, 'showConsultation'])->name('lawyer.consultations.show');

        Route::get('maincategories', [LawyerMainCategoryController::class, 'index'])->name('lawyer.maincategories.index');
        Route::get('maincategories/category/{id}', [LawyerMainCategoryController::class, 'showByCategory'])->name('lawyer.maincategories.category.show');
        Route::get('maincategories/mean/{mean}', [LawyerMainCategoryController::class, 'showByConsultationMean'])->name('lawyer.maincategories.mean.show');
        Route::get('maincategories/category/{id}/mean/{mean}', [LawyerMainCategoryController::class, 'show'])->name('lawyer.maincategories.category.mean.show');
        Route::post('maincategories', [LawyerMainCategoryController::class, 'store'])->name('lawyer.maincategories.store');
        Route::put('maincategories/update', [LawyerMainCategoryController::class, 'update'])->name('lawyer.maincategories.update');
        Route::delete('maincategories/category/{id}/delete', [LawyerMainCategoryController::class, 'destroyByCategory'])->name('lawyer.maincategories.category.delete');
        Route::delete('maincategories/category/{id}/mean/{mean}/delete', [LawyerMainCategoryController::class, 'destroy'])->name('lawyer.maincategories.category.mean.delete');

        Route::get('subcategories', [LawyerSubcategoryController::class, 'index'])->name('lawyer.subcategories.index');
        Route::post('subcategories', [LawyerSubcategoryController::class, 'store'])->name('lawyer.subcategories.store');
        Route::delete('subcategories/{subcategory_id}/delete', [LawyerSubcategoryController::class, 'destroy'])->name('lawyer.subcategories.delete');

        // schedule routes
        Route::get('schedules', [LawyerScheduleController::class, 'index'])->name('lawyer.schedule.index');
        Route::get('schedules/show/{id}', [LawyerScheduleController::class, 'show'])->name('lawyer.schedule.show');
        Route::post('schedules', [LawyerScheduleController::class, 'store'])->name('lawyer.schedule.store');
        Route::put('schedules/{id}/update', [LawyerScheduleController::class, 'update'])->name('lawyer.schedule.update');
        Route::delete('schedules/{id}/delete', [LawyerScheduleController::class, 'destroy'])->name('lawyer.schedule.delete');

        // appointment routes
        Route::get('appointments', [LawyerAppointmentController::class, 'index'])->name('lawyer.appointment.index');
        Route::post('appointments/schedule/{schedule_id}', [LawyerAppointmentController::class, 'store'])->name('lawyer.appointment.store');
        Route::put('appointments/{appointment_id}/update', [LawyerAppointmentController::class, 'update'])->name('lawyer.appointment.update');
        Route::get('appointments/{appointment_id}', [LawyerAppointmentController::class, 'show'])->name('lawyer.appointment.show');
        Route::delete('appointments/{appointment_id}/delete', [LawyerAppointmentController::class, 'destroy'])->name('lawyer.appointment.delete');

        // client chat
        Route::get('chat/{user_id}', [LawyerLawyerClientChatController::class, 'index'])->name('lawyer.chat.index');
        Route::post('chat/{user_id}', [LawyerLawyerClientChatController::class, 'store'])->name('lawyer.chat.store');

        // articles
        Route::get('articles', [ArticleController::class, 'index'])->name('article.index');
        Route::post('articles', [ArticleController::class, 'store'])->name('article.store');
        Route::put('articles/{id}', [ArticleController::class, 'update'])->name('article.update');
        Route::delete('articles/{id}', [ArticleController::class, 'destroy'])->name('article.destroy');
        Route::get('articles/{id}', [ArticleController::class, 'show'])->name('article.show');

        // articles comments
        Route::get('articles/{article_id}/comments', [ArticleCommentController::class, 'index'])->name('article.comments.index');
        Route::post('articles/{article_id}/comments', [ArticleCommentController::class, 'store'])->name('article.comments.store');
        Route::put('articles/comments/{comment_id}', [ArticleCommentController::class, 'update'])->name('article.comments.update');
        Route::delete('articles/comments/{comment_id}', [ArticleCommentController::class, 'destroy'])->name('article.comments.delete');
    });

    // clients routes
    Route::middleware('isClient')->group(function () {

        // logout route
        Route::get('/logout', [AuthClientController::class, 'logout'])->name('client.logout');

        // verification link request route
        Route::get('/email/send/verify/link', [AuthClientController::class, 'verificationLink'])->name('client.email.verification.link');

        // profile management routes
        Route::get('/profile', [ClientProfileController::class, 'index'])->name('client.profile.index');
        Route::put('profile/update', [ClientProfileController::class, 'update'])->name('client.profile.update');
        Route::post('profile/payment_methods/add', [ClientProfileController::class, 'addPaymentMethod'])->name('client.profile.payment_methods.add');
        Route::delete('profile/payment_methods/{payment_method}/delete', [ClientProfileController::class, 'destroyPaymentMethod'])->name('client.profile.payment_methods.delete');
        Route::delete('profile/delete', [ClientProfileController::class, 'destroy'])->name('client.profile.destroy');

        // consultation
        Route::post('consultations', [ClientConsultationController::class, 'store'])->name('client.consultation.store');
        Route::put('consultations/{id}/update', [ClientConsultationController::class, 'update'])->name('client.consultation.update');
        Route::get('consultations/show/{id}', [ClientConsultationController::class, 'show'])->name('client.consultation.show');
        Route::get('consultations', [ClientConsultationController::class, 'index'])->name('client.consultation.index');

        // client chat
        Route::get('chat/{user_id}', [ClientClientLawyerChatController::class, 'index'])->name('lawyer.chat.index');
        Route::post('chat/{user_id}', [ClientClientLawyerChatController::class, 'store'])->name('lawyer.chat.store');

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
