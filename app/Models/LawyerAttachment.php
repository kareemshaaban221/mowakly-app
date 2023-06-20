<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LawyerAttachment extends Model
{
    use HasFactory;

    protected $guarded = [];

    protected $hidden = [];

    public function lawyer() {
        return $this->belongsTo(Lawyer::class);
    }

    // *** attributes
    public function getAttachmentAttribute() {
        return asset($this->attributes['attachment']);
    }
}
