<?php

namespace App\Repositories;

use App\Interfaces\MainCategoryRepositoryInterface;
use App\Models\MainCategory;
use Carbon\Carbon;
use Illuminate\Http\Request;

class MainCategoryRepository implements MainCategoryRepositoryInterface {

	public function storeCategory(Request $request) {
        $data = $request->validated();

        $categories = [];
        foreach($data['categories'] as $category) {
            array_push($categories, [
                'name' => $category,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ]);
        }

        return MainCategory::insert($categories);
	}
}
