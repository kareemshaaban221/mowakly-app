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

class LawyerClientChatController extends Controller
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
            $lawyer = Lawyer::where('email', $request->email)->first();
            $client = Client::find($user_id);

            if (!$lawyer)
                return $this->response->notFound(obj: 'lawyer');

            if (!$client)
                return $this->response->notFound(obj: 'client id');

            $data = [
                'me' => LawyerClientChat::where('from', $lawyer->id)
                    ->where('to', $user_id)
                    ->get()
                    ->setHidden(['id'])
                    ->each(function ($item) {
                        $item->context = 'me';
                    }),
                'other' => ClientLawyerChat::where('from', $user_id)
                    ->where('to', $lawyer->id)
                    ->get()
                    ->setHidden(['id'])
                    ->each(function ($item) {
                        $item->context = 'other';
                    })
            ];

            $data = $data['me']->toBase()->merge($data['other']);

            return $this->response->ok([
                'data' => $data->sortBy('created_at')->toarray(),
                'message' => 'All lawyer messages in chat with client!',
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
            $lawyer = Lawyer::where('email', $request->email)->first();
            $client = Client::find($user_id);

            if (!$lawyer)
                return $this->response->notFound(obj: 'lawyer');

            if (!$client)
                return $this->response->notFound(obj: 'client id');

            $chatInstance = $this->chatRepository->store($request, $lawyer, $client);

            $chatInstance->save();

            $this->publishMessage($request->message, $lawyer, $client);

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
