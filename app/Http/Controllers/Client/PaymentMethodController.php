<?php

namespace App\Http\Controllers\Client;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\PaymentMethodStoreRequest;
use App\Interfaces\ClientRepositoryInterface;
use App\Models\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PaymentMethodController extends Controller
{
    public ClientRepositoryInterface $clientRepository;

    public function __construct(ClientRepositoryInterface $clientRepository) {
        $this->clientRepository = $clientRepository;
    }

    public function destroy($email, PaymentMethodStoreRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->all());
        }

        DB::beginTransaction();

        try {
            $client = Client::where('email', $email)->firstOrFail();
            $method = $this->clientRepository->deletePaymentMethod($request->payment_method, $client);

            if(!$method) {
                return $response->badRequest('Payment method is not found!');
            }

            DB::commit();

            return $response->ok([
                'data' => $method,
                'message' => 'Payment method has been deleted successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $response->internalServerError($th->getMessage());
        }
    }

    public function store($email, PaymentMethodStoreRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['attachment']));
        }

        DB::beginTransaction();

        try {
            $client = Client::where('email', $email)->firstOrFail();

            $method = $this->clientRepository->addPaymentMethod($request->payment_method, $client);

            if(!$method) {
                return $response->badRequest('Payment method is not added!');
            }

            DB::commit();

            return $response->ok([
                'data' => $method,
                'message' => 'Payment method has been added successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $response->internalServerError($th->getMessage());
        }
    }
}
