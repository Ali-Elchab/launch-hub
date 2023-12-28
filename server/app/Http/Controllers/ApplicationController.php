<?php

namespace App\Http\Controllers;

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
}
