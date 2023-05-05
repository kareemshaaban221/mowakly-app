<?php

namespace App\Http\Controllers\Lawyer;

use App\Http\Controllers\ArticleController as ControllersArticleController;
use App\Http\Controllers\Controller;
use App\Http\Requests\ArticleStoreRequest;
use App\Http\Requests\ArticleUpdateRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\ArticleRepositoryInterface;

class ArticleController extends Controller
{
    private $request;
    private $articleController;

    public function __construct(ArticleRepositoryInterface $articleRepository) {
        $this->request = new EmailAuthOrGivenRequest;
        $this->articleController = new ControllersArticleController($articleRepository);
    }

    public function index() {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->articleController->index($this->request);
    }

    public function store(ArticleStoreRequest $request) {
        return $this->articleController->store($request);
    }

    public function update(ArticleUpdateRequest $request, $id) {
        return $this->articleController->update($request, $id);
    }

    public function destroy($id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->articleController->destroy($this->request, $id);
    }

    public function show($id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->articleController->show($this->request, $id);
    }
}
