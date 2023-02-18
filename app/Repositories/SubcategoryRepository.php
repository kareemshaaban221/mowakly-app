<?php

namespace App\Repositories;
use App\Interfaces\SubcategoryRepositoryInterface;
use App\Models\MainCategory;
use App\Models\Subcategory;
use Illuminate\Http\Request;

class SubcategoryRepository implements SubcategoryRepositoryInterface {

	public function storeSubcategory(Request $request) {
        $data = $request->validated();

        $category = MainCategory::where('name', $data['parent_category'])->firstOrFail();

        $subcategory = new Subcategory;

        $subcategory->name = $data['subcategory'];
        $subcategory->m_category_id = $category->id;

        return $subcategory;
	}
}
