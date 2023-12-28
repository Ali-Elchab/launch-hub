<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\JobPostController;
use App\Http\Controllers\JobSeekerController;
use App\Http\Controllers\SkillsController;
use App\Http\Controllers\StartupController;
use Illuminate\Http\Request;
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
        Route::get('all', 'getAllJobSeekers');
        Route::get('related_courses', 'getRelatedCourses');
        Route::get('/{specialization_id}', 'getJobSeekers');
        Route::post('apply', 'applyForJob');
        Route::post('update_profile', 'updateJobSeekerProfile');
    });
}));

Route::prefix('startup/')->group((function () {
    Route::controller(StartupController::class)->group(function () {
        Route::get('{id?}', 'getStartup');
        Route::post('update_profile', 'updateStartupProfile');
        Route::get('profile', 'getStartupProfile');
        // Route::post('post_job', 'postJob');
        // Route::get('related_courses', 'getRelatedCourses');
        // Route::post('post_course', 'postCourse');
    });
}));

Route::prefix('jobpost/')->group((function () {
    Route::controller(JobPostController::class)->group(function () {
        Route::get('job_posts', 'getAllJobPosts');
        Route::get('job_post/{id}', 'getJobPost');
        Route::get('startup_job_posts', 'getStartupJobPosts');
        Route::get('related_job_posts/{$specialization_id}', 'getRelatedJobPosts');
        Route::post('update_job_post', 'updateJobPost');
        Route::post('post_job', 'postJob');
    });
}));
