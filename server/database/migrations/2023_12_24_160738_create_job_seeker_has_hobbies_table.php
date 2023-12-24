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
        Schema::create('job_seeker_has_hobbies', function (Blueprint $table) {
            $table->id();
            $table->foreignId('job_seeker_id')->constrained()->onDelete('cascade');
            $table->foreignId('hobby_id')->constrained()->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('job_seeker_has_hobbies');
    }
};
