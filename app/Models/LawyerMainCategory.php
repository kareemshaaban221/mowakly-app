<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LawyerMainCategory extends Model
{
    use HasFactory;

    protected $guarded = [];

    protected $hidden = ['lawyer_id', 'm_category_id'];

    protected $with = ['category', ];

    public function lawyer() {
        return $this->belongsTo(Lawyer::class, 'lawyer_id');
    }

    public function category() {
        return $this->belongsTo(MainCategory::class, 'm_category_id');
    }
}
