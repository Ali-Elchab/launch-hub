<?php

namespace App\Http\Controllers;

use App\Models\JobSeeker;
use Illuminate\Http\Request;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use PHPOpenSourceSaver\JWTAuth\Contracts\JWTSubject;
use App\Models\User;
use Illuminate\Support\Facades\DB;

class AuthController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register_jobseeker']]);
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
        try {

            $request->validate([
                'email' => 'required|string|email|unique:users,email',
                'password' => 'required|string',
                'user_type_id' => 'required|integer|exists:user_types,id',
                'first_name' => 'required|string',
                'last_name' => 'required|string',
                'phone' => 'required|string',
                'dob' => 'required|date',
                'address' => 'required|string',
                'city' => 'required|string',
                'profile_pic' => 'nullable|string',
                'resume' => 'nullable|string',
                'is_available' => 'nullable|boolean',
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
        if ($request->hasFile('post_image')) {
            $request->validate([
                "post_image" => 'image|max:6000'
            ]);
            $file = $request->file('post_image');
            $extension = $file->getClientOriginalExtension();
            $filename = time() . '.' . $extension;
            $file->move(public_path('images/posts'), $filename);
        }
        DB::beginTransaction();
        try {


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
                'profile_pic' => $filename,
                'phone' => $request->phone,
                'dob' => $request->dob,
                'profile_pic' => $request->profile_pic,
                'bio' => $request->bio,
                'address' => $request->address,
                'city' => $request->city,
                'resume' => $request->resume,
                'is_available' => $request->is_available,
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
            if (!empty($request->courses))
                $jobseeker->courses()->createMany($request->courses);

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'job seeker created successfully',
                'user' => User::with('jobSeeker')->find($user->id),
            ]);
        } catch (\Illuminate\Database\QueryException $e) {
            DB::rollback();
            $errorCode = $e->errorInfo[1];
            if ($errorCode == 1062) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'The email address has already been taken.'
                ], 409);
            }
        }
    }
}
