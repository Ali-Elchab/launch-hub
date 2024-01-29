<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\JobSeeker;
use App\Models\User;
use App\Models\Industry;
use App\Models\Specialization;

class JobSeekerFactory extends Factory
{
    protected $model = JobSeeker::class;

    public function definition()
    {
        return [
            'first_name' => $this->faker->firstName,
            'last_name' => $this->faker->lastName,
            'profile_pic' => $this->faker->optional()->imageUrl,
            'dob' => $this->faker->date,
            'phone' => $this->faker->phoneNumber,
            'address' => $this->faker->address,
            'bio' => $this->faker->paragraph,
            'resume' => $this->faker->optional()->url,
            'is_available' => $this->faker->boolean,
            'industry_id' => Industry::factory(),
            'user_id' => User::factory(),
            'specialization_id' => Specialization::factory(),
        ];
    }
}
