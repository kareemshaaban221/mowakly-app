<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Requests\ArticleStoreRequest;
use App\Http\Requests\ArticleUpdateRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\ArticleRepositoryInterface;
use App\Models\Article;
use App\Models\Lawyer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ArticleController extends Controller
{
    private $response;
    private $articleRepository;

    public function __construct(ArticleRepositoryInterface $articleRepository)
    {
        $this->response = new Response;
        $this->articleRepository = $articleRepository;
    }

    public function index(EmailAuthOrGivenRequest $request)
    {
        // if fails
        if (isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['attachment']));
        }

        try {

            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();

            return $this->response->ok([
                'data' => $lawyer->articles,
                'message' => 'all articles posted by this lawyer!',
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store(ArticleStoreRequest $request)
    {
        // if fails
        if (isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['attachment']));
        }

        DB::beginTransaction();

        try {

            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();

            $article = $this->articleRepository->store($request, $lawyer);

            $article->save();

            DB::commit();

            return $this->response->created(['data' => $article], 'article');

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function destroy(EmailAuthOrGivenRequest $request, $id)
    {
        // if fails
        if (isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['image']));
        }

        DB::beginTransaction();

        try {

            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();
            $article = Article::find($id);

            if (!$article)
                return $this->response->notFound(obj: 'article');

            if ($lawyer->id != $article->lawyer_id)
                return $this->response->notAuthorized('Not authorized to update this article!');

            $this->articleRepository->destroy($article);

            DB::commit();

            return $this->response->ok([
                'data' => $article,
                'message' => 'Article has been deleted successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function update(ArticleUpdateRequest $request, $id)
    {
        // if fails
        if (isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['image']));
        }

        DB::beginTransaction();

        try {

            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();
            $article = Article::find($id);

            if (!$article)
                return $this->response->notFound(obj: 'article');

            if ($lawyer->id != $article->lawyer_id)
                return $this->response->notAuthorized('Not authorized to update this article!');

            $article = $this->articleRepository->update($request, $article);

            $article->save();

            DB::commit();

            return $this->response->ok([
                'data' => $article,
                'message' => 'Article has been updated successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function show(EmailAuthOrGivenRequest $request, $id)
    {
        // if fails
        if (isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->except(['image']));
        }

        try {

            $lawyer = Lawyer::where('email', $request->email)->firstOrFail();
            $article = Article::find($id);

            if (!$article)
                return $this->response->notFound(obj: 'article');

            if ($lawyer->id != $article->lawyer_id)
                return $this->response->notAuthorized('Not authorized to update this article!');

            return $this->response->ok([
                'data' => $article,
                'message' => 'This is the article!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
