<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\CategoryStoreRequest;
use App\Interfaces\MainCategoryRepositoryInterface;
use Illuminate\Support\Facades\DB;

class MainCategoryController extends Controller
{
    private MainCategoryRepositoryInterface $mainCategoryRepository;

    public function __construct(MainCategoryRepositoryInterface $mainCategoryRepository) {
        $this->mainCategoryRepository = $mainCategoryRepository;
    }

    public function index() {
        ;
    }

    public function store(CategoryStoreRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->all());
        }

        DB::beginTransaction();

        try {

            $category = $this->mainCategoryRepository->storeCategory($request);

            $category->save();

            DB::commit();

            return $response->created(['category' => $category], 'main category');

        } catch (\Throwable $th) {
            DB::rollBack();
            return $response->internalServerError($th->getMessage());
        }
    }
}
