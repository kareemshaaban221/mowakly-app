<?php

namespace App\Interfaces;

use App\Models\Client;

interface ClientRepositoryInterface extends UserRepositoryInterface {
    public function storePhone(Client $client): bool;

    public function storePaymentMethods(Client $client): bool;
}
