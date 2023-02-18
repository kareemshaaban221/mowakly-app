<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Subcategory extends Model
{
    use HasFactory;

    protected $guarded = [];

    protected $hidden = ['id'];

    protected $with = ['mainCategory'];

    public function mainCategory() {
        return $this->belongsTo(MainCategory::class);
    }

    // public function lawyers() {
    //     return $this->morphToMany(Lawyer::class, 'lawyer_subcategory');
    // }
}
