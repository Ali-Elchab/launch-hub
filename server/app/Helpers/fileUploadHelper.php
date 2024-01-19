<?php

use Illuminate\Support\Facades\Storage;

function uploadImage($request)
{
    if ($request->profile_pic) {
        try {
            $base64Image = $request->profile_pic;
            $imageData = base64_decode($base64Image);
            // print_r($imageData);
            $fileName = 'image_' . time() . '.png';
            Storage::disk(public_path('assets\images\profile_pics\\'))->put($fileName, $imageData);
            return $fileName;
        } catch (\Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
    return null;
}
function uploadLogo($request)
{
    if ($request->logo_url) {
        try {
            $base64Image = $request->logo_url;
            $imageData = base64_decode($base64Image);
            $fileName = 'image_' . time() . '.png';
            Storage::disk(public_path('assets/logos'))->put($fileName, $imageData);
            return $fileName;
        } catch (\Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
    return null;
}

function uploadFile($request)
{

    if ($request->resume) {
        try {
            $base64Image = $request->resume;
            $resumeData = base64_decode($base64Image);
            $fileName = 'resume_' . time() . '.png';
            Storage::disk(public_path('assets/files'))->put($fileName, $resumeData);

            return $fileName;
        } catch (\Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
    return null;
}
