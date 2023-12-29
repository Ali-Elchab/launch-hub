<?php

namespace App\Http\Controllers;

use App\Models\Startup;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class StartupController extends Controller
{
    //


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


    public function deleteStartupProfile(Request $request, $id = null)
    {
        if ($id) {
            $user = User::find($id);
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
