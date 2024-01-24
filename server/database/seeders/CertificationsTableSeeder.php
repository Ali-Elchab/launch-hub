<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class CertificationsTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('certifications')->insert([
            [
                'name' => 'Certified Information Systems Security Professional (CISSP)',
                'certificate' => 'CISSP12345',
                'organization' => 'International Information System Security Certification Consortium',
                'start_date' => Carbon::create('2020', '01', '01'),
                'end_date' => Carbon::create('2023', '01', '01'),
                'description' => 'An advanced-level certification for IT pros serious about careers in information security.',
                'location' => 'Remote',
                'job_seeker_id' => 1, // Replace with an actual job_seeker_id from your database
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'name' => 'Certified ScrumMaster (CSM)',
                'certificate' => 'CSM67890',
                'organization' => 'Scrum Alliance',
                'start_date' => Carbon::create('2021', '06', '15'),
                'end_date' => Carbon::create('2024', '06', '15'),
                'description' => 'Certification for those who wish to lead agile teams effectively.',
                'location' => 'Remote',
                'job_seeker_id' => 1, // Replace with an actual job_seeker_id from your database
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Add more certifications as needed
        ]);
    }
}
