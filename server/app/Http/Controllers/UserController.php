<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Notifications\Notifiable;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    use HasFactory, Notifiable;


    public function __construct()
    {
        $this->middleware('auth:api');
    }


    public function deleteJobSeekerProfile(Request $request, $userID = null)
    {
        if ($userID) {
            $user = User::find($userID);
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

    public function deleteStartupProfile(Request $request, $userID = null)
    {
        if ($userID) {
            $user = User::find($userID);
        } else {
            $user = $request->user();
        }
        $startup = $user->startup;
        if ($startup) {

            $logo = $startup->logo_url;
            $logoPath = 'assets/resumes/' . $logo;

            if ($logo && Storage::disk('public')->exists($logoPath)) {
                Storage::disk('public')->delete($logoPath);
            }
            $user->delete();
            return response()->json(['status' => 'success', 'message' => 'Startup deleted successfully']);
        }
        return response()->json(['status' => 'error', 'message' => 'Startup not found'], 404);
    }
}
