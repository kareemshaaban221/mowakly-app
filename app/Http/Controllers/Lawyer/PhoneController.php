<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\PhoneStoreRequest;
use App\Interfaces\LawyerRepositoryInterface;
use App\Models\Lawyer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PhoneController extends Controller
{
    public LawyerRepositoryInterface $lawyerRepository;
    private Response $response;

    public function __construct(LawyerRepositoryInterface $lawyerRepository) {
        $this->lawyerRepository = $lawyerRepository;
        $this->response = new Response;
    }

    public function destroy(EmailAuthOrGivenRequest $request, $phone_num) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();
            $phone = $this->lawyerRepository->deletePhone($phone_num, $lawyer);

            if(is_int($phone) && $phone == 0) {
                return $this->response->badRequest('Phone is not found!');
            }

            if(is_int($phone) && $phone == 1) {
                return $this->response->badRequest('Phones cannot be less than one!');
            }

            DB::commit();

            return $this->response->ok([
                'data' => $phone,
                'message' => 'Phone has been deleted successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store(PhoneStoreRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['attachment']));
        }

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();

            $phone = $this->lawyerRepository->addPhone($request->phone, $lawyer);

            if(!$phone) {
                return $this->response->badRequest('Phone is not added!');
            }

            DB::commit();

            return $this->response->ok([
                'data' => $phone,
                'message' => 'Phone has been added successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
