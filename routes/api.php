<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthLawyerController;
use App\Http\Controllers\Auth\AuthClientController;
use App\Helpers\Response;

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
    Route::post('/register', [AuthLawyerController::class, 'register'])->name('lawyer.register');
    Route::post('/login', [AuthLawyerController::class, 'login'])->name('lawyer.login');
});

Route::middleware('isClient')->group(function () {
    Route::post('/register', [AuthClientController::class, 'register'])->name('client.register');
    Route::post('/login', [AuthClientController::class, 'login'])->name('client.login');
});

// Route::post('/loginAdmin', function (Request $request) {
//     $user = App\Models\User::select()->where('email', $request->email)->first();

//     $token = $user->createToken('admin')->plainTextToken;

//     return response([
//         'token' => $token,
//         'message' => 'done'
//     ], 200);
// });
// // 3|fmlmYCPwBXZEPlSteUm7nBhXgkcVW3v5YFoOHyS7


Route::middleware('auth:sanctum')->group(function () {

    // lawyers routes
    Route::prefix('lawyer')->middleware('isLawyer')->group(function () {

        // logout route
        Route::post('/logout', [AuthLawyerController::class, 'logout'])->name('lawyer.logout');

    });

});

Route::any('{any}', function ($response = new Response) {
    return $response->notFound(NULL, 'resource');
})->where('any', '.*');
