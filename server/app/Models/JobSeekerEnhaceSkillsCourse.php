<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JobSeekerEnhaceSkillsCourse extends Model
{
    use HasFactory;


    protected $fillable = [
        'name',
        'link',
        'image_url',
        'description',
        'job_seeker_id',
    ];

    public function specialization()
    {
        return $this->belongsTo(Specialization::class);
    }
}
