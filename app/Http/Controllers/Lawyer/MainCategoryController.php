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
    private Response $response;

    public function __construct(MainCategoryRepositoryInterface $mainCategoryRepository) {
        $this->mainCategoryRepository = $mainCategoryRepository;
        $this->response = new Response;
    }

    public function index() {
        ;
    }

    public function store(CategoryStoreRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $category = $this->mainCategoryRepository->storeCategory($request);

            $category->save();

            DB::commit();

            return $this->response->created(['category' => $category], 'main category');

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
