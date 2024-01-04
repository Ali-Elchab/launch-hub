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
            [
                'first_name' => 'Jane',
                'last_name' => 'Smith',
                'profile_pic' => null,
                'dob' => '1985-03-15',
                'phone' => '555-5678',
                'address' => '456 Tech Blvd',
                'city' => 'Techville',
                'bio' => 'Experienced web developer...',
                'resume' => null,
                'is_available' => true,
                'industry_id' => 1,
                'specialization_id' => 2,
                'user_id' => 3,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'first_name' => 'Sarah',
                'last_name' => 'Johnson',
                'profile_pic' => null,
                'dob' => '1988-05-20',
                'phone' => '555-9876',
                'address' => '789 Health Lane',
                'city' => 'Medicaltown',
                'bio' => 'Experienced nurse with a passion for healthcare...',
                'resume' => null,
                'is_available' => true,
                'industry_id' => 2,
                'specialization_id' => 20,
                'user_id' => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'first_name' => 'Michael',
                'last_name' => 'Davis',
                'profile_pic' => null,
                'dob' => '1992-08-10',
                'phone' => '555-4321',
                'address' => '101 Medic Ave',
                'city' => 'Healthcity',
                'bio' => 'Medical researcher with a focus on innovation...',
                'resume' => null,
                'is_available' => true,
                'industry_id' => 2,
                'specialization_id' => 21,
                'user_id' => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        foreach ($jobseekers as $jobseeker) {
            DB::table('job_seekers')->insert($jobseeker);
        }
    }
}
