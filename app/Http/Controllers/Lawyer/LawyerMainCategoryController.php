<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Requests\CategoryStoreRequest;
use Illuminate\Http\Request;

class LawyerMainCategoryController extends Controller
{
    private Response $response;

    public function __construct() {
        $this->response = new Response;
    }
    
    public function store($email, CategoryStoreRequest $request) {

    }

    public function delete() {

    }
}
