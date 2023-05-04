<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function keywords()
    {
        return $this->belongsToMany(Keyword::class, 'article_keywords');
    }

    public function lawyer()
    {
        return $this->belongsTo(Lawyer::class);
    }

    public function lawyerComments()
    {
        return $this->hasMany(ArticleLawyerComment::class);
    }

    public function clientComments()
    {
        return $this->hasMany(ArticleClientComment::class);
    }
}
