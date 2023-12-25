<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Auth;
use PHPOpenSourceSaver\JWTAuth\Contracts\JWTSubject;

class AuthController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login', 'register']]);
    }

    //login
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required'
        ]);
        $credentials = $request->only('email', 'password');
        if ($token = $this->guard()->attempt($credentials)) {
            $user = Auth::user();
            return response()->json(['status' => 'success', 'user' => $user], 200)->header('Authorization', $token);
        }
        return response()->json(['error' => 'login_error'], 401);
    }
}
