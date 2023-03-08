<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

interface LawyerSubcategoryRepositoryInterface {
    public function store(Request $request, Model &$user);

    public function deleteBySubcategoryId($id, Model &$user);
}
