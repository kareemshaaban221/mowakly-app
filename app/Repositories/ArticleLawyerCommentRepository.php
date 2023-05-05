<?php

namespace App\Repositories;
use App\Interfaces\ArticleLawyerCommentRepositoryInterface;
use App\Models\ArticleLawyerComment;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

class ArticleLawyerCommentRepository implements ArticleLawyerCommentRepositoryInterface {

    public function store(Request $request, Model $article, Model $user) {
        $articleComment = new ArticleLawyerComment;

        $articleComment->comment = $request->comment;
        $articleComment->lawyer_id = $user->id;
        $articleComment->article_id = $article->id;

        return $articleComment;
    }

    public function update(Request $request, Model $articleComment) {
        $articleComment->comment = $request->comment;

        return $articleComment;
    }

    public function delete(Model $articleComment) {
        $articleComment->delete();

        return $articleComment;
    }

}
