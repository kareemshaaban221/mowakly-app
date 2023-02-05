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
        Schema::create('lawyer_phones', function (Blueprint $table) {
            $table->foreignId('lawyer_id')->constrained('lawyers')->cascadeOnDelete()->cascadeOnUpdate();
            $table->string('phone_number');
            $table->timestamps();
            // constraints
            $table->primary(['phone_number', 'lawyer_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('lawyer_phones');
    }
};
