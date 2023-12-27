<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\JobSeekerController;
use App\Http\Controllers\SkillsController;
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

Route::controller(JobSeekerController::class)->group(function () {
    Route::get('skills', 'getJobSeekerskills');
    Route::get('profile', 'getJobSeekerProfile');
    Route::post('update_profile', 'updateJobSeekerProfile');
    Route::get('related_job_posts', 'getRelatedJobPosts');
    Route::post('apply', 'applyForJob');
    Route::get('related_courses', 'getRelatedCourses');
});
