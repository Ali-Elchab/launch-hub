<?php

use Illuminate\Support\Facades\File;

function uploadImage($request)
{

    if ($request->profile_pic) {
        try {
            $base64Image = $request->profile_pic;
            $imageData = base64_decode($base64Image);
            $fileName = 'image_' . time() . '.png';
            $destinationPath = public_path('assets/images/profile_pics');
            if (!File::isDirectory($destinationPath)) {
                File::makeDirectory($destinationPath, 0777, true, true);
            }
            File::put($destinationPath . '/' . $fileName, $imageData);
            return $fileName;
        } catch (\Exception $e) {
            throw ['error' => $e->getMessage()];
        }
    }
}
function uploadLogo($request)
{
    if ($request->logo_url) {
        try {
            $base64Image = $request->logo_url;
            $imageData = base64_decode($base64Image);
            $fileName = 'image_' . time() . '.png';
            $destinationPath = public_path('assets/images/profile_pics');
            if (!File::isDirectory($destinationPath)) {
                File::makeDirectory($destinationPath, 0777, true, true);
            }
            File::put($destinationPath . '/' . $fileName, $imageData);
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
            $destinationPath = public_path('assets/images/profile_pics');
            if (!File::isDirectory($destinationPath)) {
                File::makeDirectory($destinationPath, 0777, true, true);
            }
            File::put($destinationPath . '/' . $fileName, $resumeData);
            return $fileName;
        } catch (\Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
    return null;
}
