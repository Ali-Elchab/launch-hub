<?php

namespace App\Http\Controllers;

use App\Models\Application;
use App\Models\JobPost;
use App\Models\JobSeeker;
use Illuminate\Http\Request;

class ApplicationController extends Controller
{

    //

    public function __construct()
    {
        $this->middleware('auth:api');
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
            $pendingApplicants = JobSeeker::whereHas('jobPosts', function ($query) use ($jobPostsIds) {
                $query->whereIn('job_posts.id', $jobPostsIds)
                    ->where('applications.status', 'pending');
            })->with(['jobPosts' => function ($query) use ($jobPostsIds) {
                $query->whereIn('job_posts.id', $jobPostsIds)
                    ->where('applications.status', 'pending');
            }])->get();

            return response()->json(['status' => 'success', 'pendingApplicants' => $pendingApplicants]);
        }

        return response()->json(['status' => 'error', 'message' => 'Startup not found'], 404);
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

    public function deleteApplication(Request $request, $id)
    {
        $application = Application::with('job.startup')->find($id);


        if (!$application) {
            return response()->json(['status' => 'error', 'message' => 'Application not found'], 404);
        }
        print_r($application);
        // Additional check to ensure that job and startup are not null
        if (!$application->job || !$application->job->startup) {
            return response()->json(['status' => 'error', 'message' => 'Related job post or startup not found'], 404);
        }

        // Now use $application->job->startup->id instead of $application->jobPost->startup->id
        if ($application->job->startup->id != $request->user()->startup->id) {
            return response()->json(['status' => 'error', 'message' => 'Not authorized to delete this application'], 403);
        }

        try {
            $application->delete();
            return response()->json(['status' => 'success', 'message' => 'Application deleted']);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
}
