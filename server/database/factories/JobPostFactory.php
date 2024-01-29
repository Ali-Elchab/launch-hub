<?php

namespace Database\Factories;

use App\Models\Industry;
use App\Models\Specialization;
use App\Models\Startup;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\JobPost>
 */
class JobPostFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'job_title' => $this->faker->jobTitle,
            'job_description' => $this->faker->paragraph,
            'job_location' => $this->faker->city,
            'job_type' => $this->faker->randomElement(['Full-time', 'Part-time', 'Contract', 'Temporary', 'Internship']),
            'job_salary' => $this->faker->numberBetween(30000, 100000),
            'job_qualification' => $this->faker->sentence,
            'experience_level' => $this->faker->randomElement(['Entry Level', 'Mid Level', 'Senior Level']),
            'education_level' => $this->faker->randomElement(['High School', 'Bachelor', 'Master', 'PhD']),
            'responsibilities' => $this->faker->paragraph,
            'deadline' => $this->faker->date,
            'job_status' => 'open',
            'industry_id' => Industry::factory(),
            'specialization_id' => Specialization::factory(),
            'startup_id' => Startup::factory(),
        ];
    }
}
