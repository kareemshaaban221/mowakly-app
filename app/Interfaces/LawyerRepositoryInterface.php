<?php

namespace App\Interfaces;

use App\Models\Lawyer;

interface LawyerRepositoryInterface extends UserRepositoryInterface {
    public function storePhones($phones, Lawyer &$lawyer);

    public function storeAttachments($attachments, Lawyer &$lawyer);

    public function storeCard($file, Lawyer &$user);

    public function updateCard($file, Lawyer &$user);

    public function addPhone($phone, Lawyer &$user);

    public function addAttachment($file, Lawyer &$user);

    public function deletePhone($phone, Lawyer &$user);

    public function deleteAttachment($filename, Lawyer &$user);
}
