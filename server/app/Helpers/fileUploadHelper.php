<?php

use Illuminate\Support\Facades\Storage;

function uploadImage($request)
{
    if ($request->profile_pic) {
        try {
            $base64Image = $request->profile_pic;
            $imageData = base64_decode($base64Image);
            $fileName = 'image_' . time() . '.png';
            Storage::disk('public')->put($fileName, $imageData);
            return $fileName;
        } catch (\Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
    return null;
}

function uploadFile($request)
{
    if ($request->hasFile('resume')) {
        try {
            $request->validate([
                "resume" => 'file|max:10000'
            ]);

            $file = $request->file('resume');
            $extension = $file->getClientOriginalExtension();
            $filename = time() . '.' . $extension;
            $file->move(public_path('assets/resumes'), $filename);
            return $filename;
        } catch (\Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
    return null;
}
function uploadLogo($request)
{
    if ($request->hasFile('logo_url')) {
        try {
            $request->validate([
                "logo_url" => 'file|max:10000'
            ]);

            $file = $request->file('logo_url');
            $extension = $file->getClientOriginalExtension();
            $filename = time() . '.' . $extension;
            $file->move(public_path('assets/logos'), $filename);
            return $filename;
        } catch (\Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
    return null;
}
