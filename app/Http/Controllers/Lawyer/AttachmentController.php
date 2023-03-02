<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\AttachmentDestroyRequest;
use App\Http\Requests\AttachmentStoreRequest;
use App\Interfaces\AttachmentRepositoryInterface;
use App\Interfaces\LawyerRepositoryInterface;
use App\Models\Lawyer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AttachmentController extends Controller
{
    private AttachmentRepositoryInterface $attachmentRepository;
    private Response $response;

    public function __construct(AttachmentRepositoryInterface $attachmentRepository) {
        $this->attachmentRepository = $attachmentRepository;
        $this->response = new Response;
    }

    public function destroy(AttachmentDestroyRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();
            $attachment = $this->attachmentRepository->deleteAttachment($request->filename, $lawyer);

            if(is_int($attachment) && $attachment == 0) {
                return $this->response->badRequest('Attachment is not found!');
            }

            if(is_int($attachment) && $attachment == 1) {
                return $this->response->badRequest('Attachments cannot be less than one!');
            }

            DB::commit();

            return $this->response->ok([
                'data' => $attachment,
                'message' => 'Attachment has been deleted successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store(AttachmentStoreRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['attachment']));
        }

        $file = $request->file('attachment');

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();

            $attachment = $this->attachmentRepository->addAttachment($file, $lawyer);

            if(!$attachment) {
                return $this->response->badRequest('Attachment is not added successfully!');
            }

            DB::commit();

            return $this->response->ok([
                'data' => $attachment,
                'message' => 'Attachment has been added successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
