<?php

namespace App\Http\Controllers;

use App\Models\Advisor;
use App\Models\Application;
use App\Models\Industry;
use App\Models\JobPost;
use App\Models\JobSeeker;
use App\Models\Startup;
use Illuminate\Http\Request;
use App\Http\Controllers\JobSeekerController;
use App\Http\Controllers\StartupController;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AdminController extends Controller
{

    public function _construct()
    {
        $this->middleware('auth:api');
    }

    public function getStatistics()
    {
        $startups = Startup::count();
        $jobSeekers = JobSeeker::count();
        $pendingApplications = Application::where('status', 'pending')->get()->count();
        $rejectedApplications = Application::where('status', 'rejected')->get()->count();
        $totalRegisteredUsers = $startups + $jobSeekers;
        $leadingIndustry = Startup::selectRaw('industry_id, COUNT(*) ')
            ->groupBy('industry_id')
            ->orderByRaw('COUNT(*) DESC')
            ->first()->industry_id;
        $leadingIndustry = Industry::find($leadingIndustry)->name;
        return response()->json(['startups' => $startups, 'jobSeekers' => $jobSeekers, 'pendingApplications' => $pendingApplications, 'rejectedApplications' => $rejectedApplications, 'totalRegisteredUsers' => $totalRegisteredUsers, 'leadingIndustry' => $leadingIndustry], 200);
    }
    public function getAllStartups()
    {
        $startups = Startup::all();
        $count = Startup::count();
        return response()->json(['startups' => $startups, 'count' => $count]);
    }

    public function getAllJobSeekers()
    {
        $jobseekers = JobSeeker::all();
        if (!$jobseekers) {
            return response()->json(['status' => 'error', 'message' => 'Related jobseekers not found'], 404);
        }
        return response()->json(['status' => 'success', 'jobseekers' => $jobseekers]);
    }
    public function getAllJobPosts()
    {
        $jobPosts = JobPost::all();
        if (!$jobPosts) {
            return response()->json(['status' => 'error', 'message' => 'jobPosts not found'], 404);
        }
        return response()->json($jobPosts);
    }

    public function getAllApplications()
    {
        $applications = Application::with('jobSeeker', 'jobPost')->get();
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


    public function deleteApplication($id)
    {
        $application = Application::find($id);
        if (!$application) {
            return response()->json(['status' => 'error', 'message' => 'Application not found'], 404);
        }

        $application->delete();
        return response()->json(['status' => 'success', 'message' => 'Application deleted successfully']);
    }

    public function editAdminProfile(Request $request)
    {
        $user = User::find(auth()->user()->id);
        $request->validate([
            'email' => 'required|string|email|max:255|unique:users,email,' . $user->id,
            'password' => 'sometimes|string|min:6',
        ]);
        $user->email = $request->email;
        $user->password = Hash::make($request->password);

        $user->save();
        return response()->json(['status' => 'success', 'message' => 'Profile updated successfully', 'user' => $user], 200);
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

    public function deleteAdvisor($id)
    {
        $advisor = Advisor::find($id);
        if (!$advisor) {
            return response()->json(['status' => 'error', 'message' => 'Advisor not found'], 404);
        }

        $advisor->delete();
        return response()->json(['status' => 'success', 'message' => 'Advisor deleted successfully']);
    }
}
