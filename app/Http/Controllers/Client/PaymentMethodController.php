<?php

namespace App\Http\Controllers\Client;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\PaymentMethodStoreRequest;
use App\Interfaces\ClientRepositoryInterface;
use App\Models\Client;
use Illuminate\Support\Facades\DB;

class PaymentMethodController extends Controller
{
    private ClientRepositoryInterface $clientRepository;
    private Response $response;

    public function __construct(ClientRepositoryInterface $clientRepository) {
        $this->clientRepository = $clientRepository;
        $this->response = new Response;
    }

    public function destroy(EmailAuthOrGivenRequest $request, $payment_method) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $client = Client::where('email', $request->email)->firstOrFail();
            $method = $this->clientRepository->deletePaymentMethod($payment_method, $client);

            if(!$method) {
                return $this->response->badRequest('Payment method is not found!');
            }

            DB::commit();

            return $this->response->ok([
                'data' => $method,
                'message' => 'Payment method has been deleted successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store(PaymentMethodStoreRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['attachment']));
        }

        DB::beginTransaction();

        try {
            $client = Client::where('email', $request->email)->firstOrFail();

            $method = $this->clientRepository->addPaymentMethod($request->payment_method, $client);

            if(!$method) {
                return $this->response->badRequest('Payment method is not added!');
            }

            DB::commit();

            return $this->response->ok([
                'data' => $method,
                'message' => 'Payment method has been added successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
