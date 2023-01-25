<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\LawyerController;
use App\Http\Controllers\Auth\ClientController;

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
    Route::post('/register', [LawyerController::class, 'register'])->name('register');
    Route::post('/login', [LawyerController::class, 'login'])->name('login');
});

Route::middleware('isClient')->group(function () {
    Route::post('/register', [ClientController::class, 'register'])->name('register');
    Route::post('/login', [ClientController::class, 'login'])->name('login');
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


// Route::middleware('auth:sanctum')->group(function () {
//     Route::get('/logoutAdmin', function () {
//         auth()->user()->tokens()->delete();
//         return response([
//             'message' => 'done'
//         ], 200);
//     });
// });
