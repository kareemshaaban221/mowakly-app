<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Requests\ArticleCommentStoreRequest;
use App\Http\Requests\ArticleCommentUpdateRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\ArticleClientCommentRepositoryInterface;
use App\Interfaces\ArticleLawyerCommentRepositoryInterface;
use App\Models\Article;
use App\Models\ArticleClientComment;
use App\Models\ArticleLawyerComment;
use App\Models\Client;
use App\Models\Lawyer;
use Illuminate\Support\Facades\DB;

class ArticleCommentController extends Controller
{
    private $response;
    private $model;
    private $commentModel;
    private $userCommentRepository;

    public function __construct(
        ArticleLawyerCommentRepositoryInterface|NULL $lawyerCommentRepository,
        ArticleClientCommentRepositoryInterface|NULL $clientCommentRepository
    )
    {
        $this->response = new Response;

        if (request()->user_type == 'lawyer') {

            $this->model = Lawyer::class;
            $this->commentModel = ArticleLawyerComment::class;
            $this->userCommentRepository = $lawyerCommentRepository;

        } else {

            $this->model = Client::class;
            $this->commentModel = ArticleClientComment::class;
            $this->userCommentRepository = $clientCommentRepository;

        }

    }

    public function index(EmailAuthOrGivenRequest $request, $article_id)
    {
        // if fails
        if (isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        try {

            $user = $this->model::where('email', $request->email)->firstOrFail();
            $article = Article::find($article_id);

            if (!$article)
                return $this->response->notFound(obj: 'article');

            $comments = $this->commentModel::where(request()->user_type . '_id', $user->id)
                ->where('article_id', $article_id)
                ->get();

            if (!$comments) {
                $this->response->notFound(obj: 'article');
            }

            return $this->response->ok([
                'data' => $comments,
                'message' => 'All user comments!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store(ArticleCommentStoreRequest $request, $article_id)
    {
        // if fails
        if (isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $user = $this->model::where('email', $request->email)->firstOrFail();
            $article = Article::find($article_id);

            if (!$article)
                return $this->response->notFound(obj: 'article');

            $comment = $this->userCommentRepository->store($request, $article, $user);

            $comment->save();

            DB::commit();

            return $this->response->created(
                data: ['data' => $comment],
                createdObj: 'article user comment'
            );

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function update(ArticleCommentUpdateRequest $request, $comment_id)
    {
        // if fails
        if (isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $user = $this->model::where('email', $request->email)->firstOrFail();
            $comment = $this->commentModel::find($comment_id);

            if (!$comment)
                return $this->response->notFound(obj: 'user comment');

            if ($comment->user->id != $user->id)
                return $this->response->notAuthorized('This user is not authorized to update this comment');

            $comment = $this->userCommentRepository->update($request, $comment);

            $comment->save();

            DB::commit();

            return $this->response->ok([
                'data' => $comment,
                'message' => 'Article comment has been updated successfully!',
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function destroy(EmailAuthOrGivenRequest $request, $comment_id)
    {
        // if fails
        if (isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $user = $this->model::where('email', $request->email)->firstOrFail();
            $comment = $this->commentModel::find($comment_id);

            if (!$comment)
                return $this->response->notFound(obj: 'user comment');

            if ($comment->user->id != $user->id)
                return $this->response->notAuthorized('This user is not authorized to delete this comment');

            $comment = $this->userCommentRepository->delete($comment);

            DB::commit();

            return $this->response->ok([
                'data' => $comment,
                'message' => 'Article comment has been deleted successfully!',
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
