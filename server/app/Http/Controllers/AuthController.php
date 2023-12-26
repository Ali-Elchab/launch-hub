<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\Models\JobSeeker;
use App\Models\Startup;
use App\Models\User;
use function uploadImage;
use function uploadFile;
use function uploadLogo;

class AuthController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register_jobseeker', 'register_startup']]);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);
        $credentials = $request->only('email', 'password');

        $token = Auth::attempt($credentials);
        if (!$token) {
            return response()->json([
                'status' => 'error',
                'message' => 'wrong creds',
            ], 401);
        }

        $user = Auth::user();
        return response()->json([
            'status' => 'success',
            'user' => $user,
            'authorisation' => [
                'token' => $token,
                'type' => 'bearer',
            ]
        ]);
    }

    public function register_jobseeker(Request $request)
    {
        if ($request->user_type_id != 2) {
            return response()->json([
                'status' => 'error',
                'message' => 'wrong user type',
            ], 401);
        }
        try {
            $request->validate([
                'email' => 'required|string|email|unique:users,email',
                'password' => 'required|string',
                'user_type_id' => 'required|integer|exists:user_types,id',
                'industry_id' => 'required|integer|exists:industries,id',
                'bio' => 'nullable|string',
                'first_name' => 'required|string',
                'last_name' => 'required|string',
                'phone' => 'required|string',
                'dob' => 'required|date',
                'address' => 'required|string',
                'city' => 'required|string',
                'experience' => 'nullable|array',
                'experience.*.position' => 'required|string|max:255',
                'experience.*.company' => 'required|string|max:255',
                'experience.*.start_date' => 'required|date',
                'experience.*.end_date' => 'nullable|date',
                'experience.*.description' => 'nullable|string',
                'experience.*.type' => 'nullable|string|max:255',
                'experience.*.location' => 'nullable|string|max:255',
                'experience.*.industry' => 'nullable|string|max:255',

                'education' => 'nullable|array',
                'education.*.degree' => 'required|string|max:255',
                'education.*.organization' => 'required|string|max:255',
                'education.*.start_date' => 'required|date',
                'education.*.end_date' => 'nullable|date',
                'education.*.description' => 'nullable|string',

                'certifications' => 'nullable|array',
                'certifications.*.name' => 'required|string|max:255',
                'certifications.*.organization' => 'required|string|max:255',
                'certifications.*.start_date' => 'required|date',
                'certifications.*.end_date' => 'nullable|date',
                'certifications.*.description' => 'nullable|string',

                'skills' => 'nullable|array',
                'skills.*' => 'required|integer|exists:skills,id',

                'hobbies' => 'nullable|array',
                'hobbies.*' => 'required|integer|exists:hobbies,id',

                'social_media_links' => 'nullable|array',
                'social_media_links.*.platform' => 'required|string|max:255',
                'social_media_links.*.link' => 'required|url',
            ],);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->errors(),
            ], 422);
        }

        DB::beginTransaction();
        try {
            $profile = uploadImage($request);
            $resume = uploadFile($request);
            $user = new User([
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'user_type_id' => $request->user_type_id,
            ]);
            $user->save();

            $jobseeker = new JobSeeker([
                'user_id' => $user->id,
                'industry_id' => $request->industry_id,
                'first_name' => $request->first_name,
                'last_name' => $request->last_name,
                'profile_pic' => $profile ?? null,
                'phone' => $request->phone,
                'dob' => $request->dob,
                'bio' => $request->bio,
                'address' => $request->address,
                'city' => $request->city,
                'resume' => $resume ?? null,

            ]);
            $jobseeker->save();

            if (!empty($request->experience))
                $jobseeker->experiences()->createMany($request->experience);
            if (!empty($request->education))
                $jobseeker->educations()->createMany($request->education);
            if (!empty($request->certifications))
                $jobseeker->certifications()->createMany($request->certifications);
            if (!empty($request->skills))
                $jobseeker->skills()->attach($request->skills);
            if (!empty($request->hobbies))
                $jobseeker->hobbies()->attach($request->hobbies);
            if (!empty($request->social_media_links))
                $user->socialMediaLinks()->createMany($request->social_media_links);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'job seeker created successfully',
                'user' => User::with('jobSeeker')->find($user->id),
            ]);
        } catch (\Illuminate\Database\QueryException $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function register_startup(Request $request)
    {
        if ($request->user_type_id != 1) {
            return response()->json([
                'status' => 'error',
                'message' => 'wrong user type',
            ], 401);
        }
        try {
            $request->validate([
                'email' => 'required|string|email|unique:users,email',
                'password' => 'required|string',
                'user_type_id' => 'required|integer|exists:user_types,id',
                'industry_id' => 'required|integer|exists:industries,id',
                'company_name' => 'required|string',
                'company_email' => 'required|string|email',
                'company_phone' => 'required|string',
                'company_description' => 'required|string',
                'registeration_number' => 'required|string',
                'founding_date' => 'required|date',
                'company_address' => 'required|string',
                'website_url' => 'nullable|url',

            ],);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->errors(),
            ], 422);
        }

        DB::beginTransaction();
        try {
            $user = new User([
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'user_type_id' => $request->user_type_id,
            ]);
            $user->save();

            $logo = uploadLogo($request);
            $startup = new Startup([
                'user_id' => $user->id,
                'industry_id' => $request->industry_id,
                'company_name' => $request->company_name,
                'company_email' => $request->company_email,
                'company_phone' => $request->company_phone,
                'logo_url' => $logo ?? null,
                'company_description' => $request->company_description,
                'registeration_number' => $request->registeration_number,
                'founding_date' => $request->founding_date,
                'company_address' => $request->company_address,
                'website_url' => $request->website_url,
                'founders' => $request->founders,
                'ceos' => $request->ceos,
                'key_executives' => $request->key_executives,
            ]);
            $startup->save();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'startup created successfully',
                'user' => User::with('startup')->find($user->id),
            ]);
        } catch (\Illuminate\Database\QueryException $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }
    public function logout()
    {
        Auth::logout();
        return response()->json([
            'status' => 'success',
            'message' => 'logged out successfully',
        ]);
    }


    public function refresh()
    {
        $token = Auth::refresh();
        return response()->json([
            'status' => 'success',
            'authorisation' => [
                'token' => $token,
                'type' => 'bearer',
            ]
        ]);
    }
}
