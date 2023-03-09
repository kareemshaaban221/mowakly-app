<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\SubcategoryStoreRequest;
use App\Interfaces\SubcategoryRepositoryInterface;
use App\Models\Subcategory;
use Illuminate\Support\Facades\DB;

class SubcategoryController extends Controller
{
    private SubcategoryRepositoryInterface $subcategoryRepository;
    private Response $response;

    public function __construct(SubcategoryRepositoryInterface $subcategoryRepository) {
        $this->subcategoryRepository = $subcategoryRepository;
        $this->response = new Response;
    }

    public function index() {
        return Subcategory::all();
    }

    public function store(SubcategoryStoreRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $this->subcategoryRepository->storeSubcategory($request);

            DB::commit();

            return $this->response->created([], 'subcategories');

        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
