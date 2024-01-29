<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Auth\Events\PasswordReset;
use Illuminate\Support\Facades\Password;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;

class PasswordResetController extends Controller
{
    public function sendResetLinkEmail(Request $request)
    {
        $request->validate(['email' => 'required|email']);

        $user = User::where('email', $request->email)->first();
        if (!$user) {
            return response()->json(['message' => 'Email does not exist.'], 404);
        }
        $token = Str::random(60);
        $user->token = $token;
        $user->expires_at = now()->addHours(1);
        $user->save();
        Mail::send('reset', ['token' => $token], function ($message) use ($request) {
            $message->to($request->email)
                ->subject('Password Reset Link');
        });
        return response()->json(['message' => 'Password reset link sent.'], 200);
    }

    public function reset(Request $request)
    {
        $request->validate([
            'token' => 'required',
            'email' => 'required|email',
            'password' => 'required|confirmed',
        ]);

        $user = User::where('token', $request->token)
            ->where('email', $request->email)
            ->where('expires_at', '>', now())
            ->first();

        if (!$user) {
            return response()->json(['message' => 'Invalid token or email.'], 404);
        }

        $user->password = Hash::make($request->password);
        $user->token = null;
        $user->expires_at = null;
        $user->save();

        return response()->json(['message' => 'Your password has been reset.'], 200);
    }
}
