<?php

namespace App\Http\Controllers;

use App\Models\Application;
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
        $validatedData = $request->validate([
            'job_post_id' => 'required|exists:job_posts,id',
            'job_seeker_id' => 'required|exists:job_seekers,id',
            'res' => 'required'
        ]);

        $jobPostId = $validatedData['job_post_id'];
        $jobSeekerId = $validatedData['job_seeker_id'];
        $res = $validatedData['res'];

        try {
            $jobPost = $request->user()->jobPosts()->find($jobPostId);
            if (!$jobPost) {
                return response()->json(['status' => 'error', 'message' => 'Job post not found or not accessible'], 403);
            }

            $jobPost->jobSeekers()->updateExistingPivot($jobSeekerId, ['status' => $res]);

            $message = 'Application ' . ($res == 'rejected' ? 'rejected' : 'accepted');
            return response()->json(['status' => 'success', 'message' => $message]);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }

    public function deleteApplication(Request $request, $id)
    {
        $application = Application::find($id);
        try {
            if (!$application) {
                return response()->json(['status' => 'error', 'message' => 'Application not found or not accessible'], 403);
            }
            if ($request->user()->cannot('delete', $application)) {
                return response()->json(['status' => 'error', 'message' => 'Not authorized to delete this application'], 403);
            }
            $application->delete();
            return response()->json(['status' => 'success', 'message' => 'Application deleted']);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'An error occurred: ' . $e->getMessage()], 500);
        }
    }
}
