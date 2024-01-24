<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Industry extends Model
{
    use HasFactory;
    use SoftDeletes;

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

    public function specialization()
    {
        return $this->hasMany(Specialization::class);
    }
}
