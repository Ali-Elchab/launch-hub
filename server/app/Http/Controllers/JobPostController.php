<?php

namespace App\Http\Controllers;

use App\Models\JobPost;
use Illuminate\Http\Request;

class JobPostController extends Controller
{
    public function getAllJobPosts()
    {
        $jobposts = JobPost::all();
        return response()->json($jobposts);
    }

    public function getJobPost($id)
    {
        $jobpost = JobPost::find($id);
        $jobpost->load(['requiredSkills']);
        if (!$jobpost) {
            return response()->json(['status' => 'error', 'message' => 'Job post not found'], 404);
        }
        return response()->json($jobpost);
    }

    public function getStartupJobPosts()
    {
        $user = auth()->user();
        $startup = $user->startup;
        if (!$user || !$startup) {
            return response()->json(['status' => 'error', 'message' => 'User not found'], 404);
        }
        $jobposts = $startup->jobposts()->with('requiredSkills')->get();

        return response()->json($jobposts);
    }

    public function updateJobPost(Request $request)
    {
        try {
            $request->validate([
                'job_title' => 'string',
                'job_description' => 'string',
                'job_type' => 'string',
                'job_salary' => 'integer',
                'job_qualification' => 'string',
                'experience_level' => 'string',
                'education_level' => 'string',
                'preferred_gender' => 'string',
                'job_status' => 'string',
                'deadline' => 'string',
                'specialization_id' => 'integer',
                'industry_id' => 'integer',
            ],);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->errors(),
            ], 422);
        };
        $user = auth()->user();
        $startup = $user->startup;
        if (!$user || !$startup) {
            return response()->json(['status' => 'error', 'message' => 'User not found'], 404);
        }
        $jobpost = JobPost::find($request->id);
        if (!$jobpost) {
            return response()->json(['status' => 'error', 'message' => 'Job post not found'], 404);
        }
        $jobpost->update($request->all());
        return response()->json(['status' => 'success', 'message' => 'Job post updated successfully']);
    }

    public function postJob(Request $request)
    {
        try {
            $request->validate([
                'job_title' => 'required|string',
                'job_description' => 'required|string',
                'job_type' => 'required|string',
                'job_salary' => 'required|integer',
                'job_qualification' => 'required|string',
                'experience_level' => 'required|string',
                'education_level' => 'required|string',
                'responsibilities' => 'required|string',
                'preferred_gender' => 'required|string',
                'job_status' => 'required|string',
                'deadline' => 'required|string',
                'specialization_id' => 'required|integer',
                'industry_id' => 'required|integer',
            ],);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->errors(),
            ], 422);
        };
        $user = auth()->user();
        $startup = $user->startup;
        if (!$user || !$startup) {
            return response()->json(['status' => 'error', 'message' => 'User not found'], 404);
        }
        $jobpost = new JobPost($request->all());
        $jobpost->startup_id = $startup->id;
        $jobpost->save();
        return response()->json(['status' => 'success', 'message' => 'Job post created successfully']);
    }




    public function getRelatedJobPosts(Request $request, $specialization_id = null)
    {
        if ($specialization_id) {
            $jobPosts = JobPost::where('specialization_id', $specialization_id)->get();
        } else {
            $jobPosts = $request->user()->jobSeeker->jobPosts;
        }

        if (!$jobPosts) {
            return response()->json(['status' => 'error', 'message' => 'Related job posts not found'], 404);
        }
        return response()->json(['status' => 'success', 'jobPosts' => $jobPosts]);
    }

    public function deleteJobPost($id)
    {
        $jobPost = JobPost::find($id);
        if (!$jobPost) {
            return response()->json(['status' => 'error', 'message' => 'Job post not found'], 404);
        }
        $jobPost->delete();
        return response()->json(['status' => 'success', 'message' => 'Job post deleted successfully']);
    }
}
