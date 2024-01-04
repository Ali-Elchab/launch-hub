<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\ApplicationController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\JobPostController;
use App\Http\Controllers\JobSeekerController;
use App\Http\Controllers\SkillsController;
use App\Http\Controllers\StartupController;
use App\Http\Controllers\UserController;
use App\Models\Application;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::controller(AuthController::class)->group(function () {
    Route::post('login', 'login');
    Route::post('register_jobseeker', 'register_jobseeker');
    Route::post('register_startup', 'register_startup');
    Route::post('logout', 'logout');
    Route::post('refresh', 'refresh');
});

Route::controller(SkillsController::class)->group(function () {
    Route::get('industry_skills', 'getSkillsByIndustry');
    Route::get('general_skills', 'getGeneralSkills');
});

Route::prefix('jobseeker/')->controller(JobSeekerController::class)->group(function () {
    Route::middleware('jobseeker')->group(function () {
        Route::get('profile', 'getBasicProfile');
        Route::get('related_courses', 'getRelatedCourses');
        Route::delete('delete', 'deleteJobSeekerProfile');
        Route::post('update_profile', 'updateJobSeekerProfile');
    });
    Route::get('profile/{id}', 'getJobSeeker');
    Route::get('', 'getAllJobSeekers');
    Route::get('job_seekers/{specialization_id}', 'getJobSeekers');
});

Route::prefix('startup/')->controller(StartupController::class)->group(function () {
    Route::get('profile/{id?}', 'getStartup');
    Route::middleware('startup')->group(function () {
        Route::post('update_profile', 'updateStartupProfile');
        Route::delete('delete', 'deleteStartupProfile');
        Route::get('advisors', 'getAdvisors');
    });
});


Route::prefix('jobposts')->controller(JobPostController::class)->group(function () {
    Route::get('/', 'getAllJobPosts');
    Route::get('/post/{id}', 'getJobPost');
    Route::middleware('jobseeker')->get('/related/{specialization_id}', 'getRelatedJobPosts');
    Route::middleware('jobseeker')->post('apply', 'applyForJob');
    Route::middleware('startup')->group(function () {
        Route::get('/startup', 'getStartupJobPosts');
        Route::post('/update', 'updateJobPost');
        Route::post('/post', 'postJob');
        Route::delete('/delete/{id}', 'deleteJobPost');
    });
});

Route::controller(ApplicationController::class)->group(function () {
    Route::middleware('jobseeker')->group(function () {
        Route::get('applications', 'getJobSeekerApplications');
        Route::get('pending_applications', 'getPendingStartupApplicants');
    });

    Route::middleware('startup')->group(function () {
        Route::get('applicants', 'getStartupApplicants');
        Route::get('application_response', 'applicationResponse');
        Route::delete('delete_application', 'deleteApplication');
    });
});

Route::prefix('admin/')->middleware(['admin'])->group((function () {
    Route::controller(AdminController::class)->group(function () {
        Route::get('startups', 'getAllStartups');
        Route::get('applications', 'getAllApplications');
        Route::get('active_jobposts', 'activeJobPosts');
        Route::get('recent_signups', 'recentSignups');
        Route::get('recent_jobposts', 'recentJobPosts');
        Route::post('add_advisor', 'addAdvisor');
        Route::post('edit_profile', 'editAdminProfile');
        Route::delete('delete_profile', 'deleteAdminProfile');
    });
    Route::get('jobseekers', 'JobSeekerController@getAllJobSeekers');
    Route::get('jobseeker/{id}', 'JobSeekerController@getJobSeeker');
    Route::get('startup/{id}', 'StartupController@getStartup');
    Route::get('jobpost/{id}', 'JobPostController@getJobPost');
    Route::get('jobposts', 'JobPostController@getAllJobPosts');
    Route::delete('jobseeker/{id}', 'UserController@deleteJobSeeker');
    Route::delete('startup/{id}', 'UserController@deleteStartup');
    Route::delete('jobpost/{id}', 'JobPostController@deleteJobPost');
    Route::delete('delete_application/{id}', 'ApplicationController@deleteApplication');
}));;
