<?php

namespace App\Providers;

use App\Interfaces\AppointmentRepositoryInterface;
use App\Interfaces\ArticleRepositoryInterface;
use App\Interfaces\AttachmentRepositoryInterface;
use App\Interfaces\ChatRepositoryInterface;
use App\Repositories\LawyerMainCategoryRepository;
use Illuminate\Support\ServiceProvider;
use App\Interfaces\LawyerRepositoryInterface;
use App\Repositories\LawyerRepository;
use App\Interfaces\ClientRepositoryInterface;
use App\Interfaces\ConsultationRepositoryInterface;
use App\Interfaces\LawyerMainCategoryRepositoryInterface;
use App\Interfaces\LawyerSubcategoryRepositoryInterface;
use App\Interfaces\MainCategoryRepositoryInterface;
use App\Interfaces\ScheduleRepositoryInterface;
use App\Interfaces\SubcategoryRepositoryInterface;
use App\Repositories\AppointmentRepository;
use App\Repositories\ArticleRepository;
use App\Repositories\AttachmentRepository;
use App\Repositories\ChatRepository;
use App\Repositories\ClientRepository;
use App\Repositories\ConsultationRepository;
use App\Repositories\LawyerSubcategoryRepository;
use App\Repositories\MainCategoryRepository;
use App\Repositories\ScheduleRepository;
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
        $this->app->bind(AttachmentRepositoryInterface::class, AttachmentRepository::class);
        $this->app->bind(LawyerMainCategoryRepositoryInterface::class, LawyerMainCategoryRepository::class);
        $this->app->bind(LawyerSubcategoryRepositoryInterface::class, LawyerSubcategoryRepository::class);
        $this->app->bind(ConsultationRepositoryInterface::class, ConsultationRepository::class);
        $this->app->bind(ScheduleRepositoryInterface::class, ScheduleRepository::class);
        $this->app->bind(AppointmentRepositoryInterface::class, AppointmentRepository::class);
        $this->app->bind(ChatRepositoryInterface::class, ChatRepository::class);
        $this->app->bind(ArticleRepositoryInterface::class, ArticleRepository::class);
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
