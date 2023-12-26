<?php

namespace App\Http\Controllers;

use App\Models\Skill;
use Illuminate\Http\Request;

class JobSeekerController extends Controller
{
    //

    public function __construct()
    {
        $this->middleware('auth:api');
    }


    public function getJobSeekerskills(Request $request)
    {
        $user = $request->user();
        $jobSeeker = $user->jobSeeker;
        if ($jobSeeker) {
            $skills = $jobSeeker->skills;
            return response()->json(['status' => 'success', 'skills' => $skills]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }

    public function getJobSeekerProfile(Request $request)
    {
        $user = $request->user();

        if ($user && $user->jobSeeker) {
            $jobSeeker = $user->jobSeeker->load(['courses', 'educations', 'experiences', 'certifications', 'hobbies', 'industry', 'skills']);
            $jobSeeker->socialMediaLinks = $user->socialMediaLinks;

            return response()->json(['status' => 'success', 'jobSeeker' => $jobSeeker]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }
}
