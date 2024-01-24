<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Skill extends Model
{
    protected $table = 'skills';

    use HasFactory;
    use SoftDeletes;

    public $timestamps = false;

    protected $fillable = [
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

    public function specializations()
    {
        return $this->belongsTo(Specialization::class);
    }
}
