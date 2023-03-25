<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Controllers\LawyerSubcategoryController as ControllersLawyerSubcategoryController;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\LawyerSubcategoryRequest;
use App\Interfaces\LawyerSubcategoryRepositoryInterface;
use App\Models\Lawyer;
use App\Models\LawyerSubcategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LawyerSubcategoryController extends Controller
{
    private EmailAuthOrGivenRequest $request;
    private ControllersLawyerSubcategoryController $lawyerSubcategoryController;

    public function __construct(LawyerSubcategoryRepositoryInterface $lawyerSubcategoryRepository) {
        $this->request = new EmailAuthOrGivenRequest;
        $this->lawyerSubcategoryController = new ControllersLawyerSubcategoryController($lawyerSubcategoryRepository);
    }

    public function index() {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerSubcategoryController->index($this->request);
    }

    public function store(LawyerSubcategoryRequest $request) {
        return $this->lawyerSubcategoryController->store($request);
    }

    public function destroy($subcategory_id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerSubcategoryController->destroy($this->request, $subcategory_id);
    }
}
