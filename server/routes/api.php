<?php

use App\Http\Controllers\AuthController;
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
        Route::get('detailed_profile', 'getDetailedProfile');
        Route::post('update_profile', 'updateJobSeekerProfile');
        Route::get('related_job_posts', 'getRelatedJobPosts');
        Route::post('apply', 'applyForJob');
        Route::get('related_courses', 'getRelatedCourses');
    });
}));

Route::prefix('startup/')->group((function () {
    Route::controller(StartupController::class)->group(function () {
        Route::get('profile', 'getStartup');
        Route::post('update_profile', 'updateStartupProfile');
        Route::get('related_job_seekers', 'getRelatedJobSeekers');
        // Route::post('post_job', 'postJob');
        // Route::get('related_courses', 'getRelatedCourses');
        // Route::post('post_course', 'postCourse');
    });
}));
