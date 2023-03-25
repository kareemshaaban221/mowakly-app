<?php

namespace App\Http\Controllers\Lawyer;

use App\Helpers\Response;
use App\Http\Controllers\Controller;
use App\Http\Controllers\LawyerMainCategoryController as ControllersLawyerMainCategoryController;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Http\Requests\LawyerCategoryDetailsRequest;
use App\Interfaces\LawyerMainCategoryRepositoryInterface;
use App\Models\Lawyer;
use App\Models\LawyerMainCategory;
use App\Models\LawyerSubcategory;
use App\Models\MainCategory;
use App\Models\Subcategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LawyerMainCategoryController extends Controller
{
    private LawyerMainCategoryRepositoryInterface $lawyerMainCategoryRepository;
    private Response $response;
    private ControllersLawyerMainCategoryController $lawyerMainCategoryController;
    private EmailAuthOrGivenRequest $request;

    public function __construct(LawyerMainCategoryRepositoryInterface $lawyerMainCategoryRepository) {
        $this->lawyerMainCategoryRepository = $lawyerMainCategoryRepository;
        $this->response = new Response;
        $this->lawyerMainCategoryController = new ControllersLawyerMainCategoryController($this->lawyerMainCategoryRepository);
        $this->request = new EmailAuthOrGivenRequest;
    }

    public function index() {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerMainCategoryController->show($this->request);
    }

    public function store(LawyerCategoryDetailsRequest $request) {
        return $this->lawyerMainCategoryController->store($request);
    }

    public function update(LawyerCategoryDetailsRequest $request) {
        return $this->lawyerMainCategoryController->update($request);
    }

    public function destroy($id, $mean) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerMainCategoryController->destroySpecific($this->request, $id, $mean);
    }

    public function destroyByCategory($id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerMainCategoryController->destroyByCategory($this->request, $id);
    }

    public function show($id, $mean) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerMainCategoryController->showSpecific($this->request, $id, $mean);
    }

    public function showByCategory($id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerMainCategoryController->showByCategory($this->request, $id);
    }

    public function showByConsultationMean($mean) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->lawyerMainCategoryController->showByConsultationMean($this->request, $mean);
    }
}
