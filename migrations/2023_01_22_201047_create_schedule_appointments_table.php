<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('schedule_appointments', function (Blueprint $table) {
            $table->dateTime('appointment');
            $table->foreignId('schedule_id')->constrained('schedules');
            $table->timestamps();

            // constraints
            $table->primary(['appointment', 'schedule_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('schedule_appointments');
    }
};
