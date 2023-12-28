<?php

namespace Database\Seeders;

use App\Models\Advisor;
use App\Models\Startup;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        DB::table('user_types')->insert([
            ['name' => 'startup'],
            ['name' => 'job seeker'],
            ['name' => 'admin'],
        ]);

        $this->call([
            AdvisorsTableSeeder::class,
            UsersTableSeeder::class,
            SocialMediaLinksSeeder::class,
            IndustriesTableSeeder::class,
            SpecializationsTableSeeder::class,
            SkillsTableSeeder::class,
            StartupsTableSeeder::class,
            JobSeekersTableSeeder::class,
            JobPostsTableSeeder::class,
            CoursesTableSeeder::class,
        ]);
    }
}
