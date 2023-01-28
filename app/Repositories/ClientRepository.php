<?php

namespace App\Repositories;

use App\Interfaces\ClientRepositoryInterface;
use App\Models\Client;
use App\Models\ClientPaymentMethod;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use App\Helpers\Functions;
use App\Helpers\Path;

class ClientRepository implements ClientRepositoryInterface {
    use Path, Functions;

    public function store(Request $request) : Model {
        $data = $request->validated();

        $client = new Client;
        $client->fname = $data['fname'];
        $client->lname = $data['lname'];
        $client->email = $data['email'];
        $client->password = bcrypt($data['password']);
        $client->gender = $data['gender'];
        $client->date_of_birth = $data['date_of_birth'];
        $client->phone = $data['phone'];

        return $client;
    }

    public function storeFile(String $fieldname, $file, Model &$client) {
        $uploads_path = $this->uploads_path('clients');

        $filename = $this->concatFilenameWithEmail('_'.$fieldname.'_', $client->email, $file->getClientOriginalName());

        $file->move($uploads_path, $filename);

        return $filename;
    }


    public function storeAvatar($file, Model &$client) {
        $filename = $this->storeFile('avatar', $file, $client);

        $client->avatar = $filename;

        return $filename;
    }

    public function checkCredentials(array $credentials) : Model {
        $client = Client::where('email', $credentials['email'])->firstOrFail();

        return password_verify($credentials['password'], $client->password) ? $client : NULL;
    }

    public function generateToken(Model &$client): String {
        $client->tokens()->where('name', 'client-'.$client->id)->delete();

        return $client->createToken('client-' . $client->id)->plainTextToken;
    }

    public function storePaymentMethods(array $methods, Client &$client): Client {
        $records = [];
        foreach($methods as $method) {
            $record = ClientPaymentMethod::create([
                'client_id' => $client,
                'method' => $method
            ]);

            array_push($records, $record);
        }

        return $records;
    }
}
