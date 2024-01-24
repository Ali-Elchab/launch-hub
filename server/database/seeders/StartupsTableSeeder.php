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
            [
                'company_name' => 'InnoTech Solutions',
                'company_email' => 'contact@innotechsolutions.com',
                'company_phone' => '987-654-3210',
                'logo_url' => 'logo_innotech.jpeg',
                'company_description' => 'Providing innovative technology solutions to businesses globally.',
                'registration_number' => Str::random(10),
                'founding_date' => now()->subYears(5),
                'company_address' => '456 Innovation Avenue, Tech City',
                'website_url' => 'https://innotechsolutions.com',
                'founders' => json_encode(['Alice Smith', 'Bob Johnson']),
                'ceos' => json_encode(['Alice Smith']),
                'key_executives' => json_encode(['Alice Smith', 'Bob Johnson']),
                'created_at' => now(),
                'updated_at' => now(),
                'industry_id' => 1,
                'specialization_id' => 1,
                'user_id' => 2,
            ],
            [
                'company_name' => 'EcoStream Technologies',
                'company_email' => 'info@eco-streamtech.com',
                'company_phone' => '321-654-0987',
                'logo_url' => 'logo_ecostream.jpeg',
                'company_description' => 'Pioneers in sustainable energy and environmental technologies.',
                'registration_number' => Str::random(10),
                'founding_date' => now()->subYears(3),
                'company_address' => '789 Green Lane, Eco Park',
                'website_url' => 'https://eco-streamtech.com',
                'founders' => json_encode(['Jane Doe', 'John Green']),
                'ceos' => json_encode(['Jane Doe']),
                'key_executives' => json_encode(['Jane Doe', 'John Green']),
                'created_at' => now(),
                'updated_at' => now(),
                'industry_id' => 8,
                'specialization_id' => 76,
                'user_id' => 3,
            ], [
                'company_name' => 'Cloud Analytics Inc.',
                'company_email' => 'contact@Cloud.com',
                'company_phone' => '555-867-5309',
                'logo_url' => 'logo_cloud.jpeg',
                'company_description' => 'At the forefront of developing next-generation quantum computing technologies.',
                'registration_number' => Str::random(10),
                'founding_date' => now()->subYears(4),
                'company_address' => '101 Quantum Loop, Tech Valley',
                'website_url' => 'https://quantumcompinc.com',
                'founders' => json_encode(['Rachel Adams', 'Steve Gates']),
                'ceos' => json_encode(['Rachel Adams']),
                'key_executives' => json_encode(['Rachel Adams', 'Steve Gates']),
                'created_at' => now(),
                'updated_at' => now(),
                'industry_id' => 1,
                'specialization_id' => 4,
                'user_id' => 4,
            ],
            [
                'company_name' => 'AI Fortienres Inc.',
                'company_email' => 'contact@ai.com',
                'company_phone' => '555-867-5309',
                'logo_url' => 'logo_ai.jpeg',
                'company_description' => 'At the forefront of developing next-generation quantum computing technologies.',
                'registration_number' => Str::random(10),
                'founding_date' => now()->subYears(4),
                'company_address' => '101 Quantum Loop, Tech Valley',
                'website_url' => 'https://quantumcompinc.com',
                'founders' => json_encode(['Rachel Adams', 'Steve Gates']),
                'ceos' => json_encode(['Rachel Adams']),
                'key_executives' => json_encode(['Rachel Adams', 'Steve Gates']),
                'created_at' => now(),
                'updated_at' => now(),
                'industry_id' => 1,
                'specialization_id' => 4,
                'user_id' => 5,
            ],
            [
                'company_name' => 'Next Gen Robotics',
                'company_email' => 'contact@nextgem.com',
                'company_phone' => '555-867-5309',
                'logo_url' => 'logo_robotics.jpeg',
                'company_description' => 'At the forefront of developing next-generation quantum computing technologies.',
                'registration_number' => Str::random(10),
                'founding_date' => now()->subYears(4),
                'company_address' => '101 Quantum Loop, Tech Valley',
                'website_url' => 'https://quantumcompinc.com',
                'founders' => json_encode(['Rachel Adams', 'Steve Gates']),
                'ceos' => json_encode(['Rachel Adams']),
                'key_executives' => json_encode(['Rachel Adams', 'Steve Gates']),
                'created_at' => now(),
                'updated_at' => now(),
                'industry_id' => 1,
                'specialization_id' => 4,
                'user_id' => 6,
            ],
            [
                'company_name' => 'Virtuality Studios',
                'company_email' => 'info@virtualitystudios.com',
                'company_phone' => '777-923-4567',
                'logo_url' => 'logo_virtuality.jpeg',
                'company_description' => 'Creating immersive virtual reality experiences for gaming and education.',
                'registration_number' => Str::random(10),
                'founding_date' => now()->subYear(1),
                'company_address' => '88 VR Road, Digital City',
                'website_url' => 'https://virtualitystudios.com',
                'founders' => json_encode(['Emily Harris', 'David Clark']),
                'ceos' => json_encode(['Emily Harris']),
                'key_executives' => json_encode(['Emily Harris', 'David Clark']),
                'created_at' => now(),
                'updated_at' => now(),
                'industry_id' => 1,
                'specialization_id' => 7,
                'user_id' => 8,
            ],
            [
                'company_name' => 'BioHealth Innovations',
                'company_email' => 'support@biohealthinnov.com',
                'company_phone' => '888-414-2234',
                'logo_url' => 'logo_biohealth.jpeg',
                'company_description' => 'Advancing healthcare through biotechnological innovations and research.',
                'registration_number' => Str::random(10),
                'founding_date' => now()->subYears(6),
                'company_address' => '32 Healthway Blvd, MedTech Park',
                'website_url' => 'https://biohealthinnov.com',
                'founders' => json_encode(['Laura Bell', 'Mohammed Khan']),
                'ceos' => json_encode(['Laura Bell']),
                'key_executives' => json_encode(['Laura Bell', 'Mohammed Khan']),
                'created_at' => now(),
                'updated_at' => now(),
                'industry_id' => 2,
                'specialization_id' => 14,
                'user_id' => 10,
            ],
            [
                'company_name' => 'AeroSpace Pioneers',
                'company_email' => 'outreach@aerospacepioneers.com',
                'company_phone' => '555-321-9876',
                'logo_url' => 'logo_aerospace.jpeg',
                'company_description' => 'Leading innovations in aerospace technology and satellite communications.',
                'registration_number' => Str::random(10),
                'founding_date' => now()->subYears(7),
                'company_address' => '15 Sky High Road, Space Tech City',
                'website_url' => 'https://aerospacepioneers.com',
                'founders' => json_encode(['Neil Armstrong', 'Sally Ride']),
                'ceos' => json_encode(['Neil Armstrong']),
                'key_executives' => json_encode(['Neil Armstrong', 'Sally Ride']),
                'created_at' => now(),
                'updated_at' => now(),
                'industry_id' => 1,
                'specialization_id' => 79,
                'user_id' => 9,
            ],
            [
                'company_name' => 'OceanTech Explorers',
                'company_email' => 'info@oceantechexplorers.com',
                'company_phone' => '222-555-7890',
                'logo_url' => 'logo_oceantech.jpeg',
                'company_description' => 'Dedicated to exploring and preserving our oceans through cutting-edge technology.',
                'registration_number' => Str::random(10),
                'founding_date' => now()->subYears(3),
                'company_address' => '47 Deep Sea Lane, Marine City',
                'website_url' => 'https://oceantechexplorers.com',
                'founders' => json_encode(['Jacques Cousteau', 'Sylvia Earle']),
                'ceos' => json_encode(['Jacques Cousteau']),
                'key_executives' => json_encode(['Jacques Cousteau', 'Sylvia Earle']),
                'created_at' => now(),
                'updated_at' => now(),
                'industry_id' => 1,
                'specialization_id' => 4,
                'user_id' => 7,
            ],
            [
                'company_name' => 'Future Foods Ltd.',
                'company_email' => 'contact@futurefoodsltd.com',
                'company_phone' => '333-444-5555',
                'logo_url' => 'logo_futurefoods.jpeg',
                'company_description' => 'Innovating in sustainable and healthy food alternatives for the future.',
                'registration_number' => Str::random(10),
                'founding_date' => now()->subYears(1),
                'company_address' => '22 Nutrition Street, Health City',
                'website_url' => 'https://futurefoodsltd.com',
                'founders' => json_encode(['Jamie Oliver', 'Gordon Ramsay']),
                'ceos' => json_encode(['Jamie Oliver']),
                'key_executives' => json_encode(['Jamie Oliver', 'Gordon Ramsay']),
                'created_at' => now(),
                'updated_at' => now(),
                'industry_id' => 2,
                'specialization_id' => 18,
                'user_id' => 8,
            ],
        ]);
    }
}
