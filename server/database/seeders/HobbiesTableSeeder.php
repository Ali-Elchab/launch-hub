<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class HobbiesTableSeeder extends Seeder
{
    public function run()
    {
        $hobbies = [
            'Reading',
            'Writing',
            'Painting',
            'Drawing',
            'Playing Musical Instruments',
            'Photography',
            'Gardening',
            'Cooking',
            'Baking',
            'Dancing',
            'Hiking',
            'Cycling',
            'Fishing',
            'Kayaking',
            'Rock Climbing',
            'Bird Watching',
            'Chess',
            'Video Gaming',
            'Model Building',
            'Collecting Stamps'
        ];

        foreach ($hobbies as $hobby) {
            DB::table('hobbies')->insert([
                'name' => $hobby,
            ]);
        }
    }
}
