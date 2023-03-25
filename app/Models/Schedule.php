<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Schedule extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function lawyer() {
        return $this->belongsTo(Lawyer::class);
    }

    public function clients() {
        return $this->belongsToMany(Client::class, 'client_schedules');
    }
}
