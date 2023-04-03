<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\ClientLawyerChatController as ControllersClientLawyerChatController;
use App\Http\Controllers\Controller;
use App\Http\Requests\ChatRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\ChatRepositoryInterface;
use Illuminate\Http\Request;

class ClientLawyerChatController extends Controller
{
    private $request;
    private $clientLawyerChatController;

    public function __construct(ChatRepositoryInterface $chatRepository) {
        $this->request = new EmailAuthOrGivenRequest;
        $this->clientLawyerChatController = new ControllersClientLawyerChatController($chatRepository);
    }

    public function index($user_id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->clientLawyerChatController->index($this->request, $user_id);
    }

    public function store(ChatRequest $request, $user_id) {
        return $this->clientLawyerChatController->store($request, $user_id);
    }
}
