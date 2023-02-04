<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Requests\LawyerRegisterRequest;
use App\Interfaces\LawyerRepositoryInterface;
use App\Models\Lawyer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LawyerController extends Controller
{
    public LawyerRepositoryInterface $lawyerRepository;

    public function index($response = new Response)
    {
        $lawyers = Lawyer::all();

        return $response->ok([
            'data' => $lawyers,
            'message' => 'All lawyers'
        ]);
    }

    public function store(LawyerRegisterRequest $request, $response = new Response)
    {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $response->badRequest('Data is not valid!', $request->validator->messages(), $request->except(['password', 'password_confirmation', 'card', 'avatar', 'attachments']));
        }

        DB::beginTransaction();

        try {
            $lawyer = $this->lawyerRepository->store($request);

            $this->lawyerRepository->storeAvatar($request->avatar, $lawyer);
            $this->lawyerRepository->storeCard($request->card, $lawyer);
            $lawyer->save();

            // phones and attachments
            $this->lawyerRepository->storePhones($request->phones, $lawyer);
            $this->lawyerRepository->storeAttachments($request->attachments, $lawyer);

            DB::commit();

            return $response->created(['data' => $lawyer], 'lawyer');
        } catch (\Throwable $th) {
            DB::rollback();
            return $response->internalServerError($th->getMessage());
        }
    }

    public function show($id)
    {
        //
    }

    public function update(Request $request, $id)
    {
        //
    }

    public function destroy($id)
    {
        //
    }
}
