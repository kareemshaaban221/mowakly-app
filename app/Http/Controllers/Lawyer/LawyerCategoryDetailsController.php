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
    public function store(LawyerCategoryDetailsRequest $request, $response = new Response) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->all());
        }

        DB::beginTransaction();

        try {
            $lawyer = Lawyer::where('email', $request->email)->first();
            if(!$lawyer)
                return $response->badRequest('Lawyer email is not found!');

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
                return $response->badRequest('This category is not found for this lawyer!');

            DB::table('lawyer_main_categories')
                ->where('m_category_id', $lawyer_category_target->category->id)
                ->where('lawyer_id', $lawyer->id)
                ->update([
                    'price_of_consultation' => $request->price_of_consultation,
                    'mean_of_consultation' => $request->mean_of_consultation,
                ]);

            DB::commit();

            return $response->ok(['message' => 'Consultation details was added successfully!']);
        } catch (\Throwable $th) {
            DB::rollBack();
            return $response->internalServerError($th->getMessage());
        }
    }
}
