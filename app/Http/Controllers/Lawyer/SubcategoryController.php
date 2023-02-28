<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\SubcategoryStoreRequest;
use App\Interfaces\SubcategoryRepositoryInterface;
use Illuminate\Support\Facades\DB;

class SubcategoryController extends Controller
{
    private SubcategoryRepositoryInterface $subcategoryRepository;
    private Response $response;

    public function __construct(SubcategoryRepositoryInterface $subcategoryRepository) {
        $this->subcategoryRepository = $subcategoryRepository;
        $this->response = new Response;
    }

    public function store(SubcategoryStoreRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $subcategory = $this->subcategoryRepository->storeSubcategory($request);

            $subcategory->save();

            DB::commit();

            return $this->response->created(['subcategory' => $subcategory], 'subcategory');

        } catch (\Throwable $th) {
            DB::rollback();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
