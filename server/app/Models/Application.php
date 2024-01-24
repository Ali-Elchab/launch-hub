<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;


class Application extends Model
{
    use HasFactory;
    use SoftDeletes;



    public function jobPost()
    {
        return $this->belongsTo(JobPost::class);
    }

    public function jobSeeker()
    {
        return $this->belongsTo(JobSeeker::class);
    }
}
