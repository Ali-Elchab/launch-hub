<?php

function uploadImage($request)
{
    if ($request->hasFile('profile_pic')) {
        try {
            $request->validate([
                "profile_pic" => 'image|max:6000'
            ]);

            $file = $request->file('profile_pic');
            $extension = $file->getClientOriginalExtension();
            $filename = time() . '.' . $extension;
            $file->move(public_path('images/profile_pics'), $filename);
            return $filename;
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
            $file->move(public_path('resumes'), $filename);
            return $filename;
        } catch (\Exception $e) {
            return ['error' => $e->getMessage()];
        }
    }
    return null;
}
