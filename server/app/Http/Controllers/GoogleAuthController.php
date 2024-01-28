<?php

namespace App\Http\Controllers;

use Laravel\Socialite\Facades\Socialite;
use Exception;
use App\Models\User;
use Google\Rpc\Context\AttributeContext\Request;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;


class GoogleAuthController extends Controller
{
    public function signInwithGoogle()
    {
        return Socialite::driver('google')->redirect();
    }

    public function signUpWithGoogle(Request $request)
    {
        try {
            $user = Socialite::driver('google')->user();
            // Further token verification can be done here

            $existingUser = User::where('google_id', $user->id)->first();

            if ($existingUser) {
                auth()->login($existingUser, true);
                return response()->json(['user' => $existingUser], 200);
            } else {
                // Create a new user.
                $newUser = new User();
                $newUser->email = $user->email;
                $newUser->google_id = $user->id;
                $newUser->user_type_id = $request->user_type_id;
                $newUser->password = bcrypt(request(Str::random())); // Set some random password

                auth()->login($newUser, true);
                return response()->json(['user' => $newUser], 200);
            }
        } catch (\Exception $e) {
            // Handle exception
            return response()->json(['error' => 'An error occurred'], 500);
        }
    }
}
