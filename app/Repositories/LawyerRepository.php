<?php

namespace App\Repositories;

use App\Interfaces\LawyerRepositoryInterface;
use Illuminate\Database\Eloquent\Model;
use App\Models\Lawyer;
use App\Models\LawyerPhone;
use App\Models\LawyerAttachment;
use Illuminate\Http\Request;
use App\Helpers\Functions;
use App\Helpers\Path;

class LawyerRepository extends UserRepository implements LawyerRepositoryInterface {
    use Path, Functions;

    public function store(Request $request): Lawyer {
        $data = $request->validated();

        $lawyer = new Lawyer;
        $lawyer->fname = $data['fname'];
        $lawyer->lname = $data['lname'];
        $lawyer->email = $data['email'];
        $lawyer->password = bcrypt($data['password']);
        $lawyer->gender = $data['gender'];
        $lawyer->date_of_birth = $data['date_of_birth'];
        $lawyer->description = $data['description'];
        $lawyer->card_id = $data['card_id'];
        $lawyer->chat_price = $data['chat_price'];
        $lawyer->video_price = $data['video_price'];
        $lawyer->phone_price = $data['phone_price'];

        return $lawyer;
    }

    public function storeFile(String $fieldname, $file, Model &$lawyer) {
        $uploads_path = $this->uploads_path('lawyers');

        $filename = $this->concatFilenameWithEmail('_'.$fieldname.'_', $lawyer->email, $file->getClientOriginalName());

        $file->move($uploads_path, $filename);

        return $filename;
    }

    public function storeAvatar($file, Model &$lawyer) {
        $filename = $this->storeFile('avatar', $file, $lawyer);

        $lawyer->avatar = $filename;

        return $filename;
    }

    public function storeCard($file, Lawyer &$lawyer) {
        $filename = $this->storeFile('card', $file, $lawyer);

        $lawyer->card = $filename;

        return $filename;
    }

    public function storePhones($phones, Lawyer &$lawyer) {
        $records = [];
        foreach($phones as $phone) {
            $record = LawyerPhone::create([
                'lawyer_id' => $lawyer->id,
                'phone_number' => $phone,
            ]);
            array_push($records, $record->phone_number);
        }

        $lawyer->phones = $records;

        return $records;
    }

    public function storeAttachments($attachments, Lawyer &$lawyer) {
        $records = [];
        $i = 1;
        foreach($attachments as $attachment) {
            $record = LawyerAttachment::create([
                'lawyer_id' => $lawyer->id,
                'attachment' => $this->storeFile('attach_'.$i, $attachment, $lawyer)
            ]);

            array_push($records, $record->attachment);

            $i++;
        }

        $lawyer->attachments = $records;

        return $records;
    }

    public function checkCredentials(array $credentials): Model {
        $lawyer = Lawyer::where('email', $credentials['email'])->firstOrFail();

        return password_verify($credentials['password'], $lawyer->password) ? $lawyer : NULL;
    }

    public function generateToken(Model &$lawyer): String {
        $lawyer->tokens()->where('name', 'lawyer-'.$lawyer->id)->delete();

        return $lawyer->createToken('lawyer-' . $lawyer->id)->plainTextToken;
    }
}
