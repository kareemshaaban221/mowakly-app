<?php

namespace App\Repositories;
use App\Interfaces\LawyerSubcategoryRepositoryInterface;
use App\Models\Lawyer;
use App\Models\LawyerSubcategory;
use App\Models\Subcategory;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class LawyerSubcategoryRepository implements LawyerSubcategoryRepositoryInterface {

	public function store(Request $request, Model &$user) {

        $lawyer_categories = $user->_categories;

        $subcategories = Subcategory::whereIn('name', $request->subcategories)->get();

        if(!$this->mainCategoryCheck($lawyer_categories, $subcategories)) return false;

        $data = $this->prepareInsertionArray($subcategories, $user->id);

        try {
            return LawyerSubcategory::insert($data);
        } catch (\Throwable) {
            return null;
        }
	}

	public function deleteBySubcategoryId($id, Model &$user) {
        return LawyerSubcategory::where('subcategory_id', $id)
            ->where('lawyer_id', $user->id)
            ->delete();
	}

    private function mainCategoryCheck($lawyer_categories, $subcategories): bool {
        foreach($subcategories as $subcategory) {
            if(is_null($lawyer_categories->where('m_category_id', $subcategory->mainCategory->id)->first()))
                return false;
        }

        return true;
    }

    private function prepareInsertionArray($subcategories, $lawyer_id) {
        $data = [];
        foreach($subcategories as $subcategory) {
            array_push($data, [
                'subcategory_id' => $subcategory->id,
                'lawyer_id' => $lawyer_id,
                'created_at' => Carbon::now(),
                'updated_at' => Carbon::now()
            ]);
        }

        return $data;
    }
}
