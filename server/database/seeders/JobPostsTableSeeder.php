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
                'responsibilities' => 'Collaborate with department heads to identify staffing needs and devise effective recruitment strategies.
                Conduct the entire recruitment process, from sourcing and screening to interviewing and onboarding.
                Foster a positive and inclusive workplace culture through effective employee relations.
                Implement and maintain HR policies and procedures in alignment with industry best practices.
                Plan and conduct training sessions on various HR-related topics.
                Maintain accurate records and documentation related to employee activities.',
                'experience_level' => '1-3 years',
                'education_level' => 'Doctoral Degree',
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
                'responsibilities' => 'Collaborate with department heads to identify staffing needs and devise effective recruitment strategies.
                Conduct the entire recruitment process, from sourcing and screening to interviewing and onboarding.
                Foster a positive and inclusive workplace culture through effective employee relations.
                Implement and maintain HR policies and procedures in alignment with industry best practices.
                Plan and conduct training sessions on various HR-related topics.
                Maintain accurate records and documentation related to employee activities.',
                'job_qualification' => 'Doctoral Degree in Health Sciences',
                'experience_level' => '1-3 years',
                'education_level' => 'Doctoral Degree',
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
                'job_title' => 'Data Analyst',
                'job_description' => 'Interpret data and analyze results using statistical techniques.',
                'job_location' => 'San Francisco',
                'job_type' => 'Contract',
                'job_salary' => 90000,
                'responsibilities' => 'Collaborate with department heads to identify staffing needs and devise effective recruitment strategies.
                Conduct the entire recruitment process, from sourcing and screening to interviewing and onboarding.
                Foster a positive and inclusive workplace culture through effective employee relations.
                Implement and maintain HR policies and procedures in alignment with industry best practices.
                Plan and conduct training sessions on various HR-related topics.
                Maintain accurate records and documentation related to employee activities.',
                'job_qualification' => 'Bachelor’s Degree in Statistics or Mathematics',
                'experience_level' => '1-3 years',
                'education_level' => 'Doctoral Degree',
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
