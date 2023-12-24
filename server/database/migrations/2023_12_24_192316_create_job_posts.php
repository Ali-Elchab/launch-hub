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
        Schema::create('job_posts', function (Blueprint $table) {
            $table->id();
            $table->string('job_title');
            $table->string('job_description');
            $table->string('job_location');
            $table->string('job_type');
            $table->int('job_salary');
            $table->string('job_qualification');
            $table->string('experience_level');
            $table->string('education_level');
            $table->string('preferred_gender');
            $table->date('deadline');
            $table->string('job_status');
            $table->foreignId('startup_id')->constrained()->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('job_posts');
    }
};
