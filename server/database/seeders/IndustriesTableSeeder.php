<?php

namespace Database\Seeders;

use App\Models\Industry;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class IndustriesTableSeeder extends Seeder
{
    public function run()
    {
        $industries = [
            "Technology",
            "Healthcare",
            "Finance",
            "Education",
            "Manufacturing",
            "Retail",
            "Construction",
            "Energy",
            "Telecommunications",
            "Pharmaceuticals"
        ];

        foreach ($industries as $industry) {
            Industry::create([
                'name' => $industry,
            ]);
        }
    }
}
