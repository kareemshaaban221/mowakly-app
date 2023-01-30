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
}
