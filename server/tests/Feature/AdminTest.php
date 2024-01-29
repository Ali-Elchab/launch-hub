<?php

namespace Tests\Feature;

use App\Models\Application;
use App\Models\Industry;
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
    /**
     * A basic feature test example.
     */
    /** @test */
    // public function admin_can_access_statistics()
    // {

    //     Startup::factory()->count(5)->create();
    //     JobSeeker::factory()->count(5)->create();
    //     Application::factory()->state(['status' => 'pending'])->create();
    //     Application::factory()->state(['status' => 'rejected'])->create();
    //     Industry::factory()->create();

    //     $response = $this->actingAs($this->adminUser)->get('/admin/statistics');

    //     $response->assertStatus(200);
    // }

    // public function test_login()
    // {
    //     $response = $this->postJson('/api/login', [
    //         'email' => $this->adminUser->email,
    //         'password' => 'password'
    //     ]);
    // }



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
