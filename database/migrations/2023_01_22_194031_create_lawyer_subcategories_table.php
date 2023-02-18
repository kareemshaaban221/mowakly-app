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
        Schema::create('lawyer_subcategories', function (Blueprint $table) {
            $table->foreignId('subcategory_id')->constrained('subcategories')->cascadeOnDelete()->cascadeOnUpdate();
            $table->foreignId('lawyer_id')->constrained('lawyers')->cascadeOnDelete()->cascadeOnUpdate();
            $table->timestamps();
            // constraints
            $table->primary(['subcategory_id', 'lawyer_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('lawyer_subcategories');
    }
};
