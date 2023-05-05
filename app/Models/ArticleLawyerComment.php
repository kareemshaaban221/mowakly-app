<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ArticleLawyerComment extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo(Lawyer::class, 'lawyer_id');
    }

    public function article()
    {
        return $this->belongsTo(Article::class);
    }
}
