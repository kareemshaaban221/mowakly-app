<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Consultation extends Model
{
    use HasFactory;

    protected $table = 'client_lawyer_consulting';
    protected $with = ['lawyer', 'client', 'mainCategory'];

    public function client() {
        return $this->belongsTo(Client::class);
    }

    public function lawyer() {
        return $this->belongsTo(Lawyer::class);
    }

    public function mainCategory() {
        return $this->belongsTo(MainCategory::class, 'm_category_id');
    }
}
