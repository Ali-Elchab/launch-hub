<?php

namespace App\Http\Controllers;

use App\Models\JobPost;
use App\Models\JobSeeker;
use App\Models\User;
use Illuminate\Http\Request;
use OpenAI\Laravel\Facades\OpenAI;

class JobPostController extends Controller
{


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
        // $jobPosts = $startup->jobposts()->with('requiredSkills')->get();
        $jobPosts = JobPost::where('startup_id', $startup->id)
            ->with(['requiredSkills', 'startup'])
            ->get();
        return response()->json(['status' => 'success', 'jobPosts' => $jobPosts]);
    }

    public function updateJobPost(Request $request, $id)
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
        $jobpost = JobPost::find($id);
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
                'required_skills' => 'required|array',
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

        if (!empty($request->required_skills))
            $jobpost->requiredSkills()->attach($request->required_skills);
        return response()->json(['status' => 'success', 'message' => 'Job post created successfully']);
    }




    public function getRelatedJobPosts(Request $request, $specialization_id = null)
    {
        try {
            $user = auth()->user();
            if (!$user) {
                return response()->json(['status' => 'error', 'message' => 'Authentication required'], 401);
            }

            $jobPosts = JobPost::get();
            if ($jobPosts->isEmpty()) {
                return response()->json(['status' => 'error', 'message' => 'Related job posts not found'], 404);
            }

            $jobSeeker = $user->jobSeeker;
            if (!$jobSeeker) {
                return response()->json(['status' => 'error', 'message' => 'job Seeker details not found'], 404);
            }

            $jobSeeker = $user->jobSeeker;
            $name = $jobSeeker->first_name . ' ' . $jobSeeker->last_name;
            $dob = $jobSeeker->dob;
            $bio = $jobSeeker->bio;
            $address = $jobSeeker->address;
            $industry = $jobSeeker->industry->name;
            $specialization = $jobSeeker->specialization->name;
            $skills = $jobSeeker->skills->pluck('name')->toArray();
            $skillsString = implode(", ", $skills);


            $prompt = "I am an AI assistant providing career and professional advice to individuals. ";
            $prompt .= "Here are the details of the individual seeking advice: ";
            $prompt .= "Name: $name, Industry: $industry, Specialization: $specialization, Skills: $skillsString Date of Birth: $dob, ";
            $prompt .= "Professional Biography: $bio, Location: $address. ";
            $prompt .= "Considering the individual's experience in $industry and their specialization in $specialization, they are seeking job opportunities that align with their skill set and career aspirations. ";
            $prompt .= "It is essential to suggest job opportunities that are relevant to their professional background. Avoid suggesting positions in fields that do not align with their expertise and career goals. ";
            $prompt .= "Based on the individual's qualifications, location, and preferred industry and specialization, and skills, suggest the most suitable job posts from the following list: $jobPosts ";
            $prompt .= "The response should list the IDs of the suggested job posts in the following format: [id1, id2, ...].";
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

            $jobPosts = JobPost::whereIn('id', $idsArray)
                ->with(['requiredSkills', 'startup'])
                ->get();
            // $jobPosts->load(['requiredSkills']);
            // $jobPosts = $$jobPosts->with('industry,specialization');

            return response()->json(['status' => 'success', 'jobPosts' => $jobPosts]);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'An unexpected error occurred', 'error' => $e->getMessage()], 500);
        }
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
