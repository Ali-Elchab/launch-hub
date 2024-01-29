<?php

namespace Tests\Feature;

use App\Models\Industry;
use App\Models\JobSeeker;
use App\Models\Specialization;
use App\Models\Startup;
use App\Models\User;
use App\Models\UserType;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class JobSeekerTest extends TestCase
{

    use RefreshDatabase;
    protected $adminUser;
    protected $jobSeekerUser;
    protected $startupUser;

    protected function setUp(): void
    {
        parent::setUp();
        UserType::factory()->create([
            'name' => 'startup'
        ]);
        UserType::factory()->create([
            'name' => 'job seeker'
        ]);
        UserType::factory()->create([
            'name' => 'admin'
        ]);

        $this->adminUser = User::factory()->create([
            'user_type_id' => 3
        ]);
        $this->jobSeekerUser = User::factory()->create([
            'user_type_id' => 2
        ]);
        $this->startupUser = User::factory()->create([
            'user_type_id' => 1
        ]);
    }



    public function test_jobseeker_can_access_basic_profile()
    {
        $user = User::factory()->create([
            'user_type_id' => 2
        ]);

        $jobSeeker = JobSeeker::factory()->create([
            'user_id' => $user->id
        ]);

        $response =  $this->actingAs($user)->get('/api/jobseeker/basic_profile');

        $response->assertJson([
            'status' => 'success'
        ]);
    }
    public function test_non_jobseeker_can_access_basic_profile()
    {
        $industry = Industry::factory()->create();
        $specialization = Specialization::factory()->create(
            [
                'industry_id' => $industry->id
            ]
        );
        $startup = Startup::factory()->create([
            'user_id' => $this->startupUser->id,
            'industry_id' => $industry->id,
            'specialization_id' => $specialization->id
        ]);

        $response =  $this->actingAs($this->startupUser)->get('/api/jobseeker/basic_profile');

        $response->assertJson([
            'status' => 'error'
        ]);
    }
}
