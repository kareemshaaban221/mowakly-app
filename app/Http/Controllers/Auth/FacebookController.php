<?php

namespace App\Http\Controllers\Auth;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Interfaces\ClientRepositoryInterface;
use App\Interfaces\LawyerRepositoryInterface;
use App\Models\Client;
use App\Models\Lawyer;
use Illuminate\Support\Facades\DB;

class FacebookController extends Controller
{
    private LawyerRepositoryInterface $lawyerRepository;
    private ClientRepositoryInterface $clientRepository;
    private Response $response;

    public function __construct(LawyerRepositoryInterface $lawyerRepository, ClientRepositoryInterface $clientRepository) {
        $this->lawyerRepository = $lawyerRepository;
        $this->clientRepository = $clientRepository;
        $this->response = new Response;
    }

    public function access() {
        $link = $this->lawyerRepository->socialiteAccessLink('facebook');

        return $this->response->ok([
            'message' => 'Successful access request. redirect user to attached link below.',
            'link' => $link,
        ]);
    }

    public function callback() {

        if(request()->user_type == 'lawyer') {
            if(request()->register == 'true') {
                // lawyer register with facebook data
                $data = $this->lawyerRepository->socialiteRegisterCallback('facebook', false);

                try {
                    $lawyer = Lawyer::where('email', $data['email'])->first();

                    if($lawyer)
                        return $this->response->badRequest(
                            msg: 'Data is not Valid',
                            err: ['email' => 'This email already exists.'],
                            old: ['email' => $lawyer->email]
                        );

                    return $this->response->ok([
                        'message' => 'Data fetched successfully. Complete data and send it again!',
                        'data' => $data
                    ]);
                } catch (\Throwable $th) {
                    return $this->response->internalServerError($th->getMessage());
                }

            } else {
                // lawyer login with facebook credentials
                $user = $this->lawyerRepository->socialiteLoginCallback('facebook');

                DB::beginTransaction();
                try{
                    $lawyer = Lawyer::where('email', $user['email'])->first();

                    if (!$lawyer)
                        return $this->response->badRequest('This email is not found!');

                    $token = $this->lawyerRepository->generateToken($lawyer);

                    DB::commit();

                    return $this->response->ok([
                        'message' => 'Signed in successfully!',
                        'token' => $token,
                        'data' => $lawyer
                    ]);
                } catch (\Throwable $th) {
                    return $this->response->internalServerError($th->getMessage());
                }
            }
        }


        else if (request()->user_type == 'client') {
            if(request()->register == 'true') {
                // client register with facebook data
                $data = $this->clientRepository->socialiteRegisterCallback('facebook', true);

                try {
                    $client = Client::where('email', $data['email'])->first();

                    if($client)
                        return $this->response->badRequest(
                            msg: 'Data is not Valid',
                            err: ['email' => 'This email already exists.'],
                            old: ['email' => $client->email]
                        );

                    return $this->response->ok([
                        'message' => 'Data fetched successfully. Complete data and send it again!',
                        'data' => $data
                    ]);
                } catch (\Throwable $th) {
                    return $this->response->internalServerError($th->getMessage());
                }
            } else {
                // client login with facebook credentials
                $user = $this->clientRepository->socialiteLoginCallback('facebook');

                DB::beginTransaction();
                try{
                    $client = Client::where('email', $user['email'])->first();

                    if (!$client)
                        return $this->response->badRequest('This email is not found!');

                    $token = $this->clientRepository->generateToken($client);

                    DB::commit();

                    return $this->response->ok([
                        'message' => 'Signed in successfully!',
                        'token' => $token,
                        'data' => $client
                    ]);
                } catch (\Throwable $th) {
                    return $this->response->internalServerError($th->getMessage());
                }
            }
        }

    }
}
