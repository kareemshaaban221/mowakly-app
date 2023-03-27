<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\LawyerRegisterRequest;
use App\Http\Requests\LawyerLoginRequest;
use App\Helpers\Response;
use App\Http\Requests\ResetPasswordCodeRequest;
use App\Http\Requests\ResetPasswordRequest;
use App\Http\Requests\ResetPasswordTokenRequest;
use App\Interfaces\AttachmentRepositoryInterface;
use Illuminate\Support\Facades\DB;
use App\Interfaces\LawyerRepositoryInterface;
use App\Mail\ResetPasswordMail;
use App\Models\Lawyer;
use App\Models\PasswordReset;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;

class AuthLawyerController extends Controller
{
    use \App\Helpers\Functions;

    private LawyerRepositoryInterface $lawyerRepository;
    private AttachmentRepositoryInterface $attachmentRepository;
    private Response $response;

    public function __construct(LawyerRepositoryInterface $lawyerRepository, AttachmentRepositoryInterface $attachmentRepository) {
        $this->lawyerRepository = $lawyerRepository;
        $this->attachmentRepository = $attachmentRepository;
        $this->response = new Response;
    }

    public function register(LawyerRegisterRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['password', 'password_confirmation', 'card', 'avatar', 'attachments']));
        }

        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->store($request);

            $lawyer->save();

            $this->lawyerRepository->storeAvatar($request->avatar, $lawyer);
            $this->lawyerRepository->storeCard($request->card, $lawyer);

            $lawyer->save();

            if(is_null($this->sendVerificationLink($lawyer))) {
                throw new \Exception('Error sending verification link!');
            }

            // phones and attachments
            $this->lawyerRepository->storePhones($request->phones, $lawyer);
            $this->attachmentRepository->storeAttachments($request->attachments, $lawyer);

            if(isset($request->subcategories))
                foreach ($request->subcategories as $subcategory) {
                    $this->lawyerRepository->storeSubcategory($subcategory, $lawyer);
                }

            $token = $this->lawyerRepository->generateToken($lawyer);

            DB::commit();

            return $this->response->created(['data' => $lawyer, 'token' => $token], 'lawyer');
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function login(LawyerLoginRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['password']));
        }

        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->checkCredentials($request->validated());

            if(!$lawyer) {
                return $this->response->forbidden('Wrong password!');
            }

            $token = $this->lawyerRepository->generateToken($lawyer);

            DB::commit();

            return $this->response->ok([
                'message' => 'Signed in successfully!',
                'token' => $token,
                'data' => $lawyer
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function logout() {
        $query = auth()->user()->tokens()->where('name', 'lawyer-'.auth()->user()->id);
        $tokens = $query->get();

        if($tokens->isEmpty())
            return $this->response->notAuthorized('Unauthenticated. (Wrong user type)');

        $query->delete();
        return $this->response->ok([
            'message' => 'Signed out successfully!',
        ]);
    }

    public function verificationLink() {
        $result = $this->sendVerificationLink(auth()->user(), auth: 'lawyer');
        if($result) {
            if($result == 'verified') {
                return $this->response->ok([
                    'message' => 'This account was verified!'
                ]);
            } else {
                return $this->response->ok([
                    'message' => 'Verification link has been sent successfully!'
                ]);
            }
        }

        return $this->response->internalServerError('Error while sending verification link!');
    }

    public function verify(Request $request, $token) {
        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->verifyEmail($request, $token);

            if(!$lawyer)
                return $this->response->badRequest('Token is invalid!');

            $lawyer->save();

            DB::commit();

            return $this->response->ok([
               'message' => 'Email verified successfully!',
               'data' => $lawyer
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function resetPasswordCode(ResetPasswordCodeRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $user = Lawyer::where('email', $request->email)->first();

            $res = $this->sendResetPasswordCode($user, 'lawyer');

            if(!$res) {
                throw new \Exception('Error while sending reset password code!');
            }

            DB::commit();

            return $this->response->ok([
                'message' => 'Reset password code has been sent successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function resetPasswordToken(ResetPasswordTokenRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $user = Lawyer::where('email', $request->email)->first();

            $res = $this->checkResetPasswordCode($user, $request->code, 'lawyer');

            if(is_int($res)) {
                if($res == -1)
                    return $this->response->badRequest('Request code or email is invalid!');

                if($res == -2)
                    return $this->response->badRequest('Code is wrong! Check email and try again!');

                if($res == -3)
                    return $this->response->badRequest('Code is expired!');
            }

            DB::commit();

            return $this->response->ok([
                'token' => $res->token,
                'message' => 'Reset password token has been sent successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function resetPassword(ResetPasswordRequest $request, $token) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $request->email)->first();

            $res = $this->lawyerRepository->resetPassword($request->new_password, $token, $lawyer, request()->user_type);

            if($res == -1)
                return $this->response->badRequest('Email is invalid! Please generate code/token first!');
            if($res == -2)
                return $this->response->badRequest('Token is invalid!');

            $lawyer->save();

            DB::commit();

            return $this->response->ok([
               'message' => 'Password has been resetted successfully!',
               'data' => $lawyer
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
