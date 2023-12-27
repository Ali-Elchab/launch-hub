<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class JobSeekersTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('job_seekers')->insert([
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
        ]);
    }
}
