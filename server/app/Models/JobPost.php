<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class JobPost extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $fillable = [
        'job_title',
        'job_description',
        'job_location',
        'job_type',
        'job_salary',
        'job_qualification',
        'experience_level',
        'responsibilities',
        'education_level',
        'preferred_gender',
        'deadline',
        'job_status',
        'industry_id',
        'specialization_id',
        'startup_id',
    ];

    public function industry()
    {
        return $this->belongsTo(Industry::class);
    }

    public function specialization()
    {
        return $this->belongsTo(Specialization::class);
    }

    public function startup()
    {
        return $this->belongsTo(Startup::class);
    }

    public function jobSeekers()
    {
        return $this->belongsToMany(JobSeeker::class, 'applications');
    }

    public function requiredSkills()
    {
        return $this->belongsToMany(Skill::class, 'job_post_required_skills', 'job_post_id', 'skill_id');
    }
}
