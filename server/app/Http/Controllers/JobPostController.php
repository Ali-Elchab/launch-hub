<?php

namespace App\Http\Controllers;

use App\Models\JobPost;
use Illuminate\Http\Request;

class JobPostController extends Controller
{
    // public function getAllJobPosts()
    // {
    //     $jobposts = JobPost::all();
    //     return response()->json($jobposts);
    // }

    public function getJobPost($id)
    {
        $jobpost = JobPost::find($id);
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
        $jobposts = $startup->jobposts;
        return response()->json($jobposts);
    }

    public function updateJobPost(Request $request)
    {
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

    public function getRelatedJobPosts($specialization_id)
    {
        $jobPosts = JobPost::where('specialization_id', $specialization_id)->get();
        if (!$jobPosts) {
            return response()->json(['status' => 'error', 'message' => 'Related job posts not found'], 404);
        }
        return response()->json(['status' => 'success', 'jobPosts' => $jobPosts]);
    }
}
