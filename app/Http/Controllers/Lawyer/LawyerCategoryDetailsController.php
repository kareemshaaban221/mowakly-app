<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\LawyerCategoryDetailsRequest;
use App\Models\Lawyer;
use App\Models\LawyerMainCategory;
use Illuminate\Support\Facades\DB;

class LawyerCategoryDetailsController extends Controller
{
    private Response $response;

    public function __construct() {
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

            $lawyer_categories = LawyerMainCategory::where('lawyer_id', $lawyer->id)->get();
            $lawyer_category_target = NULL;
            foreach($lawyer_categories as $lawyer_category) {
                $category = $lawyer_category->category;
                if($category->name == $request->category) {
                    $lawyer_category_target = $lawyer_category;
                    break;
                }
            }

            if(is_null($lawyer_category_target))
                return $this->response->badRequest('This category is not found for this lawyer!');

            DB::table('lawyer_main_categories')
                ->where('m_category_id', $lawyer_category_target->category->id)
                ->where('lawyer_id', $lawyer->id)
                ->update([
                    'price_of_consultation' => $request->price_of_consultation,
                    'mean_of_consultation' => $request->mean_of_consultation,
                ]);

            DB::commit();

            return $this->response->ok(['message' => 'Consultation details was added successfully!']);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
