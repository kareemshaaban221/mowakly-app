<?php

namespace App\Interfaces;

use App\Models\Lawyer;
use Illuminate\Http\Request;

interface MainCategoryRepositoryInterface {
    public function storeCategory(Request $request);
}
