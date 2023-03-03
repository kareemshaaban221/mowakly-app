<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

interface LawyerMainCategoryRepositoryInterface {
    public function store(Request $request, Model &$user);

    public function update(Request $request, Model &$user);

    public function deleteByCategoryId($id, Model &$user);

    public function deleteSpecific($id, $mean, Model &$user);
}
