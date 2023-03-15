<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\LawyerCategoryDetailsRequest;
use App\Interfaces\LawyerMainCategoryRepositoryInterface;
use App\Models\Lawyer;
use App\Models\LawyerMainCategory;
use App\Models\LawyerSubcategory;
use App\Models\MainCategory;
use App\Models\Subcategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LawyerMainCategoryController extends Controller
{
    private LawyerMainCategoryRepositoryInterface $lawyerMainCategoryRepository;
    private Response $response;

    public function __construct(LawyerMainCategoryRepositoryInterface $lawyerMainCategoryRepository) {
        $this->lawyerMainCategoryRepository = $lawyerMainCategoryRepository;
        $this->response = new Response;
    }

    public function store(LawyerCategoryDetailsRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $request->email)->first();
            if(!$lawyer)
                return $this->response->badRequest('Lawyer email is not found!');

            $created_lawyer_category_fields = $this->lawyerMainCategoryRepository->store($request, $lawyer);

            if(is_null($created_lawyer_category_fields)) {
                DB::rollBack();
                return $this->response->badRequest('This category and mean of consultation were already added together or duplicated!');
            }

            if($created_lawyer_category_fields == -1)
                return $this->response->badRequest('Invalid input!');

            DB::commit();

            return $this->response->ok([
                'data' => $created_lawyer_category_fields,
                'message' => 'Consultation details was added successfully!'
            ]);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function update(LawyerCategoryDetailsRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $request->email)->first();
            if(!$lawyer)
                return $this->response->badRequest('Lawyer email is not found!');

            $res = $this->lawyerMainCategoryRepository->update($request, $lawyer);

            if($res == -1)
                return $this->response->badRequest('Invalid input!');

            DB::commit();

            return $this->response->ok(['message' => 'Consultation details was updated successfully!']);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function destroy(EmailAuthOrGivenRequest $request, $id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $lawyer = Lawyer::where('email', $request->email)->first();

            $count = $this->lawyerMainCategoryRepository->deleteByCategoryId($id, $lawyer);

            if(!$count)
                return $this->response->badRequest('Nothing to delete!');

            DB::commit();

            return $this->response->ok([
                'count' => $count,
                'message' => 'Categories have been deleted successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function destroySpecific(EmailAuthOrGivenRequest $request, $id, $mean) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $lawyer = Lawyer::where('email', $request->email)->first();

            $count = $this->lawyerMainCategoryRepository->deleteSpecific($id, $mean, $lawyer);

            if($count == 0)
                return $this->response->badRequest('Nothing to delete!');

            DB::commit();

            return $this->response->ok([
                'count' => $count,
                'message' => 'Category has been deleted successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function show(EmailAuthOrGivenRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        $lawyer = Lawyer::where('email', $request->email)->first();
        // dd($lawyer->categories->unique()->toarray());
        $data = LawyerMainCategory::where('lawyer_id', $lawyer->id)->get();

        return $this->response->ok([
            'data' => $data,
            'message' => "All main categories and consultation prices of lawyer $lawyer->fname $lawyer->lname!"
        ]);
    }

    public function showByCategory(EmailAuthOrGivenRequest $request, $id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        $lawyer = Lawyer::where('email', $request->email)->first();
        $data = LawyerMainCategory::where('lawyer_id', $lawyer->id)->where('m_category_id', $id)->get();

        return $this->response->ok([
            'data' => $data,
            'category' => $data[0]->category,
            'message' => "All consultation prices of lawyer $lawyer->fname $lawyer->lname in category `{$data[0]->category->name}`!"
        ]);
    }

    public function showByConsultationMean(EmailAuthOrGivenRequest $request, $mean) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        $lawyer = Lawyer::where('email', $request->email)->first();
        $data = LawyerMainCategory::where('lawyer_id', $lawyer->id)->where('mean_of_consultation', $mean)->get();

        return $this->response->ok([
            'data' => $data,
            'message' => "All consultation prices of lawyer $lawyer->fname $lawyer->lname by mean $mean!"
        ]);
    }

    public function showSpecific(EmailAuthOrGivenRequest $request, $id, $mean) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        $lawyer = Lawyer::where('email', $request->email)->first();
        $category = MainCategory::find($id);
        $data = LawyerMainCategory::where('lawyer_id', $lawyer->id)
            ->where('m_category_id', $id)
            ->where('mean_of_consultation', $mean)
            ->get();

        return $this->response->ok([
            'data' => $data,
            'message' => "Consultation by $mean price of lawyer $lawyer->fname $lawyer->lname in category `$category->name`!"
        ]);
    }
}
