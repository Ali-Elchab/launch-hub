<?php

namespace App\Http\Controllers;

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

    public function getStartupApplicants(Request $request)
    {
        $startup = $request->user()->startup;
        if ($startup) {
            $applicants = $startup->jobPosts->jobSeekers();
            return response()->json(['status' => 'success', 'jobPosts' => $applicants]);
        }

        return response()->json(['status' => 'error', 'message' => 'Startup not found'], 404);
    }
}
