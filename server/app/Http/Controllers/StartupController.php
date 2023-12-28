<?php

namespace App\Http\Controllers;

use App\Models\JobSeeker;
use App\Models\Startup;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Http\Request;

class StartupController extends Controller
{
    //
    public function getAllStartups()
    {
        $startups = Startup::all();
        return response()->json($startups);
    }

    public function getStartup($id = null)
    {
        if ($id) {
            $startup = Startup::find($id);

            if (!$startup) {
                return response()->json(['status' => 'error', 'message' => 'Startup not found'], 404);
            }
        } else {
            $user = auth()->user();
            if (!$user || !$user->startup) {
                return response()->json(['status' => 'error', 'message' => 'Startup not found'], 404);
            }
            $startup = $user->startup;
        }
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
}
