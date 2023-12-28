<?php

namespace App\Http\Controllers;

use App\Models\JobPost;
use App\Models\JobSeeker;
use App\Models\JobSeekerEnhaceSkillsCourse;
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

    public function getBasicProfile(Request $request)
    {
        $user = $request->user();
        if ($user && $user->jobSeeker) {
            $jobSeeker = $user->jobSeeker;
            return response()->json(['status' => 'success', 'jobSeeker' => $jobSeeker]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }

    public function getJobSeeker($id)
    {
        $jobSeeker = JobSeeker::find($id);
        $user = $jobSeeker->user;

        if ($user && $user->jobSeeker) {
            $jobSeeker = $user->jobSeeker->load(['educations', 'experiences', 'certifications', 'hobbies', 'skills', 'jobPosts']);
            $jobSeeker->socialMediaLinks = $user->socialMediaLinks;

            return response()->json(['status' => 'success', 'jobSeeker' => $jobSeeker]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }

    public function getJobSeekers($specialization_id)
    {
        $jobseekers = JobSeeker::where('specialization_id', $specialization_id)->get();
        if (!$jobseekers) {
            return response()->json(['status' => 'error', 'message' => 'Related jobseekers not found'], 404);
        }
        return response()->json(['status' => 'success', 'jobseekers' => $jobseekers]);
    }

    public function getAllJobSeekers()
    {
        $jobseekers = JobSeeker::all();
        if (!$jobseekers) {
            return response()->json(['status' => 'error', 'message' => 'Related jobseekers not found'], 404);
        }
        return response()->json(['status' => 'success', 'jobseekers' => $jobseekers]);
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

    public function getAppliedJobs(Request $request)
    {
        $jobSeeker = $request->user()->jobSeeker;
        if ($jobSeeker) {
            $jobPosts = $jobSeeker->jobPosts;
            return response()->json(['status' => 'success', 'jobPosts' => $jobPosts]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }

    public function getRelatedCourses(Request $request)
    {
        $jobSeeker = $request->user()->jobSeeker;
        if ($jobSeeker) {
            $courses = JobSeekerEnhaceSkillsCourse::where('specialization_id', $jobSeeker->specialization_id)->get();
            return response()->json(['status' => 'success', 'courses' => $courses]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }
}
