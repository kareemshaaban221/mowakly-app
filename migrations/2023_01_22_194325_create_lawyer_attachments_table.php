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
        Schema::create('lawyer_attachments', function (Blueprint $table) {
            $table->foreignId('lawyer_id')->constrained('lawyers');
            $table->string('attachment');
            $table->timestamps();
            // constraints
            $table->primary(['attachment', 'lawyer_id']);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('lawyer_attachments');
    }
};
