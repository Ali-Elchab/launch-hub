<?php

namespace App\Http\Controllers;

use App\Models\JobSeeker;
use Illuminate\Http\Request;

class StartupController extends Controller
{
    //

    public function getStartup()
    {
        $user = auth()->user();
        $startup = $user->startup;
        if (!$user || !$startup) {
            return response()->json(['status' => 'error', 'message' => 'User not found'], 404);
        }
        $startup->socialMediaLinks = $user->socialMediaLinks;
        return response()->json($startup);
    }

    public function updateStartupProfile(Request $request)
    {
        $user = auth()->user();
        $startup = $user->startup;
        if (!$user || !$startup) {
            return response()->json(['status' => 'error', 'message' => 'User not found'], 404);
        }
        $startup->update($request->all());
        return response()->json(['status' => 'success', 'message' => 'Startup profile updated successfully']);
    }

    public function getRelatedJobSeekers(Request $request)
    {
        $startup = auth()->user()->startup;
        $specialization_id = $startup->specialization_id;
        print_r($specialization_id);
        $jobseekers = JobSeeker::where('specialization_id', $specialization_id)->get();
        if (!$jobseekers) {
            return response()->json(['status' => 'error', 'message' => 'Related jobseekers not found'], 404);
        }
        return response()->json(['status' => 'success', 'jobseekers' => $jobseekers]);
    }
}
