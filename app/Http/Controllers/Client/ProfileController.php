<?php

namespace App\Http\Controllers\Client;

use App\Http\Requests\ClientUpdateRequest;
use App\Http\Requests\PaymentMethodStoreRequest;
use App\Repositories\ClientRepository;

class ProfileController extends ClientController
{
    public function showProfile() {
        return parent::show(auth()->user()->email);
    }

    public function updateProfile(ClientUpdateRequest $request) {
        return parent::update($request, auth()->user()->email);
    }

    public function addPaymentMethod(PaymentMethodStoreRequest $request) {
        return (new PaymentMethodController(new ClientRepository))->store(auth()->user()->email, $request);
    }

    public function destroyPaymentMethod(PaymentMethodStoreRequest $request) {
        return (new PaymentMethodController(new ClientRepository))->destroy(auth()->user()->email, $request);
    }
}
