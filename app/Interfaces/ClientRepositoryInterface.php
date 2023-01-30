<?php

namespace App\Interfaces;

use App\Models\Client;

interface ClientRepositoryInterface extends UserRepositoryInterface {

    public function storePaymentMethods(array $methods, Client &$client);

}
