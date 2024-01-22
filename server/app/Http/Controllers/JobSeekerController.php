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
        $user = auth()->user();
        if ($user && $user->jobSeeker) {
            $jobSeeker = $user->jobSeeker;
            return response()->json(['status' => 'success', 'jobSeeker' => $jobSeeker]);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }

    public function getJobSeeker($id = null)
    {
        if ($id) {
            $jobSeeker = JobSeeker::find($id);
            $user = $jobSeeker->user;
        } else {
            $user = auth()->user();
            $jobSeeker = $user->jobSeeker;
        }

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
        $jobseekers = $jobseekers->map(function ($jobseeker) {
            $user = User::find($jobseeker->user_id);
            $jobseeker->email = $user->email;
            return $jobseeker;
        });
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
        try {
            $profileImagePath = uploadImage($request);
            $resumePath = uploadFile($request);
            $jobSeeker = $request->user()->jobSeeker;
            $user = $request->user();
            if ($jobSeeker) {
                $updateData = $request->only('first_name', 'last_name', 'phone', 'address', 'bio');
                if ($profileImagePath) {
                    $updateData['profile_pic'] = $profileImagePath;
                }
                if ($resumePath) {
                    $updateData['resume'] = $resumePath;
                }
                if (!empty($request->experiences))
                    $jobSeeker->experiences()->createMany($request->experiences);
                if (!empty($request->educations))
                    $jobSeeker->educations()->createMany($request->educations);
                if (!empty($request->certifications))
                    $jobSeeker->certifications()->createMany($request->certifications);
                if (!empty($request->skills))
                    $jobSeeker->skills()->attach($request->skills);
                if (!empty($request->hobbies))
                    $jobSeeker->hobbies()->attach($request->hobbies);
                if (!empty($request->social_media_links))
                    $user->socialMediaLinks()->createMany($request->social_media_links);
                $jobSeeker->update($updateData);
                return response()->json(['status' => 'success', 'jobSeeker' => $jobSeeker]);
            }
        } catch (\Exception $e) {
            echo $e->getMessage();
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
