<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClientPaymentMethod extends Model
{
    use HasFactory;

    protected $guarded = [];

    protected $hidden = ['client_id'];

    public function client() {
        return $this->belongsTo(Client::class);
    }
}
