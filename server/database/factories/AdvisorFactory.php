<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Advisor>
 */
class AdvisorFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'name' => $this->faker->name,
            'email' => $this->faker->unique()->safeEmail,
            'location' => $this->faker->city,
            'phone' => $this->faker->optional()->phoneNumber,
            'bio' => $this->faker->optional()->paragraph,
            'photo_url' => 'default-profile.png',
            'category' => $this->faker->randomElement(['marketing', 'legal', 'finance']),
            'expertise' => $this->faker->optional()->word,
        ];
    }
}
