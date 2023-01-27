<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Lawyer;
use App\Helpers\Response;

class LawyerController extends Controller
{
    use \App\Helpers\Functions, \App\Helpers\Path;

    public function store(Request $request, $response = new Response) {
        try {
            $data = $request->validated();

            $uploads_path = $this->uploads_path('lawyers');
            $card_filename = $this->concatFilenameWithEmail('_card_', $data['email'], $data['card']->getClientOriginalName());
            $avatar_filename = $this->concatFilenameWithEmail('_avatar_', $data['email'], $data['avatar']->getClientOriginalName());

            $data['card']->move($uploads_path, $card_filename);
            $data['avatar']->move($uploads_path, $avatar_filename);

            $lawyer = Lawyer::create([
                'fname' => $data['fname'],
                'lname' => $data['lname'],
                'email' => $data['email'],
                'password' => bcrypt($data['password']),
                'gender' => $data['gender'],
                'description' => $data['description'],
                'date_of_birth' => $data['date_of_birth'],
                'card' => $card_filename,
                'card_id' => 'required|max:20',
                'avatar' => $avatar_filename,
                'chat_price' => $data['chat_price'],
                'video_price' => $data['video_price'],
                'phone_price' => $data['phone_price'],
            ]);

            (new LawyerPhoneController)->store($lawyer, $data['phones']);

            (new LawyerAttachController)->store($lawyer, $data['attachments']);

            return $lawyer;
        } catch (\Throwable $th) {
            return $th;
        }
    }
}
