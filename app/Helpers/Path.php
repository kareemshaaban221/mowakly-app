<?php

namespace App\Helpers;

Trait Path {
    protected function uploads_path($subdir = NULL) {
        if($subdir) {
            return storage_path('app/public/uploads/' . $subdir);
        }
        return storage_path('app/public/uploads');
    }
}
