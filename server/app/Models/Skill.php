<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Skill extends Model
{
    protected $table = 'skills';

    use HasFactory;
    public $timestamps = false;

    protected $fillable = [
        'name',
        'industry_id',
    ];

    public function jobSeekers()
    {
        return $this->belongsToMany(JobSeeker::class);
    }

    public function jobPosts()
    {
        return $this->belongsToMany(JobPost::class);
    }

    public function industry()
    {
        return $this->belongsTo(Industry::class);
    }
}
