<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\AttachmentDestroyRequest;
use App\Http\Requests\AttachmentStoreRequest;
use App\Interfaces\LawyerRepositoryInterface;
use App\Models\Lawyer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AttachmentController extends Controller
{
    public LawyerRepositoryInterface $lawyerRepository;

    public function __construct(LawyerRepositoryInterface $lawyerRepository) {
        $this->lawyerRepository = $lawyerRepository;
    }

    public function destroy($email, AttachmentDestroyRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->all());
        }

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $email)->firstOrFail();
            $attachment = $this->lawyerRepository->deleteAttachment($request->filename, $lawyer);

            if(is_int($attachment) && $attachment == 0) {
                return $response->badRequest('Attachment is not found!');
            }

            if(is_int($attachment) && $attachment == 1) {
                return $response->badRequest('Attachments cannot be less than one!');
            }

            DB::commit();

            return $response->ok([
                'data' => $attachment,
                'message' => 'Attachment has been deleted successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $response->internalServerError($th->getMessage());
        }
    }

    public function store($email, AttachmentStoreRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['attachment']));
        }

        $file = $request->file('attachment');

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $email)->firstOrFail();

            $attachment = $this->lawyerRepository->addAttachment($file, $lawyer);

            if(!$attachment) {
                return $response->badRequest('Attachment is not added successfully!');
            }

            DB::commit();

            return $response->ok([
                'data' => $attachment,
                'message' => 'Attachment has been added successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $response->internalServerError($th->getMessage());
        }
    }
}
