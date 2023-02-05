<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Requests\LawyerRegisterRequest;
use App\Http\Requests\LawyerUpdateRequest;
use App\Interfaces\LawyerRepositoryInterface;
use App\Models\Lawyer;
use App\Models\VerifyEmail;
use Illuminate\Support\Facades\DB;

class LawyerController extends Controller
{
    public LawyerRepositoryInterface $lawyerRepository;

    public function index($response = new Response)
    {
        $lawyers = Lawyer::all();

        return $response->ok([
            'data' => $lawyers,
            'message' => 'All lawyers!'
        ]);
    }

    public function store(LawyerRegisterRequest $request, $response = new Response)
    {
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

            DB::commit();

            return $response->created(['data' => $lawyer], 'lawyer');
        } catch (\Throwable $th) {
            DB::rollback();
            return $response->internalServerError($th->getMessage());
        }
    }

    public function show($email, $response = new Response)
    {
        $lawyer = Lawyer::where('email', $email)->first();

        if(!$lawyer) {
            return $response->notFound(obj: 'lawyer');
        }

        return $response->ok([
            'data' => $lawyer,
            'message' => 'Lawyer is found!',
        ]);
    }

    public function update(LawyerUpdateRequest $request, $email, $response = new Response)
    {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['password', 'password_confirmation', 'card', 'avatar', 'attachments']));
        }

        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->update($request, $email);

            isset($request->avatar) ? $this->lawyerRepository->updateAvatar($request->avatar, $lawyer) : null;
            isset($request->card) ? $this->lawyerRepository->updateCard($request->card, $lawyer) : null;

            $lawyer->save();

            DB::commit();

            return $response->ok([
                'data' => $lawyer,
                'message' => 'Lawyer has been updated successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $response->internalServerError($th->getMessage());
        }
    }

    public function destroy($email, $response = new Response)
    {
        $lawyer = Lawyer::where('email', $email)->first();
        $lawyer->tokens()->where('name', 'lawyer-' . $lawyer->id)->delete();
        VerifyEmail::where('email', $email)->where('user_type', 'lawyer')->delete();

        $lawyer->delete();

        return $response->ok(['data' => $lawyer, 'message' => 'Lawyer has been deleted successfully!']);
    }
}
