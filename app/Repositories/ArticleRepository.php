<?php

namespace App\Repositories;

use App\Helpers\Functions;
use App\Helpers\Path;
use App\Interfaces\ArticleRepositoryInterface;
use App\Models\Article;
use App\Models\Lawyer;
use Illuminate\Http\Request;

class ArticleRepository implements ArticleRepositoryInterface {
    use Functions, Path;

    public function store(Request $request, Lawyer $lawyer)
    {
        $article = Article::create([
            'lawyer_id' => $lawyer->id,
            'title' => $request->title,
            'body' => $request->body,
        ]);

        $article->image = $this->storeFile('article_banner', $request->image, $article, 'article');

        return $article;
    }

    public function destroy(Article $article) {
        $this->deleteFile($article->image, $article, 'article');

        $article->delete();

        return $article;
    }

    public function update(Request $request, Article $article)
    {
        $article->title = isset($request->title) ? $request->title : $article->title;
        $article->body = isset($request->body) ? $request->body : $article->body;

        if (isset($request->image))
        {
            $this->deleteFile($article->image, $article, 'article');
            $article->image = $this->storeFile('article_banner', $request->image, $article, 'article');
        }

        return $article;
    }
}
