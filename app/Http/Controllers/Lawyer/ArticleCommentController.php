<?php

namespace App\Http\Controllers\Lawyer;

use App\Http\Controllers\ArticleCommentController as ControllersArticleCommentController;
use App\Http\Controllers\Controller;
use App\Http\Requests\ArticleCommentStoreRequest;
use App\Http\Requests\ArticleCommentUpdateRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\ArticleLawyerCommentRepositoryInterface;
use Illuminate\Http\Request;

class ArticleCommentController extends Controller
{
    private ControllersArticleCommentController $articleCommentController;
    private EmailAuthOrGivenRequest $request;

    public function __construct(ArticleLawyerCommentRepositoryInterface $articleLawyerCommentRepository) {
        $this->articleCommentController = new ControllersArticleCommentController($articleLawyerCommentRepository, NULL);
        $this->request = new EmailAuthOrGivenRequest;
    }

    public function index($article_id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->articleCommentController->index($this->request, $article_id);
    }

    public function store(ArticleCommentStoreRequest $request, $article_id) {
        return $this->articleCommentController->store($request, $article_id);
    }

    public function update(ArticleCommentUpdateRequest $request, $comment_id) {
        return $this->articleCommentController->update($request, $comment_id);
    }

    public function destroy($comment_id) {
        $this->request->merge(['email' => auth()->user()->email]);
        return $this->articleCommentController->destroy($this->request, $comment_id);
    }
}
