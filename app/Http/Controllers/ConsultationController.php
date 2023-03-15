<?php

namespace App\Http\Controllers;

use App\Helpers\Response;
use App\Http\Requests\ConsultationStoreRequest;
use App\Http\Requests\ConsultationUpdateRequest;
use App\Http\Requests\EmailAuthOrGivenRequest;
use App\Interfaces\ConsultationRepositoryInterface;
use App\Models\Client;
use App\Models\Consultation;
use App\Models\Lawyer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ConsultationController extends Controller
{
    private $response;
    private $consultationRepository;

    public function __construct(ConsultationRepositoryInterface $consultationRepository) {
        $this->response = new Response;
        $this->consultationRepository = $consultationRepository;
    }

    public function index() {
        try {

            return $this->response->ok([
                'data' => Consultation::all(),
                'message' => 'All Consultations!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function store(ConsultationStoreRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $client = Client::where('email', $request->email)->firstOrFail();
            $lawyer = Lawyer::where('email', $request->lawyer_email)->firstOrFail();
            $consultation = $this->consultationRepository->store($request, $client, $lawyer);

            if(is_int($consultation) && $consultation == -1) {
                return $this->response->badRequest('Data is not valid!', ['lawyer_category' => 'Lawyer is not have this category in his profile!']);
            }

            $consultation->save();

            DB::commit();

            return $this->response->ok([
                'message' => 'Consultation relation was added successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function update(ConsultationUpdateRequest $request, $id) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        DB::beginTransaction();

        try {

            $consultation = Consultation::find($id);

            if(!$consultation) {
                return $this->response->badRequest('Data is not valid!', ['id' => 'Consultation record with this id is not found!']);
            }

            $consultation = $this->consultationRepository->update($request, $consultation);

            $consultation->save();

            DB::commit();

            return $this->response->ok([
                'data' => $consultation,
                'message' => 'Consultation relation was updated successfully!'
            ]);

        } catch (\Throwable $th) {
            DB::rollBack();
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function show($id) {
        try {

            return $this->response->ok([
                'data' => Consultation::find($id),
                'message' => 'Consultation by ID!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }

    public function showByUserEmail(EmailAuthOrGivenRequest $request) {
        // if fails
        if(isset($request->validator) && $request->validator->fails()) {
            return $this->response->badRequest('Data is not valid!', $request->validator->errors(), $request->all());
        }

        try {

            $consultations = $this->consultationRepository->showByEmail($request);

            if($consultations == 'lawyer' || $consultations == 'client')
                return $this->response->badRequest('Data is not valid!', ['email' => ucwords($consultations) . ' email is not found!']);

            return $this->response->ok([
                'data' => $consultations,
                'message' => 'Consultations related to this user account!'
            ]);

        } catch (\Throwable $th) {
            return $this->response->internalServerError($th->getMessage());
        }
    }
}
