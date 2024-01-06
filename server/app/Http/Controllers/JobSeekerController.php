<?php

namespace App\Http\Controllers;

use App\Models\JobPost;
use App\Models\JobSeeker;
use App\Models\JobSeekerEnhaceSkillsCourse;
use App\Models\Skill;
use App\Models\User;
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



    public function getRelatedCourses(Request $request)
    {
        $jobSeeker = $request->user()->jobSeeker;
        if ($jobSeeker) {
            $courses = JobSeekerEnhaceSkillsCourse::where('specialization_id', $jobSeeker->specialization_id)->get();
            return response()->json(['status' => 'success', 'courses' => $courses]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }

    public function updateJobSeekerProfile(Request $request)
    {
        $profileImagePath = uploadImage($request);
        $resumePath = uploadFile($request);
        $jobSeeker = $request->user()->jobSeeker;
        if ($jobSeeker) {
            $updateData = $request->only('first_name', 'last_name', 'phone', 'address', 'city', 'bio');
            if ($profileImagePath) {
                $updateData['profile_pic'] = $profileImagePath;
            }
            if ($resumePath) {
                $updateData['resume'] = $resumePath;
            }

            $jobSeeker->update($updateData);
            return response()->json(['status' => 'success', 'jobSeeker' => $jobSeeker]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }

    public function deleteJobSeekerProfile(Request $request, $id = null)
    {
        if ($id) {
            $user = User::find($id);
        } else {
            $user = $request->user();
        }
        $jobSeeker = $user->jobSeeker;
        if ($jobSeeker) {

            $resume = $jobSeeker->resume;
            $resumePath = 'assets/resumes/' . $resume;
            if ($resume && Storage::disk('public')->exists($resumePath)) {
                Storage::disk('public')->delete($resumePath);
            }

            $profilePicture = $jobSeeker->profile_pic;
            $profilePicturePath = 'assets/images/profile_pics' . $profilePicture;
            if ($profilePicture && Storage::disk('public')->exists($profilePicturePath)) {
                Storage::disk('public')->delete($profilePicturePath);
            }

            $user->delete();
            return response()->json(['status' => 'success', 'message' => 'Job seeker deleted successfully']);
        }
        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }
}
