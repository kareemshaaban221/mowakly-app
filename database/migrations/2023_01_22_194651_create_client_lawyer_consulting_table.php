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
        Schema::create('client_lawyer_consulting', function (Blueprint $table) {
            $table->id();
            $table->foreignId('client_id')->constrained('clients');
            $table->foreignId('lawyer_id')->constrained('lawyers');
            $table->foreignId('m_category_id')->constrained('main_categories');
            $table->enum('mean_of_consultation', ['chat', 'call', 'appointment']);
            $table->string('review');
            $table->double('rating', 2, 1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('client_lawyer_consulting');
    }
};
