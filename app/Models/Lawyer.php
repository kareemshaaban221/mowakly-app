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
    protected $with = ['lawyer_attachments', 'lawyer_phones'];

    public function lawyer_phones() {
        return $this->hasMany(LawyerPhone::class);
    }

    public function lawyer_attachments() {
        return $this->hasMany(LawyerAttachment::class);
    }
}
