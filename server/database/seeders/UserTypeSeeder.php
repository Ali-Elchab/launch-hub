<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\UserType;

class UserTypeSeeder extends Seeder
{
    public function run()
    {
        UserType::create(['id' => 1, 'name' => 'startup']);
        UserType::create(['id' => 2, 'name' => 'job seeker']);
        UserType::create(['id' => 3, 'name' => 'admin']);
    }
}
