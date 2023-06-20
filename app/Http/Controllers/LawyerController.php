<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\LawyerRegisterRequest;
use App\Http\Requests\LawyerUpdateRequest;
use App\Http\Requests\UserDestroyRequest;
use App\Interfaces\AttachmentRepositoryInterface;
use App\Interfaces\LawyerRepositoryInterface;
use App\Models\Lawyer;
use Illuminate\Support\Facades\DB;

class LawyerController extends Controller
{
    private LawyerRepositoryInterface $lawyerRepository;
    private AttachmentRepositoryInterface $attachmentRepository;
    private Response $response;

    public function __construct(LawyerRepositoryInterface $lawyerRepository, AttachmentRepositoryInterface $attachmentRepository) {
        $this->lawyerRepository = $lawyerRepository;
        $this->attachmentRepository = $attachmentRepository;
        $this->response = new Response;
    }

    public function index()
    {
        $lawyers = Lawyer::with(['categories', 'subcategories'])->get();

        return $this->response->ok([
            'data' => $lawyers,
            'message' => 'All lawyers!'
        ]);
    }

    public function store(LawyerRegisterRequest $request)
    {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['password', 'password_confirmation', 'card', 'avatar', 'attachments']));
        }

        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->store($request);

            $this->lawyerRepository->storeAvatar($request->avatar, $lawyer);
            $this->lawyerRepository->storeCard($request->card, $lawyer);
            $lawyer->save();

            // phones and attachments
            $this->lawyerRepository->storePhones($request->phones, $lawyer);
            $this->attachmentRepository->storeAttachments($request->attachments, $lawyer);

            DB::commit();

            return $this->response->created(['data' => $lawyer], 'lawyer');
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function show(EmailAuthOrGivenRequest $request)
    {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['password', 'password_confirmation', 'card', 'avatar', 'attachments']));
        }
        $lawyer = Lawyer::where('email', $request->email)->first();

        if(!$lawyer) {
            return $this->response->notFound(obj: 'lawyer');
        }

        return $this->response->ok([
            'data' => $lawyer,
            'message' => 'Lawyer is found!',
        ]);
    }

    public function update(LawyerUpdateRequest $request)
    {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['password', 'password_confirmation', 'card', 'avatar', 'attachments']));
        }

        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->update($request, $request->email);

            $request->has('avatar') ? $this->lawyerRepository->updateAvatar($request->avatar, $lawyer) : null;
            $request->has('card') ? $this->lawyerRepository->updateCard($request->card, $lawyer) : null;

            $lawyer->save();

            DB::commit();

            return $this->response->ok([
                'data' => $lawyer,
                'message' => 'Lawyer has been updated successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function destroy(EmailAuthOrGivenRequest $request)
    {
        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->destroy($request->email);

            DB::commit();

            return $this->response->ok(['data' => $lawyer, 'message' => 'Lawyer has been deleted successfully!']);
        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
