<?php

namespace App\Repositories;

use App\Interfaces\ConsultationRepositoryInterface;
use App\Interfaces\LawyerMainCategoryRepositoryInterface;
use App\Models\Client;
use App\Models\Consultation;
use App\Models\Lawyer;
use App\Models\MainCategory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ConsultationRepository implements ConsultationRepositoryInterface {

    private $lawyerMainCategoryRepository;

    public function __construct(LawyerMainCategoryRepositoryInterface $lawyerMainCategoryRepository) {
        $this->lawyerMainCategoryRepository = $lawyerMainCategoryRepository;
    }

	public function store(Request $request, Model &$client, Model &$lawyer) {
        $m_category = MainCategory::where('name', $request->main_category)->firstOrFail();

        if(! $this->lawyerMainCategoryRepository->find($lawyer->id, $m_category->id, $request->mean_of_consultation))
            return -1;

        $consultation = new Consultation;
        $consultation->lawyer_id = $lawyer->id;
        $consultation->client_id = $client->id;
        $consultation->m_category_id = $m_category->id;
        $consultation->mean_of_consultation = $request->mean_of_consultation;
        $consultation->review = $request->review;
        $consultation->rating = (double) $request->rating;

        return $consultation;
	}

	public function update(Request $request, Model &$consultation) {
        $consultation->review = $request->review;
        $consultation->rating = (double) $request->rating;

        return $consultation;
	}

    public function showByEmail(Request $request) {
        $consultations = NULL;
        if(request()->user_type == 'lawyer') {
            $lawyer = Lawyer::where('email', $request->email)->first();
            if(!$lawyer)
                return 'lawyer';

            $consultations = Consultation::where('lawyer_id', $lawyer->id)->get();
        } else {
            $client = Client::where('email', $request->email)->first();
            if(!$client)
                return 'client';

            $consultations = Consultation::where('client_id', $client->id)->get();
        }

        return $consultations;
    }
}
