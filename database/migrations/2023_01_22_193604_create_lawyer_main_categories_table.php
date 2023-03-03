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
        Schema::create('lawyer_main_categories', function (Blueprint $table) {
            $table->foreignId('m_category_id')->constrained('main_categories')->cascadeOnDelete()->cascadeOnUpdate();
            $table->foreignId('lawyer_id')->constrained('lawyers')->cascadeOnDelete()->cascadeOnUpdate();
            $table->double('price_of_consultation', 8, 2)->nullable();
            $table->enum('mean_of_consultation', ['call', 'chat', 'appointment'])->nullable();
            $table->timestamps();
            // constraints
            $table->primary(['m_category_id', 'lawyer_id', 'mean_of_consultation']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('lawyer_main_categories');
    }
};
