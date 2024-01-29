<?php

namespace Database\Factories;

use App\Models\JobPost;
use App\Models\JobSeeker;
use Illuminate\Contracts\Queue\Job;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Application>
 */
class ApplicationFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'job_post_id' => JobPost::factory(),
            'job_seeker_id' => JobSeeker::factory(),
            'status' => $this->faker->randomElement(['pending', 'accepted', 'rejected']),
        ];
    }
}
