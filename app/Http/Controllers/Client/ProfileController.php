<?php

namespace App\Http\Controllers\Client;

use App\Http\Controllers\ClientController;
use App\Http\Controllers\Controller;
use App\Http\Requests\ClientUpdateRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\PaymentMethodStoreRequest;
use App\Interfaces\ClientRepositoryInterface;
use App\Repositories\ClientRepository;

class ProfileController extends Controller
{
    private EmailAuthOrGivenRequest $request;
    private ClientController $clientController;
    private PaymentMethodController $paymentMethodController;

    public function __construct(ClientRepositoryInterface $clientRepository) {
        $this->clientController = new ClientController($clientRepository);
        $this->request = new EmailAuthOrGivenRequest;
        $this->paymentMethodController = new PaymentMethodController($clientRepository);
    }

    public function index() {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->clientController->show($this->request);
    }

    public function update(ClientUpdateRequest $request) {
        return $this->clientController->update($request);
    }

    public function addPaymentMethod(PaymentMethodStoreRequest $request) {
        return $this->paymentMethodController->store($request);
    }

    public function destroyPaymentMethod($payment_method) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->paymentMethodController->destroy($this->request, $payment_method);
    }

    public function destroy() {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->clientController->destroy($this->request);
    }
}
