<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class JobPostsTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('job_posts')->insert([
            [
                'job_title' => 'Software Developer',
                'job_description' => 'Develop and maintain software applications.',
                'job_location' => 'Remote',
                'job_type' => 'Full-time',
                'job_salary' => 80000,
                'job_qualification' => 'Bachelor’s Degree in Computer Science',
                'experience_level' => 'Mid-level',
                'education_level' => 'Bachelors',
                'preferred_gender' => 'any',
                'deadline' => now()->addWeeks(2),
                'job_status' => 'Open',
                'industry_id' => 1,
                'specialization_id' => 1,
                'startup_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'job_title' => 'Doctor',
                'job_description' => 'Assist in hospital operations.',
                'job_location' => 'Beirut',
                'job_type' => 'Full-time',
                'job_salary' => 120000,
                'job_qualification' => 'Doctoral Degree in Health Sciences',
                'experience_level' => 'Mid-level',
                'education_level' => 'Doctoral',
                'preferred_gender' => 'any',
                'deadline' => now()->addWeeks(2),
                'job_status' => 'Open',
                'specialization_id' => 2,
                'industry_id' => 1,
                'startup_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'job_title' => 'Graphic Designer',
                'job_description' => 'Create visual concepts to communicate ideas.',
                'job_location' => 'New York',
                'job_type' => 'Part-time',
                'job_salary' => 50000,
                'job_qualification' => 'Bachelor’s Degree in Graphic Design',
                'experience_level' => 'Entry-level',
                'education_level' => 'Bachelors',
                'preferred_gender' => 'any',
                'deadline' => now()->addWeeks(3),
                'job_status' => 'Open',
                'industry_id' => 2,
                'specialization_id' => 20,
                'startup_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'job_title' => 'Data Analyst',
                'job_description' => 'Interpret data and analyze results using statistical techniques.',
                'job_location' => 'San Francisco',
                'job_type' => 'Contract',
                'job_salary' => 90000,
                'job_qualification' => 'Bachelor’s Degree in Statistics or Mathematics',
                'experience_level' => 'Senior-level',
                'education_level' => 'Masters',
                'preferred_gender' => 'any',
                'deadline' => now()->addWeeks(1),
                'job_status' => 'Open',
                'industry_id' => 2,
                'specialization_id' => 21,
                'industry_id' => 1,
                'startup_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
