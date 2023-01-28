<?php

namespace App\Interfaces;

use App\Models\Lawyer;

interface LawyerRepositoryInterface extends UserRepositoryInterface {
    public function storePhones($phones, Lawyer &$lawyer);

    public function storeAttachments($attachments, Lawyer &$lawyer);

    public function storeCard($file, Lawyer &$user);
}
