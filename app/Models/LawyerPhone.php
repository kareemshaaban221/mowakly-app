<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LawyerPhone extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function lawyer() {
        return $this->belongsTo(Lawyer::class);
    }
}
