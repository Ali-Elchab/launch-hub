<?php

namespace Database\Seeders;

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
            UsersTableSeeder::class,
            SocialMediaLinksSeeder::class,
        ]);
    }
}
