<?php

namespace App\Interfaces;

use App\Models\Lawyer;

interface LawyerRepositoryInterface extends UserRepositoryInterface {
    public function storePhones(Lawyer $lawyer) : bool;

    public function storeAttachments(Lawyer $lawyer) : bool;
}
