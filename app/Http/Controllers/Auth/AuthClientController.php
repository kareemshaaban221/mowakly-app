<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\ClientRegisterRequest;
use App\Http\Requests\ClientLoginRequest;
use App\Helpers\Response;
use App\Http\Controllers\ClientController;
use App\Models\Client;

class AuthClientController extends Controller
{
    public function register(ClientRegisterRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['password', 'password_confirmation', 'avatar']));
        }

        $client = (new ClientController)->store($request);

        if(get_class($client) != 'App\Models\Client') {
            return $response->badRequest('An error occured', $client);
        }

        $token = $client->createToken('client-' . $client->id)->plainTextToken;

        return $response->created(['data' => $client, 'token' => $token], 'client');
    }

    public function login(ClientLoginRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['password']));
        }

        $data = $request->validated();

        try {
            $client = Client::where('email', $data['email'])->firstOrFail();

            if(!password_verify($data['password'], $client->password)) {
                return $response->forbidden('Wrong password!');
            }

            $client->tokens()->where('name', 'client-'.$client->id)->delete();

            $token = $client->createToken('client-' . $client->id)->plainTextToken;

            return $response->ok([
                'message' => 'Signed in successfully!',
                'token' => $token,
                'data' => $client
            ]);
        } catch (\Throwable $th) {
            return $response->badRequest('An error occured!', $th->getMessage());
        }
    }

    public function logout($response = new Response) {
        $query = auth()->user()->tokens()->where('name', 'client-'.auth()->user()->id);
        $tokens = $query->get();

        if($tokens->isEmpty()) return $response->notAuthorized('Unauthenticated. (Wrong user type)');

        $query->delete();
        return $response->ok([
            'message' => 'Signed out successfully!',
        ]);
    }
}
