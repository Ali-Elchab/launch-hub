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
            "Technology", "Healthcare", "Finance", "Education", "Manufacturing", "Retail", "Construction", "Agriculture", "Energy",
            "Transportation", "Hospitality", "Real Estate", "Media", "Telecommunications", "Pharmaceuticals", "Consulting", "Fashion", "Food & Beverage",
            "Legal", "Environmental Services"
        ];

        foreach ($industries as $industry) {
            Industry::create([
                'name' => $industry,
            ]);
        }
    }
}
