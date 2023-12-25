<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JobSeeker extends Model
{
    use HasFactory;

    protected $fillable = [
        'first_name',
        'last_name',
        'profile_picture',
        'dob',
        'phone',
        'bio',
        'address',
        'city',
        'resume',
        'industry_id',
        'user_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function industry()
    {
        return $this->belongsTo(Industry::class);
    }

    public function skills()
    {
        return $this->belongsToMany(Skill::class);
    }

    public function hobbies()
    {
        return $this->belongsToMany(Hobby::class);
    }

    public function educations()
    {
        return $this->hasMany(Education::class);
    }

    public function experiences()
    {
        return $this->hasMany(Experience::class);
    }

    public function certifications()
    {
        return $this->hasMany(Certification::class);
    }

    public function courses()
    {
        return $this->hasMany(JobSeekerEnhaceSkillsCourse::class);
    }

    public function applications()
    {
        return $this->hasMany(Application::class);
    }
}
