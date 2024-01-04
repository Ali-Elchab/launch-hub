<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class JobSeekerHasHobbiesTableSeeder extends Seeder
{
    public function run()
    {
        // Assuming you have job seekers and hobbies already seeded
        // and their IDs are from 1 to 20, for example
        for ($i = 1; $i <= 5; $i++) {
            DB::table('job_seeker_has_hobbies')->insert([
                'job_seeker_id' => 1, // This should match existing job seeker IDs
                'hobby_id' => rand(1, 20), // Random hobby ID, assuming you have 20 hobbies
            ]);
        }
        for ($i = 1; $i <= 5; $i++) {
            DB::table('job_seeker_has_hobbies')->insert([
                'job_seeker_id' => 2, // This should match existing job seeker IDs
                'hobby_id' => rand(1, 20), // Random hobby ID, assuming you have 20 hobbies
            ]);
        }
    }
}
