<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MainCategory extends Model
{
    use HasFactory;

    protected $guarded = [];

    // protected $hidden = ['id'];

    public function subcategories() {
        return $this->hasMany(Subcategory::class, 'm_category_id', 'id');
    }

    // public function lawyers() {
    //     return $this->morphToMany(Lawyer::class, 'lawyer_main_category');
    // }
}
