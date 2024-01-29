<?php

namespace Tests\Feature;

use App\Models\Startup;
use App\Models\User;
use App\Models\UserType;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class StartupTest extends TestCase
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


    public function test_startup_can_post_job()
    {

        $startup = Startup::factory()->create([
            'user_id' => $this->startupUser->id
        ]);

        $response = $this->actingAs($this->startupUser)->post('/api/jobposts/post', [
            'job_title' => 'test title',
            'job_description' => 'test description',
            'industry_id' => 1,
            'specialization_id' => 1,
            'job_salary' => 1000,
            'job_status' => 'open',
            'job_location' => 'test location',
            'job_type' => 'Full-time',
            'experience_level' => '1 year',
            'education_level' => 'bachelor',
            'job_qualification' => 'test qualification',
            'deadline' => '2024',
            'responsibilities' => 'test responsibilities',
            'requirements' => 'test requirements',
        ]);

        $response->assertJson(
            [
                'status' => 'success',

            ]
        );
    }
}
