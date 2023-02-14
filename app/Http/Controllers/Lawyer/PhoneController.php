<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\PhoneStoreRequest;
use App\Interfaces\LawyerRepositoryInterface;
use App\Models\Lawyer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PhoneController extends Controller
{
    public LawyerRepositoryInterface $lawyerRepository;

    public function __construct(LawyerRepositoryInterface $lawyerRepository) {
        $this->lawyerRepository = $lawyerRepository;
    }

    public function destroy($email, PhoneStoreRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->all());
        }

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $email)->firstOrFail();
            $phone = $this->lawyerRepository->deletePhone($request->phone, $lawyer);

            if(is_int($phone) && $phone == 0) {
                return $response->badRequest('Phone is not found!');
            }

            if(is_int($phone) && $phone == 1) {
                return $response->badRequest('Phones cannot be less than one!');
            }

            DB::commit();

            return $response->ok([
                'data' => $phone,
                'message' => 'Phone has been deleted successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $response->internalServerError($th->getMessage());
        }
    }

    public function store($email, PhoneStoreRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['attachment']));
        }

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $email)->firstOrFail();

            $phone = $this->lawyerRepository->addPhone($request->phone, $lawyer);

            if(!$phone) {
                return $response->badRequest('Phone is not added!');
            }

            DB::commit();

            return $response->ok([
                'data' => $phone,
                'message' => 'Phone has been added successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $response->internalServerError($th->getMessage());
        }
    }
}
