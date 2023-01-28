<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Interfaces\LawyerRepositoryInterface;
use App\Repositories\LawyerRepository;
use App\Interfaces\ClientRepositoryInterface;
use App\Repositories\ClientRepository;

class RepositoryServiceProvider extends ServiceProvider
{
    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->bind(LawyerRepositoryInterface::class, LawyerRepository::class);
        $this->app->bind(ClientRepositoryInterface::class, ClientRepository::class);
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
