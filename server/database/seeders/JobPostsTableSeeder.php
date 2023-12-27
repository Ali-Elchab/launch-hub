<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class JobPostsTableSeeder extends Seeder
{
    public function run()
    {

        $industry_id = 1;
        $startup_id = 1;

        DB::table('job_posts')->insert([
            'job_title' => 'Software Developer',
            'job_description' => 'Develop and maintain software applications.',
            'job_location' => 'Remote',
            'job_type' => 'Full-time',
            'job_salary' => 80000,
            'job_qualification' => 'Bachelor’s Degree in Computer Science',
            'experience_level' => 'Mid-level',
            'education_level' => 'Bachelors',
            'preferred_gender' => 'Any',
            'deadline' => now()->addWeeks(2),
            'job_status' => 'Open',
            'industry_id' => $industry_id,
            'startup_id' => $startup_id,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
