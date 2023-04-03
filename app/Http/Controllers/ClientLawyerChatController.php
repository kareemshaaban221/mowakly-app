<?php

namespace App\Http\Controllers;

use App\Events\MessageSent;
use App\Helpers\Response;
use App\Http\Requests\ChatRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\ChatRepositoryInterface;
use App\Models\Client;
use App\Models\ClientLawyerChat;
use App\Models\Lawyer;
use App\Models\LawyerClientChat;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ClientLawyerChatController extends Controller
{
    private $response;
    private $chatRepository;

    public function __construct(ChatRepositoryInterface $chatRepository) {
        $this->response = new Response;
        $this->chatRepository = $chatRepository;
    }

    public function index(EmailAuthOrGivenRequest $request, $user_id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        try {
            $client = Client::where('email', $request->email)->first();
            $lawyer = Lawyer::find($user_id);

            if (!$client)
                return $this->response->notFound(obj: 'client');

            if (!$lawyer)
                return $this->response->notFound(obj: 'lawyer id');

            $data = [
                'me' => ClientLawyerChat::where('from', $client->id)
                    ->where('to', $user_id)
                    ->get()->sortBy('created_at')->toarray(),
                'other' => LawyerClientChat::where('from', $user_id)
                    ->where('to', $client->id)
                    ->get()->sortBy('created_at')->toarray()
            ];

            return $this->response->ok([
                'data' => $data,
                'message' => 'All client messages in chat with lawyer!',
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store(ChatRequest $request, $user_id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $client = Client::where('email', $request->email)->first();
            $lawyer = Lawyer::find($user_id);

            if (!$client)
                return $this->response->notFound(obj: 'client');

            if (!$lawyer)
                return $this->response->notFound(obj: 'lawyer id');

            $chatInstance = $this->chatRepository->store($request, $client, $lawyer);

            $chatInstance->save();

            $this->publishMessage($request->message, $client, $lawyer);

            DB::commit();

            $data = $chatInstance->toarray();
            $data['lawyer'] = $lawyer;
            $data['client'] = $client;

            return $this->response->created(['data' => $data], 'chat record');

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function publishMessage($message, $from, $to) {
        event(new MessageSent($message, $from, $to, request()->user_type));

        return 1;
    }
}
