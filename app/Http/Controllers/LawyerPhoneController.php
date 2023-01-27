<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Lawyer;
use App\Models\LawyerPhone;

class LawyerPhoneController extends Controller
{
    public static function store(Lawyer $lawyer, $phones) {
        $records = [];
        foreach($phones as $phone) {
            $record = LawyerPhone::create([
                'lawyer_id' => $lawyer->id,
                'phone_number' => $phone,
            ]);
            array_push($records, $record);
        }

        return $records;
    }
}
