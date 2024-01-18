<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;

class ApplicationsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $applications = [
            [
                'job_post_id' => 1, // Replace with the appropriate job post ID
                'job_seeker_id' => 1, // Replace with the appropriate job seeker ID
                'status' => 'pending',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'job_post_id' => 2, // Replace with the appropriate job post ID
                'job_seeker_id' => 2, // Replace with the appropriate job seeker ID
                'status' => 'pending',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'job_post_id' => 3, // Replace with the appropriate job post ID
                'job_seeker_id' => 3, // Replace with the appropriate job seeker ID
                'status' => 'pending',
                'created_at' => now(),
                'updated_at' => now(),
            ],

        ];

        foreach ($applications as $application) {
            DB::table('applications')->insert($application);
        }
    }
}
