<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Industry extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = [
        'name',
    ];

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
