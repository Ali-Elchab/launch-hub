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
        'profile_pic',
        'dob',
        'phone',
        'bio',
        'address',
        'city',
        'resume',
        'industry_id',
        'specialization_id',
        'user_id',
        'is_available',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function industry()
    {
        return $this->belongsTo(Industry::class);
    }

    public function specialization()
    {
        return $this->belongsTo(Specialization::class);
    }

    public function jobPosts()
    {
        return $this->belongsToMany(JobPost::class, 'applications')
            ->withPivot('status');
    }

    public function skills()
    {
        return $this->belongsToMany(Skill::class, 'job_seekers_has_skills', 'job_seeker_id', 'skill_id');
    }


    public function hobbies()
    {
        return $this->belongsToMany(Hobby::class, 'job_seeker_has_hobbies', 'job_seeker_id', 'hobby_id');
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
}
