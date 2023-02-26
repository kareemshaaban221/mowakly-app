<?php

namespace App\Repositories;

use App\Interfaces\LawyerRepositoryInterface;
use App\Models\MainCategory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Lawyer;
use App\Models\LawyerPhone;
use App\Models\LawyerAttachment;
use Illuminate\Http\Request;
use App\Helpers\Functions;
use App\Helpers\Path;
use App\Models\LawyerMainCategory;
use App\Models\LawyerSubcategory;
use App\Models\Subcategory;
use App\Models\VerifyEmail;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

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
        $lawyer->national_id = (string) $data['national_id'];

        return $lawyer;
    }

    public function update(Request $request, $email): Lawyer {
        $data = $request->validated();

        $lawyer = Lawyer::where('email', $email)->first();

        $lawyer->fname = isset($data['fname']) ? $data['fname'] : $lawyer->fname;
        $lawyer->lname = isset($data['lname']) ? $data['lname'] : $lawyer->lname;
        $lawyer->email = isset($data['email']) ? $data['email'] : $lawyer->email;
        $lawyer->password = isset($data['password']) ? bcrypt($data['password']) : $lawyer->password;
        $lawyer->gender = isset($data['gender']) ? $data['gender'] : $lawyer->gender;
        $lawyer->date_of_birth = isset($data['date_of_birth']) ? $data['date_of_birth'] : $lawyer->date_of_birth;
        $lawyer->description = isset($data['description']) ? $data['description'] : $lawyer->description;
        $lawyer->card_id = isset($data['card_id']) ? $data['card_id'] : $lawyer->card_id;
        $lawyer->chat_price = isset($data['chat_price']) ? (double) $data['chat_price'] : $lawyer->chat_price;
        $lawyer->video_price = isset($data['video_price']) ? (double) $data['video_price'] : $lawyer->video_price;
        $lawyer->phone_price = isset($data['phone_price']) ? (double) $data['phone_price'] : $lawyer->phone_price;

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

	public function verifyEmail(Request $request, String $token) {
        $request->validate([
            'email' => ['required', 'email', 'max:255', 'exists:lawyers,email']
        ]);

        $email = $request->email;

        $lawyer = Lawyer::where('email', $email)->firstOrFail();

        $record = VerifyEmail::where('email', $email)->where('token', $token)->first();

        if(!$record) {
            return false;
        }

        $record->delete();

        $lawyer->email_verified_at = Carbon::now();

        return $lawyer;
	}

    public function updateAvatar($file, Model &$lawyer) {
        $this->deleteAvatar($lawyer->avatar, $lawyer);
        $filename = $this->storeAvatar($file, $lawyer);

        return $filename;
    }

    public function updateCard($file, Lawyer &$lawyer) {
        $this->deleteCard($lawyer->card, $lawyer);
        $filename = $this->storeCard($file, $lawyer);

        return $filename;
	}

    public function deleteFile($filename) {
        $uploads_path = $this->uploads_path('lawyers');

        if(file_exists($uploads_path . '/' . $filename)) {
            unlink($uploads_path . '/' . $filename);
            return $filename;
        } else {
            throw new \Exception('File not found');
        }
	}

    public function deleteAvatar($filename, Model &$lawyer) {
        $this->deleteFile($filename);

        $lawyer->avatar = null;

        return $lawyer;
    }

    public function deleteCard($filename, Model &$lawyer) {
        $this->deleteFile($filename);

        $lawyer->card = null;

        return $lawyer;
    }

	public function addPhone($phone, Lawyer &$lawyer) {
        if($lawyer->phones()->where('phone_number', $phone)->first()) {
            return null;
        }

        return LawyerPhone::create([
            'lawyer_id' => $lawyer->id,
            'phone_number' => $phone
        ]);
	}

	public function addAttachment($file, Lawyer &$lawyer) {
        $filename = $lawyer->attachments()->latest()->first()->attachment;

        $file_index = (int) explode("_", $filename)[2];

        $attachment = LawyerAttachment::create([
            'lawyer_id' => $lawyer->id,
            'attachment' => $this->storeFile('attach_'.$file_index + 1, $file, $lawyer)
        ]);

        return $attachment;
	}

	public function deletePhone($phone, Lawyer &$lawyer) {
        $phones = $lawyer->phones();

        if($phones->count() <= 1) {
            return 1;
        }

        $phone = $phones->where('phone_number', $phone)->first();

        if(!$phone) {
            return 0;
        }

        DB::table('lawyer_phones')
            ->where('lawyer_id', $lawyer->id)
            ->where('phone_number', $phone->phone_number)
            ->delete();

        return $phone;
	}

	public function deleteAttachment($filename, Lawyer &$lawyer) {
        $attachments = $lawyer->attachments();
        if($attachments->count() <= 1) {
            return 1;
        }

        $attachment = $attachments->where('attachment', $filename)->first();

        if(!$attachment) {
            return 0;
        }

        DB::table('lawyer_attachments')
            ->where('lawyer_id', $lawyer->id)
            ->where('attachment', $filename)
            ->delete();

        $this->deleteFile($filename);

        return $attachment;
	}

    public function storeCategory($category, Lawyer &$lawyer) {
        // condition the existence of this input category in main_categories table
        $category = is_string($category) ? MainCategory::where('name', $category)->first() : $category;
        if(!$category) {
            return null;
        }

        // add record in lawyer_main_categories table
        $lawyer_category = LawyerMainCategory::create([
            'lawyer_id' => $lawyer->id,
            'm_category_id' => $category->id,
        ]);

        // return the category
        return $lawyer_category;
    }
    public function deleteCategory($category, Lawyer &$lawyer) {
        // get lawyer categories
        $categories = $lawyer->categories();

        // check if this not the last category in lawyer categories
        if($categories->count() >= 1) return 1;

        // check if this category on them
        $category = $categories->where('name', $category)->first();
        if(!$category) return 0;

        $lawyer->subcategories()
            ->where('m_category_id', $category->id)
            ->delete();

        // delete if exists
        DB::table('lawyer_main_categories')
            ->where('lawyer_id', $lawyer->id)
            ->where('m_category_id', $category->id)
            ->delete();

        return $category;
    }

    public function storeSubcategory($subcategory, Lawyer &$lawyer) {
        // condition the existence of this input subcategory in subcategories table
        $subcategory = Subcategory::where('name', $subcategory)->first();
        if(!$subcategory) {
            return null;
        }

        // add record in lawyer_subcategories table
        $lawyer_subcategory = LawyerSubcategory::create([
            'lawyer_id' => $lawyer->id,
            'subcategory_id' => $subcategory->id,
        ]);

        // check if main category exists in lawyer main category table
        // add record in lawyer_main_category table
        $maincategory = $lawyer->categories()->where('id', $subcategory->mainCategory()->id)->first();
        if(!$maincategory) $this->storeCategory($maincategory, $lawyer);

        // return the category
        return $lawyer_subcategory;
    }

	public function deleteSubcategory($subcategory, Lawyer &$lawyer) {
        // get lawyer subcategories
        $subcategories = $lawyer->subcategories();

        // check if this subcategory on them
        $subcategory = $subcategories->where('name', $subcategory)->first();
        if(!$subcategory) return 0;

        // delete if exists
        DB::table('lawyer_subcategories')
            ->where('lawyer_id', $lawyer->id)
            ->where('subcategory_id', $subcategory->id)
            ->delete();

        return $subcategory;
	}
}
