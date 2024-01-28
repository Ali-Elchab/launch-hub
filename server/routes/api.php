<?php

use App\Http\Controllers\AdminController;
use App\Http\Controllers\ApplicationController;
use App\Http\Controllers\Auth\GoogleAuthController as AuthGoogleAuthController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DataController;
use App\Http\Controllers\JobPostController;
use App\Http\Controllers\JobSeekerController;
use App\Http\Controllers\MessageController;
use App\Http\Controllers\PasswordResetController;
use App\Http\Controllers\StartupController;
use App\Http\Controllers\GoogleAuthController;
use Illuminate\Support\Facades\Route;

Route::controller(AuthController::class)->group(function () {
    Route::post('login', 'login');
    Route::post('signup', 'signup');
    Route::post('register_jobseeker', 'register_jobseeker');
    Route::post('register_startup', 'register_startup');
    Route::post('logout', 'logout');
    Route::post('refresh', 'refresh');
    Route::post('update-fcm-token', 'updateFcmToken');
});
Route::post('password/email', [PasswordResetController::class, 'sendResetLinkEmail'])->name('password.reset');;
Route::post('password/reset', [PasswordResetController::class, 'reset']);



Route::controller(DataController::class)->group(function () {
    Route::get('skills/{specialization_id}', 'getSkillsBySpecialization');
    Route::get('general_skills', 'getGeneralSkills');
    Route::get('hobbies', 'getHobbies');
    Route::get('industries/{id?}', 'getIndustries');
    Route::get('industry_specializations/{industry_id}', 'getSpecializationsByIndustry');
    Route::get('specializations/{id?}', 'getSpecializations');
    Route::get('udemy_courses/{searchQuery}', 'fetchUdemyCourses');
    Route::get('articles/{searchQuery}', 'fetchArticles');
});

Route::prefix('jobseeker/')->controller(JobSeekerController::class)->group(function () {
    Route::middleware('jobseeker')->group(function () {
        Route::get('basic_profile', 'getBasicProfile');
        Route::delete('delete', 'deleteJobSeekerProfile');
        Route::post('update_profile', 'updateJobSeekerProfile');
    });
    Route::get('profile/{id?}', 'getJobSeeker');
    Route::get('', 'getAllJobSeekers');
    Route::get('job_seekers', 'getJobSeekers');
});

Route::prefix('startup/')->controller(StartupController::class)->group(function () {
    Route::get('profile/{id?}', 'getStartup');
    Route::middleware('startup')->group(function () {
        Route::post('update_profile', 'updateStartupProfile');
        Route::delete('delete', 'deleteStartupProfile');
        Route::get('advisors', 'getAdvisors');
    });
});


Route::prefix('jobposts/')->controller(JobPostController::class)->group(function () {
    Route::get('', 'getAllJobPosts');
    Route::get('/{id}', 'getJobPost');
    Route::middleware('jobseeker')->get('jobseeker/related', 'getRelatedJobPosts');

    Route::middleware('startup')->group(function () {
        Route::get('startup/posts', 'getStartupJobPosts');
        Route::post('update/{id?}', 'updateJobPost');
        Route::post('post', 'postJob');
        Route::delete('delete/{id}', 'deleteJobPost');
    });
});

Route::controller(ApplicationController::class)->group(function () {
    Route::middleware('jobseeker')->group(function () {
        Route::get('applications', 'getJobSeekerApplications');
        Route::post('apply/{jobPostID}', 'applyForJob');
    });

    Route::middleware('startup')->group(function () {
        Route::get('pending_applications', 'getPendingStartupApplicants');
        Route::post('application_response', 'applicationResponse');
    });
});

Route::controller(MessageController::class)->group(function () {
    Route::get('messages', 'getUserMessages');
    Route::post('send_message', 'sendMessage');
    Route::delete('clear_messages', 'clearMessages');
});

Route::prefix('admin/')->middleware(['admin'])->group((function () {
    Route::controller(AdminController::class)->group(function () {
        Route::get('statistics', 'getStatistics');
        Route::get('startups', 'getAllStartups');
        Route::get('applications', 'getAllApplications');
        Route::get('jobposts', 'getAllJobPosts');
        Route::get('jobSeekers', 'getAllJobSeekers');
        Route::get('advisors', 'getAllAdvisors');
        Route::delete('application/{id}', 'deleteApplication');
        Route::post('add_advisor', 'addAdvisor');
        Route::delete('advisor/{id}', 'deleteAdvisor');
        Route::post('edit_profile', 'editAdminProfile');
        Route::delete('delete_profile', 'deleteAdminProfile');
    });
    Route::get('jobseeker/{id}', [JobSeekerController::class, 'getJobSeeker']);
    Route::get('startup/{id}', [StartupController::class, 'getStartup']);
    Route::get('jobpost/{id}', [JobPostController::class, 'getJobPost']);
    Route::delete('jobseeker/{id}', [JobSeekerController::class, 'deleteJobSeekerProfile']);
    Route::delete('startup/{id}', [StartupController::class, 'deleteStartupProfile']);
    Route::delete('jobpost/{id}', [JobPostController::class, 'deleteJobPost']);
}));;
