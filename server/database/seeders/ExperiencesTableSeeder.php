<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ExperiencesTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('experience')->insert([
            [
                'position' => 'Software Engineer',
                'company' => 'Tech Solutions Inc.',
                'type' => 'Full-time',
                'industry' => 'Information Technology',
                'start_date' => Carbon::create('2018', '01', '01'),
                'end_date' => Carbon::create('2020', '12', '31'),
                'description' => 'Developed and maintained web applications using Laravel and Vue.js.',
                'location' => 'San Francisco, CA',
                'job_seeker_id' => 1, // Replace with an actual job_seeker_id from your database
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'position' => 'Project Manager',
                'company' => 'Innovative Enterprises',
                'type' => 'Contract',
                'industry' => 'Management Consulting',
                'start_date' => Carbon::create('2019', '05', '01'),
                'end_date' => Carbon::create('2021', '05', '30'),
                'description' => 'Led project teams to deliver high-quality software solutions on time and on budget.',
                'location' => 'New York, NY',
                'job_seeker_id' => 2, // Replace with an actual job_seeker_id from your database
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Add more experience entries as needed
        ]);
    }
}
