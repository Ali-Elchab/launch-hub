<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class StartupsTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('startups')->insert([
            'company_name' => 'Tech Innovate',
            'company_email' => 'contact@techinnovate.com',
            'company_phone' => '123-456-7890',
            'logo_url' => 'https://example.com/logo.png',
            'company_description' => 'Innovative tech company working on cutting-edge solutions.',
            'registration_number' => Str::random(10),
            'founding_date' => now()->subYears(5),
            'company_address' => '123 Tech Street, Innovation City',
            'website_url' => 'https://techinnovate.com',
            'founders' => json_encode(['John Doe', 'Jane Doe']),
            'ceos' => json_encode(['John Doe']),
            'key_executives' => json_encode(['John Doe', 'Jane Doe']),
            'created_at' => now(),
            'updated_at' => now(),
            'user_id' => 4,
        ]);
    }
}
