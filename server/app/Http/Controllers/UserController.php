<?php

namespace App\Http\Controllers;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use PHPOpenSourceSaver\JWTAuth\Contracts\JWTSubject;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    use HasFactory, Notifiable;


    public function __construct()
    {
        $this->middleware('auth:api');
    }


    public function deleteJobSeekerProfile(Request $request)
    {
        $user = $request->user();
        $jobSeeker = $user->jobSeeker;

        if ($jobSeeker) {

            $resume = $jobSeeker->resume;
            $resumePath = 'assets/resumes/' . $resume;

            if ($resume && Storage::disk('public')->exists($resumePath)) {
                Storage::disk('public')->delete($resumePath);
            }
            $jobSeeker->delete();

            return response()->json(['status' => 'success', 'message' => 'Job seeker and resume deleted successfully']);
        }

        return response()->json(['status' => 'error', 'message' => 'Job seeker not found'], 404);
    }
}
