<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\LawyerRegisterRequest;
use App\Http\Requests\LawyerLoginRequest;
use App\Helpers\Response;
use Illuminate\Support\Facades\DB;
use App\Interfaces\LawyerRepositoryInterface;

class AuthLawyerController extends Controller
{
    use \App\Helpers\Functions;

    private LawyerRepositoryInterface $lawyerRepository;

    public function __construct(LawyerRepositoryInterface $lawyerRepository) {
        $this->lawyerRepository = $lawyerRepository;
    }

    public function register(LawyerRegisterRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['password', 'password_confirmation', 'card', 'avatar', 'attachments']));
        }

        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->store($request);

            $this->lawyerRepository->storeAvatar($request->avatar, $lawyer);
            $this->lawyerRepository->storeCard($request->card, $lawyer);
            $lawyer->save();

            // phones and attachments
            $this->lawyerRepository->storePhones($request->phones, $lawyer);
            $this->lawyerRepository->storeAttachments($request->attachments, $lawyer);

            $token = $this->lawyerRepository->generateToken($lawyer);

            DB::commit();

            return $response->created(['data' => $lawyer, 'token' => $token], 'lawyer');
        } catch (\Throwable $th) {
            DB::rollback();
            return $response->internalServerError($th->getMessage());
        }
    }

    public function login(LawyerLoginRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['password']));
        }

        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->checkCredentials($request->validated());

            if(!$lawyer) {
                return $response->forbidden('Wrong password!');
            }

            $token = $this->lawyerRepository->generateToken($lawyer);

            DB::commit();

            return $response->ok([
                'message' => 'Signed in successfully!',
                'token' => $token,
                'data' => $lawyer
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $response->badRequest('An error occured!', $th->getMessage());
        }
    }

    public function logout($response = new Response) {
        $query = auth()->user()->tokens()->where('name', 'lawyer-'.auth()->user()->id);
        $tokens = $query->get();

        if($tokens->isEmpty())
            return $response->notAuthorized('Unauthenticated. (Wrong user type)');

        $query->delete();
        return $response->ok([
            'message' => 'Signed out successfully!',
        ]);
    }
}
