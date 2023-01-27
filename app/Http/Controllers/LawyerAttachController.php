<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\LawyerAttachment;
use App\Models\Lawyer;

class LawyerAttachController extends Controller
{
    use \App\Helpers\Functions, \App\Helpers\Path;

    public function store(Lawyer $lawyer, array $attaches) {
        $attach_filenames = $this->extractAttachName($attaches, $lawyer->email);

        $this->moveAttachments(array_combine($attach_filenames, $attaches), $this->uploads_path('lawyers'));

        $records = [];
        foreach($attach_filenames as $filename) {
            $record = LawyerAttachment::create([
                'lawyer_id' => $lawyer->id,
                'attachment' => $filename,
            ]);
            array_push($records, $record);
        }

        return $records;
    }

    private function moveAttachments($attaches) {
        foreach($attaches as $filename => $attach) {
            $attach->move($this->uploads_path('lawyers'), $filename);
        }
    }

    private function extractAttachName($attaches, $email) {
        $attach_filenames = [];
        $id = 1;
        foreach($attaches as $attach) {
            $attach_filename = $this->concatFilenameWithEmail("_attach_{$id}_", $email, $attach->getClientOriginalName());
            array_push($attach_filenames, $attach_filename);
            $id++;
        }

        return $attach_filenames;
    }
}
