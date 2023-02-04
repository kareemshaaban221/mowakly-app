<?php

namespace App\Repositories;

use App\Http\Requests\ValidationRulesRequest;
use App\Interfaces\ClientRepositoryInterface;
use App\Models\Client;
use App\Models\ClientPaymentMethod;
use App\Models\VerifyEmail;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use App\Helpers\Functions;
use App\Helpers\Path;
use App\Helpers\Response;
use Carbon\Carbon;

class ClientRepository extends UserRepository implements ClientRepositoryInterface {
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

    public function storePaymentMethods(array $methods, Client &$client) {
        $records = [];
        foreach($methods as $method) {
            $record = ClientPaymentMethod::create([
                'client_id' => $client->id,
                'method' => $method
            ]);

            array_push($records, $record->method);
        }

        $client->paymentMethods = $records;

        return $records;
    }

	public function verifyEmail(Request $request, String $token) {
        $request->validate([
            'email' => ['required', 'email', 'max:255', 'exists:clients,email']
        ]);

        $email = $request->email;

        $client = Client::where('email', $email)->firstOrFail();

        $record = VerifyEmail::where('email', $email)->where('token', $token)->first();

        if(!$record) {
            return false;
        }

        $record->delete();

        $client->email_verified_at = Carbon::now();

        return $client;
	}
}
