<?php

namespace App\Http\Controllers\Client;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\ClientRegisterRequest;
use App\Http\Requests\ClientUpdateRequest;
use App\Interfaces\ClientRepositoryInterface;
use App\Models\Client;
use App\Models\VerifyEmail;
use Illuminate\Support\Facades\DB;

class ClientController extends Controller
{

    private ClientRepositoryInterface $clientRepository;
    private Response $response;

    public function __construct(ClientRepositoryInterface $clientRepository) {
        $this->clientRepository = $clientRepository;
        $this->response = new Response;
    }

    public function index()
    {
        $clients = Client::all();

        return $this->response->ok([
            'data' => $clients,
            'message' => 'All clients!'
        ]);
    }

    public function store(ClientRegisterRequest $request)
    {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['password', 'password_confirmation', 'avatar']));
        }

        DB::beginTransaction();

        try {
            $client = $this->clientRepository->store($request);

            $this->clientRepository->storeAvatar($request->avatar, $client);

            $client->save();

            DB::commit();

            return $this->response->created(['data' => $client], 'client');
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function show($email)
    {
        $client = Client::where('email', $email)->first();

        if(!$client) {
            return $this->response->notFound(obj: 'client');
        }

        return $this->response->ok([
            'data' => $client,
            'message' => 'Client is found!',
        ]);
    }

    public function update(ClientUpdateRequest $request, $email)
    {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['password', 'password_confirmation', 'card', 'avatar', 'attachments']));
        }

        DB::beginTransaction();

        try {
            $client = $this->clientRepository->update($request, $email);

            isset($request->avatar) ? $this->clientRepository->updateAvatar($request->avatar, $client) : null;

            $client->save();

            DB::commit();

            return $this->response->ok([
                'data' => $client,
                'message' => 'Client has been updated successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function destroy($email)
    {
        DB::beginTransaction();

        try {
            $client = Client::where('email', $email)->first();
            $client->tokens()->where('name', 'client-' . $client->id)->delete();
            VerifyEmail::where('email', $email)->where('user_type', 'client')->delete();

            $client->delete();

            DB::commit();

            return $this->response->ok(['data' => $client, 'message' => 'Client has been deleted successfully!']);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
