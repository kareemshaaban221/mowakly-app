<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Helpers\Response;
use App\Models\Client;

class ClientController extends Controller
{
    use \App\Helpers\Functions, \App\Helpers\Path;

    public function store(Request $request, $response = new Response) {
        try {
            $data = $request->validated();

            $client = Client::create([
                'fname' => $data['fname'],
                'lname' => $data['lname'],
                'email' => $data['email'],
                'password' => bcrypt($data['password']),
                'gender' => $data['gender'],
                'date_of_birth' => $data['date_of_birth'],
                'phone' => $data['phone']
            ]);

            if(isset($data['avatar'])) {
                $uploads_path = $this->uploads_path('clients');
                $avatar_filename = $this->concatFilenameWithEmail('_avatar_', $data['email'], $data['avatar']->getClientOriginalName());
                $data['avatar']->move($uploads_path, $avatar_filename);

                $client->avatar = $avatar_filename;
                $client->save();
            }

            return $client;
        } catch (\Throwable $th) {
            return $th;
        }
    }

    // public function storeAvatar(Request $request, $response = new Response) {
    //     $request->validate([
    //         'avatar' => ''
    //     ])
    // }
}
