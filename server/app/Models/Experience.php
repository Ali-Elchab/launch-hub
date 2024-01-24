<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Experience extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = 'experience';
    protected $fillable = [
        'position',
        'company',
        'type',
        'industry_id',
        'specialization_id',
        'start_date',
        'end_date',
        'description',
        'location',
    ];

    public function jobSeeker()
    {
        return $this->belongsTo(JobSeeker::class);
    }
}
