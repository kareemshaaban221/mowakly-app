<?php

namespace App\Repositories;
use App\Interfaces\ChatRepositoryInterface;
use App\Models\Client;
use App\Models\ClientLawyerChat;
use App\Models\Lawyer;
use App\Models\LawyerClientChat;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class ChatRepository implements ChatRepositoryInterface {

    public function store(Request $request, Model $from, Model $to) {
        if (request()->user_type == 'lawyer') {
            return $this->storeFromLawyer($request, $from, $to);
        } else {
            return $this->storeFromClient($request, $from, $to);
        }
    }

    public function storeFromClient(Request $request , Model $from , Model $to) {
        $chat = new ClientLawyerChat;

        return $this->storeAction($chat, $from->id, $to->id, $request->message);
    }

    public function storeFromLawyer(Request $request, Model $from, Model $to) {
        $chat = new LawyerClientChat;

        return $this->storeAction($chat, $from->id, $to->id, $request->message);
    }

    private function storeAction(&$chat, $from_id, $to_id, $message) {
        $chat->from = $from_id;
        $chat->to = $to_id;
        $chat->message = $message;

        return $chat;
    }

}
