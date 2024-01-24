<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Specialization extends Model
{
    use HasFactory;
    use SoftDeletes;

    public function industry()
    {
        return $this->belongsTo(Industry::class);
    }

    public function jobSeekers()
    {
        return $this->hasMany(JobSeeker::class);
    }

    public function jobPosts()
    {
        return $this->hasMany(JobPost::class);
    }

    public function startups()
    {
        return $this->hasMany(Startup::class);
    }

    public function skills()
    {
        return $this->hasMany(Skill::class);
    }
}
