<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LawyerSubcategory extends Model
{
    use HasFactory;

    protected $guarded = [];

    protected $hidden = ['subcategory_id', 'lawyer_id'];

    protected $with = ['subcategory'];

    public function lawyer() {
        return $this->belongsTo(Lawyer::class);
    }

    public function subcategory() {
        return $this->belongsTo(Subcategory::class);
    }
}
