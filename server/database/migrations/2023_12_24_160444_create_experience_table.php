<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('experience', function (Blueprint $table) {
            $table->id();
            $table->string('position');
            $table->string('company');
            $table->string('type');
            $table->date('start_date');
            $table->date('end_date');
            $table->string('description');
            $table->string('location');
            $table->timestamps();
            $table->foreignId('industry_id');
            $table->foreignId('specialization_id');
            $table->foreignId('job_seeker_id')->constrained()->onDelete('cascade');
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('experience');
    }
};
