<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\LawyerRegisterRequest;
use App\Http\Requests\LawyerLoginRequest;
use App\Helpers\Response;
use Illuminate\Support\Facades\DB;
use App\Interfaces\LawyerRepositoryInterface;
use Illuminate\Http\Request;

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

            if(is_null($this->sendVerificationLink($lawyer))) {
                throw new \Exception('Error sending verification link!');
            }

            $lawyer->save();

            // phones and attachments
            $this->lawyerRepository->storePhones($request->phones, $lawyer);
            $this->lawyerRepository->storeAttachments($request->attachments, $lawyer);

            if(isset($request->subcategories))
                foreach ($request->subcategories as $subcategory) {
                    $this->lawyerRepository->storeSubcategory($subcategory, $lawyer);
                }

            foreach ($request->categories as $category) {
                if(is_null($this->lawyerRepository->storeCategory($category, $lawyer))) {
                    throw new \Exception('This category is not found!');
                }
            }

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
            return $response->internalServerError($th->getMessage());
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

    public function verificationLink($response = new Response) {
        $result = $this->sendVerificationLink(auth()->user(), auth: 'lawyer');
        if($result) {
            if($result == 'verified') {
                return $response->ok([
                    'message' => 'This account was verified!'
                ]);
            } else {
                return $response->ok([
                    'message' => 'Verification link has been sent successfully!'
                ]);
            }
        }

        return $response->internalServerError('Error while sending verification link!');
    }

    public function verify(Request $request, $token, $response = new Response) {
        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->verifyEmail($request, $token);

            if(!$lawyer)
                return $response->badRequest('Token is invalid!');

            $lawyer->save();

            DB::commit();

            return $response->ok([
               'message' => 'Email verified successfully!',
               'data' => $lawyer
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $response->internalServerError($th->getMessage());
        }
    }
}
