<?php

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

Route::prefix('jobseeker/')->group((function () {
    Route::controller(JobSeekerController::class)->group(function () {
        Route::get('profile', 'getBasicProfile');
        Route::get('profile/{id}', 'getJobSeeker');
        Route::get('', 'getAllJobSeekers');
        Route::get('related_courses', 'getRelatedCourses');
        Route::get('job_seekers/{specialization_id}', 'getJobSeekers');
        Route::post('apply', 'applyForJob');
        Route::post('update_profile', 'updateJobSeekerProfile');
        // Route::get('applications', 'getApplications');
    });
}));

Route::prefix('startup/')->group((function () {
    Route::controller(StartupController::class)->group(function () {
        Route::get('{id?}', 'getStartup');
        Route::post('update_profile', 'updateStartupProfile');
        Route::get('profile', 'getStartupProfile');
    });
}));

Route::prefix('jobposts/')->group((function () {
    Route::controller(JobPostController::class)->group(function () {
        Route::get('', 'getAllJobPosts');
        Route::get('/job_post/{id}', 'getJobPost');
        Route::get('/startup', 'getStartupJobPosts');
        Route::get('/related/{$specialization_id}', 'getRelatedJobPosts');
        Route::post('update', 'updateJobPost');
        Route::post('post', 'postJob');
    });
}));

Route::controller(UserController::class)->group(function () {
    Route::delete('jobseeker/{userID}', 'deleteJobSeekerProfile');
    Route::delete('startup/{userID}', 'deleteStartupProfile');
});

Route::controller(ApplicationController::class)->group(function () {
    Route::get('applications', 'getJobSeekerApplications');
    Route::get('applicants', 'getPendingStartupApplicants');
});
