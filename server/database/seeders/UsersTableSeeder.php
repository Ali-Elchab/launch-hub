<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('users')->insert([
            [
                'email' => 'admin@launchHub.com',
                'password' => Hash::make('password'),
                'user_type_id' => 3
            ],
            [
                'email' => 'innovateTech@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 1
            ],
            [
                'email' => 'greenSolutions@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 1
            ],
            [
                'email' => 'cloudAnalytics@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 1
            ],
            [
                'email' => 'aiFrontiers@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 1
            ],
            [
                'email' => 'nextGenRobotics@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 1
            ],
            [
                'email' => 'oceonTech@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 1
            ],
            [
                'email' => 'virtualRealityLab@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 1
            ],
            [
                'email' => 'spaceExplorers@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 1
            ],
            [
                'email' => 'biotechPioneers@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 1
            ],
            [
                'email' => 'jobseeker@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'jobseeker2@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],


        ]);
    }
}
