<?php

namespace App\Http\Controllers;

use Laravel\Socialite\Facades\Socialite;
use Exception;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class GoogleAuthController extends Controller
{
    public function signInwithGoogle()
    {
        return Socialite::driver('google')->redirect();
    }
    public function callbackToGoogle()
    {
        try {

            $user = Socialite::driver('google')->user();

            $finduser = User::where('email', $user->email)->first();

            if ($finduser) {

                Auth::login($finduser);

                return 'success';
            } else {
                $newUser = User::create([
                    'email' => $user->email,
                    'user_type_id' => 1,
                    'password' => encrypt('admin@123')
                ]);

                Auth::login($newUser);

                return 'sign up success';
            }
        } catch (Exception $e) {
            dd($e->getMessage());
        }
    }
}
