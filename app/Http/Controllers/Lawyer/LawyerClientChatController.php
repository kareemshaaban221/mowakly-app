<?php

namespace App\Http\Controllers\Lawyer;

use App\Http\Controllers\Controller;
use App\Http\Controllers\LawyerClientChatController as ControllersLawyerClientChatController;
use App\Http\Requests\ChatRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\ChatRepositoryInterface;
use Illuminate\Http\Request;

class LawyerClientChatController extends Controller
{
    private $request;
    private $lawyerClientChatController;

    public function __construct(ChatRepositoryInterface $chatRepository) {
        $this->request = new EmailAuthOrGivenRequest;
        $this->lawyerClientChatController = new ControllersLawyerClientChatController($chatRepository);
    }

    public function index($user_id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerClientChatController->index($this->request, $user_id);
    }

    public function store(ChatRequest $request, $user_id) {
        return $this->lawyerClientChatController->store($request, $user_id);
    }
}
