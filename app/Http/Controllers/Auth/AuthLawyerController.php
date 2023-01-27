<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\LawyerRegisterRequest;
use App\Http\Requests\LawyerLoginRequest;
use App\Helpers\Response;
use App\Models\Lawyer;
use App\Models\LawyerPhone;
use App\Http\Controllers\LawyerPhoneController;
use App\Http\Controllers\LawyerAttachController;
use App\Http\Controllers\LawyerController;
// use Illuminate\Support\Facades\Input;

class AuthLawyerController extends Controller
{
    use \App\Helpers\Functions;

    public function register(LawyerRegisterRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['password', 'password_confirmation', 'card', 'avatar', 'attachments']));
        }

        $lawyer = (new LawyerController)->store($request);

        if(get_class($lawyer) != 'App\Models\Lawyer') {
            return $response->badRequest('An error occured', $lawyer);
        }

        $token = $lawyer->createToken('lawyer-' . $lawyer->id)->plainTextToken;

        return $response->created(['data' => $lawyer, 'token' => $token], 'lawyer');
    }

    public function login(LawyerLoginRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['password']));
        }

        $data = $request->validated();

        try {
            $lawyer = Lawyer::where('email', $data['email'])->firstOrFail();

            if(!password_verify($data['password'], $lawyer->password)) {
                return $response->forbidden('Wrong password!');
            }

            $lawyer->tokens()->where('name', 'lawyer-'.$lawyer->id)->delete();

            $token = $lawyer->createToken('lawyer-' . $lawyer->id)->plainTextToken;

            return $response->ok([
                'message' => 'Signed in successfully!',
                'token' => $token,
                'data' => $lawyer
            ]);
        } catch (\Throwable $th) {
            return $response->badRequest('An error occured!', $th->getMessage());
        }
    }

    public function logout($response = new Response) {
        $query = auth()->user()->tokens()->where('name', 'lawyer-'.auth()->user()->id);
        $tokens = $query->get();

        if($tokens->isEmpty()) return $response->notAuthorized('Unauthenticated. (Wrong user type)');

        $query->delete();
        return $response->ok([
            'message' => 'Signed out successfully!',
        ]);
    }
}
