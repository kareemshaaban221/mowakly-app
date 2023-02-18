<?php

namespace App\Interfaces;

use Illuminate\Http\Request;

interface SubcategoryRepositoryInterface {
    public function storeSubcategory(Request $request);
}
