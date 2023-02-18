<?php

namespace App\Repositories;

use App\Interfaces\MainCategoryRepositoryInterface;
use App\Models\MainCategory;
use Illuminate\Http\Request;

class MainCategoryRepository implements MainCategoryRepositoryInterface {

	public function storeCategory(Request $request) {
        $data = $request->validated();

        $category = new MainCategory;

        $category->name = $data['category'];

        return $category;
	}
}
