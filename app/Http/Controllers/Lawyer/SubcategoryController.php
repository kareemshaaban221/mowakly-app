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

    public function __construct(SubcategoryRepositoryInterface $subcategoryRepository) {
        $this->subcategoryRepository = $subcategoryRepository;
    }

    public function store(SubcategoryStoreRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->all());
        }

        DB::beginTransaction();

        try {

            $subcategory = $this->subcategoryRepository->storeSubcategory($request);

            $subcategory->save();

            DB::commit();

            return $response->created(['subcategory' => $subcategory], 'subcategory');

        } catch (\Throwable $th) {
            DB::rollback();
            return $response->internalServerError($th->getMessage());
        }
    }
}
