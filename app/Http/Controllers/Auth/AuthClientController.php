<?php

namespace App\Http\Controllers\Auth;

use App\Helpers\Functions;
use App\Http\Controllers\Controller;
use App\Http\Requests\ClientRegisterRequest;
use App\Http\Requests\ClientLoginRequest;
use App\Helpers\Response;
use App\Http\Requests\ResetPasswordLinkRequest;
use App\Http\Requests\ResetPasswordRequest;
use Illuminate\Support\Facades\DB;
use App\Interfaces\ClientRepositoryInterface;
use App\Models\Client;
use Illuminate\Http\Request;

class AuthClientController extends Controller
{
    use Functions;

    private ClientRepositoryInterface $clientRepository;
    private Response $response;

    public function __construct(ClientRepositoryInterface $clientRepository) {
        $this->clientRepository = $clientRepository;
        $this->response = new Response;
    }

    public function register(ClientRegisterRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['password', 'password_confirmation', 'avatar']));
        }

        DB::beginTransaction();
        try {

            $client = $this->clientRepository->store($request);

            if(isset($request->avatar)) {
                $this->clientRepository->storeAvatar($request->avatar, $client);
            }

            if(is_null($this->sendVerificationLink($client))) {
                throw new \Exception('Error sending verification link!');
            }

            $client->save();

            if(isset($request->payment_methods)) {
                $this->clientRepository->storePaymentMethods($request->payment_methods, $client);
            }

            $token = $this->clientRepository->generateToken($client);

            DB::commit();

            return $this->response->created(['data' => $client, 'token' => $token], 'client');

        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function login(ClientLoginRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['password']));
        }

        DB::beginTransaction();

        try {

            $client = $this->clientRepository->checkCredentials($request->validated());

            if(!$client) {
                return $this->response->forbidden('Wrong password!');
            }

            $token = $this->clientRepository->generateToken($client);

            DB::commit();

            return $this->response->ok([
                'message' => 'Signed in successfully!',
                'token' => $token,
                'data' => $client
            ]);

        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function logout() {
        $query = auth()->user()->tokens()->where('name', 'client-'.auth()->user()->id);
        $tokens = $query->get();

        if($tokens->isEmpty())
            return $this->response->notAuthorized('Unauthenticated. (Wrong user type)');

        $query->delete();
        return $this->response->ok([
            'message' => 'Signed out successfully!',
        ]);
    }

    public function verificationLink() {
        $result = $this->sendVerificationLink(auth()->user(), auth: 'client');
        if($result) {
            if($result == 'verified') {
                return $this->response->ok([
                    'message' => 'This account was verified!'
                ]);
            } else {
                return $this->response->ok([
                    'message' => 'Verification link has been sent successfully!'
                ]);
            }
        }

        return $this->response->internalServerError('Error while sending verification link!');
    }

    public function verify(Request $request, $token) {
        DB::beginTransaction();

        try {
            $client = $this->clientRepository->verifyEmail($request, $token);

            if(!$client)
                return $this->response->badRequest('Token is invalid!');

            $client->save();

            DB::commit();

            return $this->response->ok([
               'message' => 'Email verified successfully!',
               'data' => $client
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function resetPasswordLink(ResetPasswordLinkRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        $user = Client::where('email', $request->email)->first();

        if(!$user) {
            return $this->response->badRequest('This email doesn\'t exists!');
        }

        $res = $this->sendResetPasswordLink($user, 'client');

        if(!$res) {
            return $this->response->internalServerError('Error while sending reset password link!');
        }

        return $this->response->ok([
            'message' => 'Reset password link has been sent successfully!'
        ]);
    }

    public function resetPassword(ResetPasswordRequest $request, $token) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }
        
        DB::beginTransaction();

        try {
            $client = Client::where('email', $request->email)->firstOrFail();

            $res = $this->clientRepository->resetPassword($request->new_password, $token, $client);

            if(!$res)
                return $this->response->badRequest('Token is invalid!');

            $client->save();

            DB::commit();

            return $this->response->ok([
               'message' => 'Password has been resetted successfully!',
               'data' => $client
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
