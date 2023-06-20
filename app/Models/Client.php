<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Client extends Authenticatable
{
    use HasFactory, Notifiable, HasApiTokens;

    protected $guarded = [];

    protected $with = ['paymentMethods'];

    protected $hidden = ['password'];

    public function paymentMethods() {
        return $this->hasMany(ClientPaymentMethod::class);
    }

    public function schedules() {
        return $this->belongsToMany(Schedule::class, 'client_schedules');
    }

    // *** attributes
    public function getAvatarAttribute() {
        if (isset($this->attributes['avatar']))
            return asset($this->attributes['avatar']);
        else
            return null;
    }
}
