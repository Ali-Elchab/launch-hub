<?php

namespace Tests\Feature;

use App\Models\Advisor;
use App\Models\Application;
use App\Models\Industry;
use App\Models\JobPost;
use App\Models\JobSeeker;
use App\Models\Specialization;
use App\Models\Startup;
use App\Models\User;
use App\Models\UserType;
use Database\Seeders\AdvisorsTableSeeder;
use Database\Seeders\UserTypeSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class AdminTest extends TestCase
{
    use RefreshDatabase;
    protected $adminUser;
    protected $jobSeekerUser;
    protected $startupUser;
    protected $industry;
    protected $specialization;

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

    public function test_admin_can_access_statistics()
    {
        Startup::factory()->count(5)->create();
        JobSeeker::factory()->count(5)->create();
        JobPost::factory()->count(5)->create();
        Application::factory()->state(['status' => 'pending'])->create();
        Application::factory()->state(['status' => 'pending'])->create();

        Industry::factory()->create();

        $response = $this->actingAs($this->adminUser)->get('/api/admin/statistics');

        $response->assertStatus(200);
    }

    public function test_nonAdmin_can_access_startup_statistics()
    {
        Startup::factory()->count(5)->create();
        JobSeeker::factory()->count(5)->create();
        JobPost::factory()->count(5)->create();
        Application::factory()->state(['status' => 'pending'])->create();
        Application::factory()->state(['status' => 'pending'])->create();

        Industry::factory()->create();

        $response = $this->actingAs($this->startupUser)->get('/api/admin/statistics');

        $response->assertStatus(403);
    }

    public function test_admin_can_add_advisor()
    {
        Advisor::factory()->count(5)->create();

        $response = $this->actingAs($this->adminUser)->post('/api/admin/add_advisor', [
            'name' => 'test',
            'email' => 'testemail@test.com',
            'location' => 'beirut',
            'phone' => '70550225',
            'bio' => 'advisor',
            'photo_url' => 'default.png',
            'category' => 'finance',
            'expertise' => 'finance',
        ]);

        $response->assertStatus(200);
    }
    public function test_non_admin_can_add_advisor()
    {
        Advisor::factory()->count(5)->create();

        $response = $this->actingAs($this->startupUser)->post('/api/admin/add_advisor', [
            'name' => 'test',
            'email' => 'testemail@test.com',
            'location' => 'beirut',
            'phone' => '70550225',
            'bio' => 'advisor',
            'photo_url' => 'default.png',
            'category' => 'finance',
            'expertise' => 'finance',
        ]);

        $response->assertStatus(403);
    }
}
