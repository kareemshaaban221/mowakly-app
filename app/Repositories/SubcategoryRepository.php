<?php

namespace App\Repositories;
use App\Interfaces\SubcategoryRepositoryInterface;
use App\Models\MainCategory;
use App\Models\Subcategory;
use Carbon\Carbon;
use Illuminate\Http\Request;

class SubcategoryRepository implements SubcategoryRepositoryInterface {

	public function storeSubcategory(Request $request) {
        $data = $request->validated();

        // get all maincategories in the request
        $m_categories = [];
        foreach ($data['subcategories'] as $subcategory) {
            array_push($m_categories, $subcategory['parent_category']);
        }
        // turn main categories into models
        $m_categories = MainCategory::whereIn('name', $m_categories)->get();

        $subcategories = [];
        foreach ($data['subcategories'] as $subcategory) {
            array_push($subcategories, [
                'name' => $subcategory['subcategory'],
                'm_category_id' => $m_categories->where('name', $subcategory['parent_category'])->first()->id,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now()
            ]);
        }

        return Subcategory::insert($subcategories);
	}
}
