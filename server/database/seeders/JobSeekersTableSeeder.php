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
                'first_name' => 'John',
                'last_name' => 'Doe',
                'profile_pic' => null,
                'dob' => '1990-01-01',
                'phone' => '555-1234',
                'address' => '123 Main St',
                'city' => 'Anytown',
                'bio' => 'Experienced software developer...',
                'resume' => null,
                'is_available' => true,
                'industry_id' => 1,
                'specialization_id' => 1,
                'user_id' => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],

        ];

        foreach ($jobseekers as $jobseeker) {
            JobSeeker::create([
                'first_name' => $jobseeker['first_name'],
                'last_name' => $jobseeker['last_name'],
                'profile_pic' => $jobseeker['profile_pic'],
                'dob' => $jobseeker['dob'],
                'phone' => $jobseeker['phone'],
                'address' => $jobseeker['address'],
                'city' => $jobseeker['city'],
                'bio' => $jobseeker['bio'],
                'resume' => $jobseeker['resume'],
                'is_available' => $jobseeker['is_available'],
                'industry_id' => $jobseeker['industry_id'],
                'specialization_id' => $jobseeker['specialization_id'],
                'user_id' => $jobseeker['user_id'],
                'created_at' => $jobseeker['created_at'],
                'updated_at' => $jobseeker['updated_at'],
            ]);
        }
    }
}
