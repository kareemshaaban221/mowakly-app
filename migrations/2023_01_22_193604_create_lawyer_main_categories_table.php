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
            $table->foreignId('m_category_id')->constrained('main_categories');
            $table->foreignId('lawyer_id')->constrained('lawyers');
            $table->timestamps();
            // constraints
            $table->primary(['m_category_id', 'lawyer_id']);
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
