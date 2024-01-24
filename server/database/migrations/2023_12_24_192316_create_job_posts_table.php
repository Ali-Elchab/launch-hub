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
            $table->enum('job_type', ['Full-time', 'Part-time', 'Contract', 'Temporary', 'Internship']);
            $table->integer('job_salary');
            $table->string('job_qualification');
            $table->string('experience_level');
            $table->string('education_level');
            $table->text('responsibilities');
            $table->enum('preferred_gender', ['male', 'female', 'any']);
            $table->date('deadline');
            $table->enum('job_status', ['open', 'closed'])->default('open');
            $table->timestamps();
            $table->foreignId('industry_id')->constrained()->onDelete('cascade');
            $table->foreignId('specialization_id')->nullable()->constrained()->onDelete('set null');
            $table->foreignId('startup_id')->constrained()->onDelete('cascade');
            $table->softDeletes();
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
