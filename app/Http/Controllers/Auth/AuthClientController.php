<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\ClientRegisterRequest;
use App\Http\Requests\ClientLoginRequest;
use App\Helpers\Response;
use Illuminate\Support\Facades\DB;
use App\Interfaces\ClientRepositoryInterface;

class AuthClientController extends Controller
{
    private ClientRepositoryInterface $clientRepository;

    public function __construct(ClientRepositoryInterface $clientRepository) {
        $this->clientRepository = $clientRepository;
    }

    public function register(ClientRegisterRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['password', 'password_confirmation', 'avatar']));
        }

        DB::beginTransaction();
        try {

            $client = $this->clientRepository->store($request);

            if(isset($request->avatar)) {
                $this->clientRepository->storeAvatar($request->avatar, $client);
            }
            $client->save();

            if(isset($request->payment_methods)) {
                $this->clientRepository->storePaymentMethods($request->payment_methods, $client);
            }

            $token = $this->clientRepository->generateToken($client);

            DB::commit();

            return $response->created(['data' => $client, 'token' => $token], 'client');

        } catch (\Throwable $th) {
            DB::rollback();
            return $response->internalServerError($th->getMessage());
        }
    }

    public function login(ClientLoginRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['password']));
        }

        DB::beginTransaction();

        try {

            $client = $this->clientRepository->checkCredentials($request->validated());

            if(!$client) {
                return $response->forbidden('Wrong password!');
            }

            $token = $this->clientRepository->generateToken($client);

            DB::commit();

            return $response->ok([
                'message' => 'Signed in successfully!',
                'token' => $token,
                'data' => $client
            ]);

        } catch (\Throwable $th) {
            DB::rollback();
            return $response->badRequest('An error occured!', $th->getMessage());
        }
    }

    public function logout($response = new Response) {
        $query = auth()->user()->tokens()->where('name', 'client-'.auth()->user()->id);
        $tokens = $query->get();

        if($tokens->isEmpty())
            return $response->notAuthorized('Unauthenticated. (Wrong user type)');

        $query->delete();
        return $response->ok([
            'message' => 'Signed out successfully!',
        ]);
    }
}
