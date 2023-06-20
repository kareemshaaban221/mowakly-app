<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClientLawyerChat extends Model
{
    use HasFactory;

    protected $guarded = [];

    protected $with = ['client', 'lawyer'];

    public function client() {
        return $this->belongsTo(Client::class, 'from');
    }

    public function lawyer() {
        return $this->belongsTo(Lawyer::class, 'to');
    }
}
