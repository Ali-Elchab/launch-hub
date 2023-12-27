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
        Schema::create('job_seeker_enhace_skills_courses', function (Blueprint $table) {
            $table->id();
            $table->string('course_name');
            $table->string('link');
            $table->string('image_url');
            $table->string('description');
            $table->timestamps();
            $table->foreignId('specialization_id')->constrained()->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('job_seeker_enhace_skills_courses');
    }
};
