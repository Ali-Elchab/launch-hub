<?php

namespace Database\Seeders;

use App\Models\JobSeeker;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class JobSeekersTableSeeder extends Seeder
{
    public function run()
    {

        $jobseekers = [
            [
                'first_name' => 'Ali',
                'last_name' => 'Elchab',
                'profile_pic' => 'profile1.jpeg',
                'dob' => '2001-02-20',
                'phone' => '71 461 762',
                'address' => 'Beirut, Lebanon',
                'bio' => 'Experienced software developer specializing in web and mobile applications.',
                'resume' => null,
                'is_available' => true,
                'industry_id' => 1,
                'specialization_id' => 1,
                'user_id' => 11,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'first_name' => 'Emma',
                'last_name' => 'Brown',
                'profile_pic' => 'profile2.jpeg',
                'dob' => '1988-05-15',
                'phone' => '555-5678',
                'address' => '456 Innovation Blvd',
                'bio' => 'Product manager with extensive experience in managing SaaS products.',
                'resume' => null,
                'is_available' => false,
                'industry_id' => 1,
                'specialization_id' => 4,
                'user_id' => 12,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'first_name' => 'Sophia',
                'last_name' => 'Williams',
                'profile_pic' => 'profile8.jpeg',
                'dob' => '1993-04-30',
                'phone' => '555-8910',
                'address' => '789 Digital Lane',
                'bio' => 'Data scientist skilled in machine learning and statistical analysis.',
                'resume' => null,
                'is_available' => true,
                'industry_id' => 1,
                'specialization_id' => 2,
                'user_id' => 13,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Fourth profile
            [
                'first_name' => 'Michael',
                'last_name' => 'Jones',
                'profile_pic' => 'profile4.jpeg',
                'dob' => '1986-12-12',
                'phone' => '555-2345',
                'address' => '101 Main Street',
                'bio' => 'Front-end developer specializing in React and Angular frameworks.',
                'resume' => null,
                'is_available' => false,
                'industry_id' => 1,
                'specialization_id' => 1,
                'user_id' => 14,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Fifth profile
            [
                'first_name' => 'Olivia',
                'last_name' => 'Smith',
                'profile_pic' => 'profile7.jpeg',
                'dob' => '1995-07-21',
                'phone' => '555-6789',
                'address' => '202 Tech Park',
                'bio' => 'Cloud computing expert with a focus on AWS and Azure platforms.',
                'resume' => null,
                'is_available' => true,
                'industry_id' => 1,
                'specialization_id' => 3,
                'user_id' => 15,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Sixth profile
            [
                'first_name' => 'William',
                'last_name' => 'Johnson',
                'profile_pic' => 'profile6.jpeg',
                'dob' => '1989-09-09',
                'phone' => '555-3456',
                'address' => '303 Virtual Ave',
                'bio' => 'UX/UI Designer with a passion for creating intuitive user interfaces.',
                'resume' => null,
                'is_available' => false,
                'industry_id' => 1,
                'specialization_id' => 7,
                'user_id' => 16,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Seventh profile
            [
                'first_name' => 'Ava',
                'last_name' => 'Davis',
                'profile_pic' => 'profile7.jpeg',
                'dob' => '1991-11-25',
                'phone' => '555-4567',
                'address' => '404 Innovation Rd',
                'bio' => 'Cybersecurity specialist with experience in network protection and data privacy.',
                'resume' => null,
                'is_available' => true,
                'industry_id' => 1,
                'specialization_id' => 2,
                'user_id' => 17,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Eighth profile
            [
                'first_name' => 'James',
                'last_name' => 'Martin',
                'profile_pic' => 'profile8.jpeg',
                'dob' => '1992-03-15',
                'phone' => '555-5678',
                'address' => '505 Startup St.',
                'bio' => 'Marketing expert with a focus on digital strategies and social media outreach.',
                'resume' => null,
                'is_available' => false,
                'industry_id' => 1, // Different industry
                'specialization_id' => 7,
                'user_id' => 18,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Ninth profile
            [
                'first_name' => 'Isabella',
                'last_name' => 'Thomas',
                'profile_pic' => 'profile10.jpeg',
                'dob' => '1994-06-18',
                'phone' => '555-6789',
                'address' => '606 Finance Blvd',
                'bio' => 'Experienced accountant specializing in corporate finance and auditing.',
                'resume' => null,
                'is_available' => true,
                'industry_id' => 3, // Different industry
                'specialization_id' => 23,
                'user_id' => 19,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            // Tenth profile
            [
                'first_name' => 'Lucas',
                'last_name' => 'Moore',
                'profile_pic' => 'profile9.jpeg',
                'dob' => '1987-10-30',
                'phone' => '555-7890',
                'address' => '707 Health Way',
                'bio' => 'Healthcare professional with expertise in patient care and medical technology.',
                'resume' => null,
                'is_available' => false,
                'industry_id' => 2, // Different industry
                'specialization_id' => 13,
                'user_id' => 20,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        foreach ($jobseekers as $jobseeker) {
            DB::table('job_seekers')->insert($jobseeker);
        }
    }
}
