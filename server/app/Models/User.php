<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'email',
        'password',
    ];


    public function userType()
    {
        return $this->belongsTo(UserType::class);
    }

    public function socialMediaLinks()
    {
        return $this->hasMany(SocialMediaLink::class);
    }

    public function messages()
    {
        return $this->hasMany(Message::class);
    }

    public function jobSeeker()
    {
        return $this->hasOne(JobSeeker::class);
    }

    public function startup()
    {
        return $this->hasOne(Startup::class);
    }





    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];
}
