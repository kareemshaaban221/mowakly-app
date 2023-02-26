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
        Schema::create('appointments', function (Blueprint $table) {
            $table->dateTime('from');
            $table->dateTime('to');
            $table->string('subject');
            $table->foreignId('schedule_id')->constrained('schedules');
            $table->unsignedBigInteger('appointment_id');
            $table->timestamps();

            // constraints
            $table->primary(['appointment_id', 'schedule_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('appointments');
    }
};
