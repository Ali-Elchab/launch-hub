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
        Schema::create('startups', function (Blueprint $table) {
            $table->id();
            $table->string('company_name');
            $table->string('company_email')->unique();
            $table->string('company_phone');
            $table->text('logo_url')->nullable()->default('default-logo.png');
            $table->text('company_description');
            $table->string('registration_number')->nullable();
            $table->date('founding_date');
            $table->string('company_address');
            $table->string('website_url')->nullable();
            $table->json('founders');
            $table->json('ceos')->nullable();
            $table->json('key_executives')->nullable();
            $table->timestamps();
            $table->foreignId('specialization_id')->constrained()->onDelete('cascade');
            $table->foreignId('industry_id')->constrained()->onDelete('cascade');
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('startups');
    }
};
