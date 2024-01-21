<?php

namespace App\Http\Controllers;

use App\Models\Advisor;
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
            $startup = Startup::with(['user.socialMediaLinks'])->find($id);
            if (!$startup) {
                return response()->json(['status' => 'error', 'message' => 'Startup not found'], 404);
            }
            $startup->socialMediaLinks = $startup->user->socialMediaLinks ?? [];
            unset($startup->user);
        } else {
            $user = auth()->user();
            $startup = $user->startup;

            if (!$startup) {
                return response()->json(['status' => 'error', 'message' => 'Startup not found'], 404);
            }
            $startup->socialMediaLinks = $user->socialMediaLinks ?? [];
        }
        return response()->json(['status' => 'success', 'startup' => $startup], 200);
    }

    public function updateStartupProfile(Request $request)
    {
        try {
            $request->validate([
                'company_name' => 'string',
                'company_email' => 'email',
                'company_phone' => 'string',
                'company_description' => 'string',
                'registration_number' => 'string',
                'founding_date' => 'string',
                'company_address' => 'string',
                'website_url' => 'string',
                'founders' => 'array',
                'ceos' => 'nullable|array',
                'key_executives' => 'nullable|array',
                'specialization_id' => 'nullable|exists:specializations,id',
                'industry_id' => 'exists:industries,id',
            ]);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => $e->getMessage()], 400);
        }

        $user = User::find(auth()->user()->id);
        $startup = $user->startup;
        if (!$user || !$startup) {
            return response()->json(['status' => 'error', 'message' => 'User not found'], 404);
        }
        try {
            $logo = uploadLogo($request);
            if ($logo) {
                $startup->logo_url = $logo;
                $startup->save();
            }
            $startup->update(
                $request->only([
                    'company_name', 'company_email', 'company_phone', 'company_description', 'registration_number', 'founding_date', 'company_address', 'website_url', 'founders', 'ceos', 'key_executives', 'specialization_id', 'industry_id',
                ])
            );
            $startup->save();
            if (!empty($request->social_media_links))
                $user->socialMediaLinks()->createMany($request->social_media_links);
            return response()->json(['status' => 'success', 'message' => 'Startup profile updated successfully']);
        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => $e->getMessage()], 400);
        }
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
            return response()->json(['status' => 'success', 'message' => 'Startup deleted successfully'], 200);
        }
        return response()->json(['status' => 'error', 'message' => 'Startup not found'], 404);
    }

    public function getAdvisors(Request $request)
    {
        $advisors = Advisor::get();
        return response()->json($advisors);
    }
}
