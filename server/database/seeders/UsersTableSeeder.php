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
                'email' => 'sefactory@gmail.com',
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
                'email' => 'alielchab@gmail.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'emma.brown@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'sophia.williams@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'michael.jones@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'olivia.smith@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'william.johnson@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'ava.davis@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'james.martin@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'isabella.thomas@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'lucas.moore@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ], [
                'email' => 'charlotte.taylor@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'ethan.anderson@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'amelia.harris@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'mason.wilson@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ],
            [
                'email' => 'mia.martinez@example.com',
                'password' => Hash::make('password'),
                'user_type_id' => 2
            ]



        ]);
    }
}
