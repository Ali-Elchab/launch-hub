<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class StartupsTableSeeder extends Seeder
{
    public function run()
    {
        // Insert the first technology startup
        DB::table('startups')->insert([
            'company_name' => 'Tech Innovate',
            'company_email' => 'contact@techinnovate.com',
            'company_phone' => '123-456-7890',
            'logo_url' => 'logo1.jpeg',
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
            'industry_id' => 1,
            'specialization_id' => 1,
            'user_id' => 4,
        ]);

        // Insert the second technology startup
        DB::table('startups')->insert([
            'company_name' => 'InnoTech Solutions',
            'company_email' => 'contact@innotechsolutions.com',
            'company_phone' => '987-654-3210',
            'logo_url' => 'logo2.jpeg',

            'company_description' => 'Providing innovative technology solutions to businesses.',
            'registration_number' => Str::random(10),
            'founding_date' => now()->subYears(2),
            'company_address' => '456 Innovation Avenue, Tech Town',
            'website_url' => 'https://innotechsolutions.com',
            'founders' => json_encode(['Alice Smith', 'Bob Johnson']),
            'ceos' => json_encode(['Alice Smith']),
            'key_executives' => json_encode(['Alice Smith', 'Bob Johnson']),
            'created_at' => now(),
            'updated_at' => now(),
            'industry_id' => 1,
            'specialization_id' => 2, // Assuming a different specialization for the second tech startup
            'user_id' => 5,
        ]);

        // Insert the first healthcare startup
        DB::table('startups')->insert([
            'company_name' => 'MediCare Solutions',
            'company_email' => 'contact@medicaresolutions.com',
            'company_phone' => '555-123-4567',
            'logo_url' => 'logo3.jpeg',

            'company_description' => 'Healthcare solutions for a healthier world.',
            'registration_number' => Str::random(10),
            'founding_date' => now()->subYears(3),
            'company_address' => '789 Health Street, Medical City',
            'website_url' => 'https://medicaresolutions.com',
            'founders' => json_encode(['David Brown', 'Linda White']),
            'ceos' => json_encode(['David Brown']),
            'key_executives' => json_encode(['David Brown', 'Linda White']),
            'created_at' => now(),
            'updated_at' => now(),
            'industry_id' => 2,
            'specialization_id' => 20,
            'user_id' => 4,
        ]);

        DB::table('startups')->insert([
            'company_name' => 'HealthTech Innovators',
            'company_email' => 'contact@healthtechinnovators.com',
            'company_phone' => '123-789-4560',

            'company_description' => 'Revolutionizing healthcare through technology.',
            'registration_number' => Str::random(10),
            'founding_date' => now()->subYears(4),
            'company_address' => '101 Health Drive, Medical Town',
            'website_url' => 'https://healthtechinnovators.com',
            'founders' => json_encode(['Sarah Johnson', 'Michael Davis']),
            'ceos' => json_encode(['Sarah Johnson']),
            'key_executives' => json_encode(['Sarah Johnson', 'Michael Davis']),
            'created_at' => now(),
            'updated_at' => now(),
            'industry_id' => 2,
            'specialization_id' => 21,
            'user_id' => 5,
        ]);
    }
}
