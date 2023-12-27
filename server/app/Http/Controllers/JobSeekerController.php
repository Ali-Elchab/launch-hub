<?php

namespace App\Http\Controllers;

use App\Models\JobPost;
use App\Models\Skill;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class JobSeekerController extends Controller
{
    //

    public function __construct()
    {
        $this->middleware('auth:api');
    }

    public function getJobSeekerProfile(Request $request)
    {
        $user = $request->user();

        if ($user && $user->jobSeeker) {
            $jobSeeker = $user->jobSeeker->load(['courses', 'educations', 'experiences', 'certifications', 'hobbies', 'industry', 'skills', 'jobPosts']);
            $jobSeeker->socialMediaLinks = $user->socialMediaLinks;

            return response()->json(['status' => 'success', 'jobSeeker' => $jobSeeker]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
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

    public function updateJobSeekerProfile(Request $request)
    {
        $profileImagePath = uploadImage($request);

        $jobSeeker = $request->user()->jobSeeker;
        if ($jobSeeker) {
            $updateData = $request->only('first_name', 'last_name', 'phone', 'address', 'city', 'bio');
            if ($profileImagePath) {
                $updateData['profile_pic'] = $profileImagePath;
            }

            $jobSeeker->update($updateData);
            return response()->json(['status' => 'success', 'jobSeeker' => $jobSeeker]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }

    public function getRelatedJobPosts(Request $request)
    {

        $jobSeeker = $request->user()->jobSeeker;
        if ($jobSeeker) {
            $industry = $jobSeeker->industry_id;
            $jobPosts = JobPost::where('industry_id', $industry)->get();
            return response()->json(['status' => 'success', 'jobPosts' => $jobPosts]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }

    public function applyForJob(Request $request)
    {
        $jobPostID = $request->job_post_id;
        $jobSeeker = $request->user()->jobSeeker;
        $jobPost = JobPost::find($jobPostID);
        if ($jobPost) {
            $jobPost->jobSeekers()->attach($jobSeeker);
            return response()->json(['status' => 'success', 'message' => 'Applied successfully']);
        }
    }
}
