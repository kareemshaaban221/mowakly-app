<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    use App\Helpers\Path;
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('lawyers', function (Blueprint $table) {
            $table->id();
            $table->string('fname')->nullable();
            $table->string('lname')->nullable();
            $table->string('email')->unique()->nullable();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->enum('gender', ['male', 'female']);
            $table->string('description');
            $table->date('date_of_birth');
            $table->string('card')->nullable();
            $table->string('card_id')->nullable();
            $table->string('avatar')->nullable();
            $table->integer('count_of_consultations')->default(0);
            $table->string('national_id', 14);
            $table->rememberToken();
            $table->timestamps();
        });

        $files = glob($this->uploads_path('lawyers') . '/*');
        foreach ($files as $file) {
            if(is_file($file))
                unlink($file);
        }

        $files = glob($this->uploads_path('clients'). '/*');
        foreach ($files as $file) {
            if(is_file($file))
                unlink($file);
        }

        $files = glob($this->uploads_path('articles'). '/*');
        foreach ($files as $file) {
            if(is_file($file))
                unlink($file);
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('lawyers');
    }
};
