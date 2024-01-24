<?php

namespace App\Http\Controllers;

use App\Models\JobSeeker;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use OpenAI\Laravel\Facades\OpenAI;
use stdClass;

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

    public function getJobSeekers($specialization_id = null)
    {
        try {
            $user = auth()->user();
            if (!$user) {
                return response()->json(['status' => 'error', 'message' => 'Authentication required'], 401);
            }

            $jobseekers = JobSeeker::get();
            if ($jobseekers->isEmpty()) {
                return response()->json(['status' => 'error', 'message' => 'Related jobseekers not found'], 404);
            }

            $startup = $user->startup;
            if (!$startup) {
                return response()->json(['status' => 'error', 'message' => 'Startup details not found'], 404);
            }

            $company = $startup->company_name;
            $description = $startup->company_description;
            $foundingDate = $startup->founding_date;
            $address = $startup->company_address;
            $industry = $startup->industry->name;
            $specialization = $startup->specialization->name;

            $prompt = "I am an AI assistant providing specific advice to startups, particularly in matching them with ideal job candidates. ";
            $prompt .= "I am assisting a startup with the following profile: ";
            $prompt .= "Industry: $industry, Specialization: $specialization, Company Name: $company, ";
            $prompt .= "Description: $description, Founded On: $foundingDate, Location: $address. ";
            $prompt .= "This startup's core focus is on $industry and $specialization. In line with this, they need talented individuals for roles essential to a technology startup's ecosystem. These roles include but are not limited to accounting, finance, marketing, HR, legal, IT, and customer support. ";
            $prompt .= "It's critical to match the startup with candidates whose expertise aligns specifically with these domains. Please avoid suggesting candidates from unrelated fields such as healthcare, as they do not meet the startup's current operational needs. ";
            $prompt .= "Based on this startup's profile and operational requirements, analyze the following list of job seekers and identify those who are the most suitable: $jobseekers ";
            $prompt .= "Your response should list the IDs of the suggested job seekers in the following format: [id1, id2, ...]. ";
            $prompt .= "Ensure the response contains only the list of IDs, formatted as an array, without any additional text or commentary.";
            try {
                $result = OpenAI::completions()->create([
                    'model' => 'gpt-3.5-turbo-instruct',
                    'prompt' => $prompt,
                    'max_tokens' => 100,
                ]);
            } catch (\Exception $e) {
                return response()->json(['status' => 'error', 'message' => 'Failed to communicate with AI service', 'error' => $e->getMessage()], 500);
            }

            $response = $result['choices'][0]['text'];
            $idsString = trim($response, " \n[]");
            $idsArray = explode(", ", $idsString);
            $idsArray = array_map('intval', $idsArray);

            $jobSeekers = JobSeeker::whereIn('id', $idsArray)->get();
            $jobSeekers = $jobSeekers->map(function ($jobSeeker) {
                $user = User::find($jobSeeker->user_id);
                $jobSeeker->email = $user->email;
                return $jobSeeker;
            });

            return response()->json(['status' => 'success', 'jobseekers' => $jobSeekers]);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'An unexpected error occurred', 'error' => $e->getMessage()], 500);
        }
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
