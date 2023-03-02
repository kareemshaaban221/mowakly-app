<?php

namespace App\Interfaces;

use Illuminate\Database\Eloquent\Model;

interface AttachmentRepositoryInterface {
    public function storeAttachments($attachments, Model &$user);

    public function addAttachment($file, Model &$user);

    public function deleteAttachment($filename, Model &$user);

    public function deleteAttachmentsFiles(Model &$user);

    public function destroyAttachments(Model &$user);
}
