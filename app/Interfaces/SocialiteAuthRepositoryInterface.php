<?php

namespace App\Interfaces;

interface SocialiteAuthRepositoryInterface {

    public function socialiteAccessLink(String $driver);

    public function socialiteRegisterCallback(String $driver);

    public function socialiteLoginCallback(String $driver);

}
