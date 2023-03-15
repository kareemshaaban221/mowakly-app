<?php

namespace App\Repositories;
use App\Interfaces\LawyerMainCategoryRepositoryInterface;
use App\Models\LawyerMainCategory;
use App\Models\LawyerSubcategory;
use App\Models\MainCategory;
use App\Models\Subcategory;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LawyerMainCategoryRepository implements LawyerMainCategoryRepositoryInterface {

	public function store(Request $request, Model &$user) {
        $r_categories = $request->categories;
        $r_prices = $request->prices;

        $categories = MainCategory::all();

        if(count($r_categories) != count($r_prices))
            return -1; // request error

        $lawyer_m_categories = $this->prepareLawyerMainCategoryArray($categories, $request, $user->id);

        try {
            LawyerMainCategory::insert($lawyer_m_categories);

            return $lawyer_m_categories;
        } catch (\Throwable $th) {
            return null;
        }
	}

	public function update(Request $request, Model &$user) {
        $r_categories = $request->categories;
        $r_prices = $request->prices;

        $categories = MainCategory::all();

        if(count($r_categories) != count($r_prices))
            return -1; // request error

        $this->updateAll($categories, $request, $user->id);
        return 1;
	}

    public function deleteByCategoryId($id, Model &$user) {
        $this->deleteRelatedSubcategories($id, $user->id);

        return LawyerMainCategory::where('lawyer_id', $user->id)
            ->where('m_category_id', $id)
            ->delete();
    }

    public function deleteSpecific($id, $mean, Model &$user) {
        $lawyer_m_cat_count = LawyerMainCategory::where('lawyer_id', $user->id)
            ->where('m_category_id', $id)
            ->count();

        if($lawyer_m_cat_count == 1) {
            $this->deleteRelatedSubcategories($id, $user->id);
        }

        if ($lawyer_m_cat_count < 1) {
            return null;
        }

        return LawyerMainCategory::where('lawyer_id', $user->id)
            ->where('m_category_id', $id)
            ->where('mean_of_consultation', $mean)
            ->delete();
    }

    private function prepareLawyerMainCategoryArray($categories, $request, $lawyer_id) {
        $lawyer_m_categories = [];
        $i = 0;
        foreach($request->categories as $category) {
            $temp = [];
            $temp['m_category_id'] = $categories->firstWhere('name', $category['category_name'])->id;
            $temp['lawyer_id'] = $lawyer_id;
            $temp['mean_of_consultation'] = $category['mean_of_consultation'];
            $temp['price_of_consultation'] = $request->prices[$i];
            $temp['created_at'] = Carbon::now();

            array_push($lawyer_m_categories, $temp);

            $i++;
        }

        return $lawyer_m_categories;
    }

    private function updateAll($categories, $request, $lawyer_id) {
        $i = 0;
        foreach($request->categories as $category) {
            $cat_id = $categories->firstWhere('name', $category['category_name'])->id;
            DB::table('lawyer_main_categories')
                ->where('m_category_id', $cat_id)
                ->where('lawyer_id', $lawyer_id)
                ->where('mean_of_consultation', $category['mean_of_consultation'])
                ->update(['price_of_consultation' => $request->prices[$i], 'updated_at' => Carbon::now()]);

            $i++;
        }
    }

    private function deleteRelatedSubcategories($m_cat_id, $lawyer_id) {
        $subcats = Subcategory::where('m_category_id', $m_cat_id)->get();
        $ids = [];
        foreach ($subcats as $subcategory) {
            array_push($ids, $subcategory->id);
        }

        LawyerSubcategory::where('lawyer_id', $lawyer_id)
            ->whereIn('subcategory_id', $ids)
            ->delete();
    }

    public function find($lawyer_id, $category_id, $mean_of_consultation) {
        return LawyerMainCategory::where('lawyer_id', $lawyer_id)
            ->where('m_category_id', $category_id)
            ->where('mean_of_consultation', $mean_of_consultation)
            ->first();
    }
}
