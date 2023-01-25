<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\LawyerRegisterRequest;
use Illuminate\Support\Facades\Validator;
use App\Helpers\Response;
use App\Models\Lawyer;

class LawyerController extends Controller
{
    public function register(LawyerRegisterRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages());
        }

        $data = $request->validated();

        try {
            $extension1 = count(explode('.', $data['card']->getClientOriginalName())) - 1;
            $extension2 = count(explode('.', $data['avatar']->getClientOriginalName())) - 1;
            $uploads_path = storage_path('app/public/uploads/lawyers');
            $card_filename = '_card_' . preg_replace('/[^A-Za-z0-9]+/i', '_', $data['email']) . '.' . explode('.', $data['card']->getClientOriginalName())[$extension1];
            $avatar_filename = '_avatar_' . preg_replace('/[^A-Za-z0-9]+/i', '_', $data['email']) . '.' . explode('.', $data['avatar']->getClientOriginalName())[$extension2];

            $data['card']->move($uploads_path, $card_filename);
            $data['avatar']->move($uploads_path, $avatar_filename);

            $lawyer = Lawyer::create([
                'fname' => $data['fname'],
                'lname' => $data['lname'],
                'email' => $data['email'],
                'password' => bcrypt($data['password']),
                'gender' => $data['gender'],
                'description' => $data['description'],
                'date_of_birth' => $data['date_of_birth'],
                'card' => $card_filename,
                'card_id' => 'required|max:20',
                'avatar' => $avatar_filename,
                'chat_price' => $data['chat_price'],
                'video_price' => $data['video_price'],
                'phone_price' => $data['phone_price'],
            ]);

            $token = $lawyer->createToken('lawyer-' . $request->id)->plainTextToken;

            return $response->created(['data' => $lawyer, 'token' => $token], 'lawyer');
        } catch (\Throwable $th) {
            return $response->badRequest($th->getMessage());
        }
    }
}
