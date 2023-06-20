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

    protected $hidden = ['password'];

    public function phones() {
        return $this->hasMany(LawyerPhone::class);
    }

    public function attachments() {
        return $this->hasMany(LawyerAttachment::class);
    }

    public function _categories() {
        return $this->hasMany(LawyerMainCategory::class);
    }

    public function _subcategories() {
        return $this->hasMany(LawyerSubcategory::class);
    }

    public function categories() {
        return $this->belongsToMany(MainCategory::class, 'lawyer_main_categories', 'lawyer_id', 'm_category_id');
    }

    public function subcategories() {
        return $this->belongsToMany(Subcategory::class, 'lawyer_subcategories', 'lawyer_id', 'subcategory_id');
    }

    public function appointments() {
        return $this->hasManyThrough(Appointment::class, Schedule::class);
    }

    public function articles()
    {
        return $this->hasMany(Article::class);
    }

    // **** attributes
    public function getAvatarAttribute() {
        return asset($this->attributes['avatar']);
    }

    public function getCardAttribute() {
        return asset($this->attributes['card']);
    }
}
