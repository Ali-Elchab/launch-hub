<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Hobby extends Model
{
    use HasFactory;

    public function jobSeekers()
    {
        return $this->belongsToMany(JobSeeker::class);
    }
}
