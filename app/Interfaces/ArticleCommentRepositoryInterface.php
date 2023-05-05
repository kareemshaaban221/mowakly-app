<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;

interface ArticleCommentRepositoryInterface {

    public function store(Request $request, Model $article, Model $user);

    public function update(Request $request, Model $articleComment);

    public function delete(Model $articleComment);

}
