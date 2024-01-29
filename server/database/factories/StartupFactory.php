<?php

namespace Database\Factories;

use App\Models\Industry;
use App\Models\Specialization;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Startup>
 */
class StartupFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'company_name' => $this->faker->company,
            'company_email' => $this->faker->unique()->companyEmail,
            'company_phone' => $this->faker->text,
            'logo_url' => $this->faker->text,
            'company_description' => $this->faker->text,
            'registration_number' => $this->faker->text,
            'founding_date' => $this->faker->date,
            'company_address' => $this->faker->text,
            'website_url' => $this->faker->text,
            'founders' => json_encode([$this->faker->name]),
            'ceos' => json_encode([$this->faker->optional()->name]),
            'key_executives' => json_encode([$this->faker->optional()->name]),
            'industry_id' => Industry::factory(),
            'specialization_id' => Specialization::factory(),
            'user_id' => User::factory(),
        ];
    }
}
