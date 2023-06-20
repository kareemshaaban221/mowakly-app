<?php

namespace App\Helpers;

Trait Path {
    protected function uploads_path($subdir = NULL) {
        if($subdir) {
            return public_path('uploads/' . $subdir);
        }
        return public_path('uploads');
    }
}
