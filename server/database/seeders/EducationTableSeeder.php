<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class EducationTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('education')->insert([
            [
                'degree' => 'Bachelor of Science in Computer Science',
                'organization' => 'University of Technology',
                'start_date' => Carbon::create('2015', '09', '01'),
                'end_date' => Carbon::create('2019', '06', '30'),
                'description' => 'Studied various computer science disciplines, focusing on software development.',
                'location' => 'New York, NY',
                'job_seeker_id' => 1, // Assuming you have this ID available
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'degree' => 'Master of Business Administration',
                'organization' => 'Business School of Management',
                'start_date' => Carbon::create('2017', '09', '01'),
                'end_date' => Carbon::create('2019', '06', '30'),
                'description' => 'Specialized in business management and entrepreneurship.',
                'location' => 'San Francisco, CA',
                'job_seeker_id' => 2, // Assuming you have this ID available
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
