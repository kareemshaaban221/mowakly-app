<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\LawyerSubcategoryRequest;
use App\Interfaces\LawyerSubcategoryRepositoryInterface;
use App\Models\Lawyer;
use App\Models\LawyerSubcategory;
use Illuminate\Support\Facades\DB;

class LawyerSubcategoryController extends Controller
{
    private LawyerSubcategoryRepositoryInterface $lawyerSubcategoryRepository;
    private Response $response;

    public function __construct(LawyerSubcategoryRepositoryInterface $lawyerSubcategoryRepository) {
        $this->lawyerSubcategoryRepository = $lawyerSubcategoryRepository;
        $this->response = new Response;
    }

    public function index(EmailAuthOrGivenRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $lawyer = Lawyer::where('email', $request->email)->first();
            if(!$lawyer)
                return $this->response->badRequest('Lawyer email is not found!');

            $data = LawyerSubcategory::where('lawyer_id', $lawyer->id)->get();

            DB::commit();

            return $this->response->ok([
                'data' => $data,
                'message' => "All subcategories associated with this lawyer!",
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store(LawyerSubcategoryRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $lawyer = Lawyer::where('email', $request->email)->first();
            if(!$lawyer)
                return $this->response->badRequest('Lawyer email is not found!');

            $res = $this->lawyerSubcategoryRepository->store($request, $lawyer);

            if(is_null($res)) {
                return $this->response->badRequest('One of subcategories is already associated to this lawyer!');
            }

            if(!$res) {
                return $this->response->badRequest('Main category of a subcategory is not added to this lawyer!');
            }

            DB::commit();

            return $this->response->ok([
                'message' => "Subcategories has been added to this lawyer successfully!",
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function destroy(EmailAuthOrGivenRequest $request, $subcategory_id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $lawyer = Lawyer::where('email', $request->email)->first();
            if(!$lawyer)
                return $this->response->badRequest('Lawyer email is not found!');

            $count = $this->lawyerSubcategoryRepository->deleteBySubcategoryId($subcategory_id, $lawyer);

            if(!$count)
                return $this->response->badRequest('Nothing to delete!');

            DB::commit();

            return $this->response->ok([
                'count' => $count,
                'message' => 'Subcategory has been deleted successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
