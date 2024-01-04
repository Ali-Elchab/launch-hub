<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class JobPostRequiredSkillsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $skills = [
            [
                'job_post_id' => 1, // Replace with the appropriate job post ID
                'skill_id' => 1, // Replace with the appropriate job seeker ID


            ],
            [
                'job_post_id' => 1, // Replace with the appropriate job post ID
                'skill_id' => 2, // Replace with the appropriate job seeker ID


            ],
            [
                'job_post_id' => 2, // Replace with the appropriate job post ID
                'skill_id' => 3, // Replace with the appropriate job seeker ID


            ],
            [
                'job_post_id' => 2, // Replace with the appropriate job post ID
                'skill_id' => 4, // Replace with the appropriate job seeker ID


            ],
            [
                'job_post_id' => 3, // Replace with the appropriate job post ID
                'skill_id' => 20, // Replace with the appropriate job seeker ID


            ],
            [
                'job_post_id' => 3, // Replace with the appropriate job post ID
                'skill_id' => 21, // Replace with the appropriate job seeker ID


            ],
            [
                'job_post_id' => 4, // Replace with the appropriate job post ID
                'skill_id' => 22, // Replace with the appropriate job seeker ID


            ],
            [
                'job_post_id' => 4, // Replace with the appropriate job post ID
                'skill_id' => 23, // Replace with the appropriate job seeker ID


            ],
        ];
        foreach ($skills as $skill) {
            DB::table('job_post_required_skills')->insert($skill);
        }
    }
}
