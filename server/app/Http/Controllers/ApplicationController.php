<?php

namespace App\Http\Controllers;

use App\Models\Application;
use App\Models\JobPost;
use App\Models\JobSeeker;
use App\Models\Startup;
use App\Notifications\JobAppliedNotification;
use Illuminate\Http\Request;

class ApplicationController extends Controller
{

    protected $notificationController;
    //

    public function __construct(NotificationController $notificationController)
    {
        $this->middleware('auth:api');
        $this->notificationController = $notificationController;
    }

    public function getJobSeekerApplications(Request $request)
    {
        $jobSeeker = $request->user()->jobSeeker;
        if ($jobSeeker) {
            $jobPosts = $jobSeeker->jobPosts;
            return response()->json(['status' => 'success', 'jobPosts' => $jobPosts]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }

    public function getPendingStartupApplicants(Request $request)
    {
        $startup = $request->user()->startup;
        if ($startup) {
            $jobPostsIds = $startup->jobPosts()->pluck('id');
            $pending = Application::whereIn('job_post_id', $jobPostsIds)->where('status', 'pending')->with('jobPost', 'jobSeeker')->get();
            return response()->json(['status' => 'success', 'pendingApplicants' => $pending]);
        }

        return response()->json(['status' => 'error', 'message' => 'Startup not found'], 404);
    }

    public function applyForJob(Request $request, $jobPostID)
    {
        $jobSeeker = $request->user()->jobSeeker;
        $jobPost = JobPost::find($jobPostID);

        if (!$jobSeeker) {
            return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
        }
        if (!$jobPost) {
            return response()->json(['status' => 'error', 'message' => 'Job post not found'], 404);
        }

        $application = Application::where('job_post_id', $jobPostID)
            ->where('job_seeker_id', $jobSeeker->id)
            ->first();

        if ($application) {
            return response()->json(['status' => 'error', 'message' => 'Already applied'], 422);
        }
        $jobPost->jobSeekers()->attach($jobSeeker);
        $startup = $jobPost->startup;
        if ($startup && $startup->user) {
            $user = $startup->user;
            $registrationIds = [$user->fcm_token];
            $request = new Request(['registration_ids' => $registrationIds, 'applicant' => $jobSeeker->first_name . $jobSeeker->last_name, 'jobPost' => $jobPost->job_title]);
            $this->notificationController->sendNotifications($request);
        }


        return response()->json(['status' => 'success', 'message' => 'Applied successfully']);
    }


    public function applicationResponse(Request $request)
    {
        try {
            $request->validate([
                'status' => 'required|string',
                'application_id' => 'required|integer|exists:applications,id',
            ],);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->errors(),
            ], 422);
        }

        try {
            $application = Application::find($request->application_id);
            $application->status = $request->status;
            $application->save();

            $message = 'Application ' .  $request->status;
            return response()->json(['status' => 'success', 'message' => $message]);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
}
