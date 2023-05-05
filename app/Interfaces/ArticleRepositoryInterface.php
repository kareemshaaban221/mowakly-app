<?php

namespace App\Interfaces;

use App\Models\Article;
use App\Models\Lawyer;
use Illuminate\Http\Request;

interface ArticleRepositoryInterface {

    public function store(Request $request, Lawyer $lawyer);

    public function destroy(Article $article);

    public function update(Request $request, Article $article);

}
