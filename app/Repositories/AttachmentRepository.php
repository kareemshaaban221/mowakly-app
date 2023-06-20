<?php

namespace App\Repositories;

use App\Helpers\Functions;
use App\Helpers\Path;
use App\Interfaces\AttachmentRepositoryInterface;
use App\Models\LawyerAttachment;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class AttachmentRepository implements AttachmentRepositoryInterface {
    use Path, Functions;

    public function storeAttachments($attachments, Model &$lawyer) {
        $records = [];
        $i = 1;
        foreach($attachments as $attachment) {
            $record = LawyerAttachment::create([
                'lawyer_id' => $lawyer->id,
                'attachment' => $this->storeFile('nil', $attachment, $lawyer, 'lawyer')
            ]);

            array_push($records, $record->attachment);

            $i++;
        }

        $lawyer->attachments = $records;

        return $records;
    }

	public function addAttachment($file, Model &$lawyer) {
        $attachment = LawyerAttachment::create([
            'lawyer_id' => $lawyer->id,
            'attachment' => $this->storeFile('nil', $file, $lawyer, 'lawyer')
        ]);

        return $attachment;
	}

	public function deleteAttachment($filename, Model &$lawyer) {
        $attachments = $lawyer->attachments();
        if($attachments->count() <= 1) {
            return 1;
        }

        $attachment = $attachments->where('attachment', ("uploads/lawyers/$filename"))->first();

        if(!$attachment) {
            return 0;
        }

        DB::table('lawyer_attachments')
            ->where('lawyer_id', $lawyer->id)
            ->where('attachment', ("uploads/lawyers/$filename"))
            ->delete();


        $this->deleteFile($filename, $lawyer, 'lawyer');

        return $attachment;
	}

    public function deleteAttachmentsFiles(Model &$lawyer) {
        $attachments = LawyerAttachment::where('lawyer_id', $lawyer->id)->get();

        foreach($attachments as $attachment) {
            $this->deleteFile($attachment->attachment, $lawyer, 'lawyer');
        }

        return $attachments;
    }

    public function destroyAttachments(Model &$lawyer) {
        $attachments = $this->deleteAttachmentsFiles($lawyer);

        DB::table('lawyer_attachments')
            ->where('lawyer_id', $lawyer->id)
            ->delete();

        return $attachments;
    }
}
