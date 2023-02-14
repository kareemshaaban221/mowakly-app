<?php

namespace App\Interfaces;

use App\Models\Client;

interface ClientRepositoryInterface extends UserRepositoryInterface {

    public function storePaymentMethods(array $methods, Client &$client);

    public function addPaymentMethod($method, Client &$client);

    public function deletePaymentMethod($method, Client &$client);

}
