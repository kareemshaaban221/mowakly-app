<?php

namespace App\Interfaces;

use App\Models\Lawyer;

interface LawyerRepositoryInterface extends UserRepositoryInterface {
    public function storePhones($phones, Lawyer &$lawyer);

    public function storeCard($file, Lawyer &$user);

    public function updateCard($file, Lawyer &$user);

    public function addPhone($phone, Lawyer &$user);

    public function deletePhone($phone, Lawyer &$user);

    public function storeCategory($category, Lawyer &$user);

    public function deleteCategory($category, Lawyer &$user);

    public function storeSubcategory($subcategory, Lawyer &$user);

    public function deleteSubcategory($subcategory, Lawyer &$user);
}
