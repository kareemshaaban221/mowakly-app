<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Interfaces\LawyerRepositoryInterface;
use App\Repositories\LawyerRepository;
use App\Interfaces\ClientRepositoryInterface;
use App\Interfaces\MainCategoryRepositoryInterface;
use App\Interfaces\SubcategoryRepositoryInterface;
use App\Repositories\ClientRepository;
use App\Repositories\MainCategoryRepository;
use App\Repositories\SubcategoryRepository;

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
        $this->app->bind(MainCategoryRepositoryInterface::class, MainCategoryRepository::class);
        $this->app->bind(SubcategoryRepositoryInterface::class, SubcategoryRepository::class);
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
