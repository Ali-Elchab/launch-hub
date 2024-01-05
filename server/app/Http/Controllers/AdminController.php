<?php

namespace App\Http\Controllers;

use App\Models\Advisor;
use App\Models\JobPost;
use App\Models\Startup;
use Illuminate\Http\Request;

class AdminController extends Controller
{

    public function _construct()
    {
        $this->middleware('auth:api');
    }

    public function getAllStartups()
    {
        $startups = Startup::all();
        $count = Startup::count();
        return response()->json(['startups' => $startups, 'count' => $count]);
    }

    public function getAllApplications()
    {
        $applications = JobPost::with('jobSeekers')->get();
        return response()->json($applications);
    }

    public function activeJobPosts()
    {
        $jobPosts = JobPost::where('status', 'active')->get();
        return response()->json($jobPosts);
    }

    public function recentSignups()
    {
        $startups = Startup::orderBy('created_at', 'desc')->take(5)->get();
        return response()->json($startups);
    }

    public function recentJobPosts()
    {
        $jobPosts = JobPost::orderBy('created_at', 'desc')->take(5)->get();
        return response()->json($jobPosts);
    }

    public function editAdminProfile(Request $request)
    {
        $user = auth()->user;
        if ($user) {
            $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:users,email,' . $user->id,
                'password' => 'sometimes|string|min:6|confirmed',
            ]);
            $user->update($request->only(['name', 'email']));
            return response()->json(['status' => 'success', 'message' => 'Profile updated successfully', 'user' => $user]);
        }
        return response()->json(['status' => 'error', 'message' => 'User not authenticated'], 401);
    }

    public function deleteAdminProfile(Request $request)
    {
        $user = auth()->user;
        if ($user) {
            $user->delete();
            return response()->json(['status' => 'success', 'message' => 'Profile deleted successfully']);
        }
        return response()->json(['status' => 'error', 'message' => 'User not authenticated'], 401);
    }

    public function addAdvisor(Request $request)
    {
        $user = auth()->user;
        if ($user) {
            $request->validate([
                'name' => 'required|string|max:255',
                'email' => 'required|string|email|max:255|unique:advisors',
                'location' => 'required|string|max:255',
                'phone' => 'required|string|max:255',
                'bio' => 'required|string',
                'photo_url' => 'required|string|max:255',
                'category' => 'required|string|max:255',
                'expertise' => 'required|string|max:255',
            ]);
            $advisor =  Advisor::insert($request->only(['name', 'email', 'password', 'location', 'phone', 'bio', 'photo_url', 'category', 'expertise']));

            return response()->json(['status' => 'success', 'message' => 'Advisor added successfully', 'advisor' => $advisor]);
        }
        return response()->json(['status' => 'error', 'message' => 'User not authenticated'], 401);
    }

    public function getAllAdvisors()
    {
        $advisors = Advisor::get();

        return response()->json($advisors);
    }
}
