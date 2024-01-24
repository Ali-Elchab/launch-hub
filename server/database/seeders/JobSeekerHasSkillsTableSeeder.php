<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class JobSeekerHasSkillsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        for ($i = 1; $i <= 7; $i++) {
            DB::table('job_seekers_has_skills')->insert([
                'job_seeker_id' => 1, // This should match existing job seeker IDs
                'skill_id' => rand(1, 20), // Random hobby ID, assuming you have 20 skills
            ]);
        }
        for ($i = 1; $i <= 7; $i++) {
            DB::table('job_seekers_has_skills')->insert([
                'job_seeker_id' => 2, // This should match existing job seeker IDs
                'skill_id' => rand(1, 20), // Random hobby ID, assuming you have 20 skills
            ]);
        }
    }
}
