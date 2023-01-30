<?php

namespace App\Http\Controllers\Auth;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Interfaces\ClientRepositoryInterface;
use App\Interfaces\LawyerRepositoryInterface;
use App\Models\Client;
use App\Models\Lawyer;
use Illuminate\Support\Facades\DB;
use Laravel\Socialite\Facades\Socialite;

class GoogleController extends Controller
{

    public LawyerRepositoryInterface $lawyerRepository;
    public ClientRepositoryInterface $clientRepository;

    public function __construct(LawyerRepositoryInterface $lawyerRepository, ClientRepositoryInterface $clientRepository) {
        $this->lawyerRepository = $lawyerRepository;
        $this->clientRepository = $clientRepository;
    }
    public function access($response = new Response) {
        $link = $this->lawyerRepository->socialiteAccessLink('google');

        return $response->ok([
            'message' => 'Successful access request. redirect user to attached link below.',
            'link' => $link,
        ]);
    }

    public function callback($response = new Response) {

        if(request()->user_type == 'lawyer') {
            if(request()->register == 'true') {
                // lawyer register with google data
                $data = $this->lawyerRepository->socialiteRegisterCallback('google');

                return $response->ok([
                    'message' => 'Data fetched successfully. Complete data and send it again!',
                    'data' => $data
                ]);
            } else {
                // lawyer login with google credentials
                $user = $this->lawyerRepository->socialiteLoginCallback('google');

                DB::beginTransaction();
                try{
                    $lawyer = Lawyer::where('email', $user['email'])->firstOrFail();

                    $token = $this->lawyerRepository->generateToken($lawyer);

                    DB::commit();

                    return $response->ok([
                        'message' => 'Signed in successfully!',
                        'token' => $token,
                        'data' => $lawyer
                    ]);
                } catch (\Throwable $th) {
                    return $response->internalServerError($th->getMessage());
                }
            }
        }


        else if (request()->user_type == 'client') {
            if(request()->register == 'true') {
                // client register with google data
                $data = $this->clientRepository->socialiteRegisterCallback('google');

                return $response->ok([
                    'message' => 'Data fetched successfully. Complete data and send it again!',
                    'data' => $data
                ]);
            } else {
                // client login with google credentials
                $user = $this->clientRepository->socialiteLoginCallback('google');

                DB::beginTransaction();
                try{
                    $client = Client::where('email', $user['email'])->firstOrFail();

                    $token = $this->clientRepository->generateToken($client);

                    DB::commit();

                    return $response->ok([
                        'message' => 'Signed in successfully!',
                        'token' => $token,
                        'data' => $client
                    ]);
                } catch (\Throwable $th) {
                    return $response->internalServerError($th->getMessage());
                }
            }
        }

    }
}
