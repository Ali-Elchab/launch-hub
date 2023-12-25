<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Education extends Model
{
    use HasFactory;
    protected $table = 'education';


    protected $fillable = [
        'name',
        'degree',
        'organization',
        'start_date',
        'end_date',
        'description',
        'location',
        'job_seeker_id',
        'location',
    ];

    public function jobSeeker()
    {
        return $this->belongsTo(JobSeeker::class);
    }
}
