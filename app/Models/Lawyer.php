<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;

class Lawyer extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;

    protected $guarded = [];
    protected $with = ['attachments', 'phones'];

    protected $hidden = ['password', 'id'];

    public function phones() {
        return $this->hasMany(LawyerPhone::class);
    }

    public function attachments() {
        return $this->hasMany(LawyerAttachment::class);
    }

    // public function categories() {
    //     return $this->morphToMany(MainCategory::class, 'lawyer_main_category', );
    // }

    // public function subcategories() {
    //     return $this->morphToMany(SubCategory::class, 'lawyer_subcategory');
    // }
}
