<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SocialMediaLink extends Model
{
    use HasFactory;
    use SoftDeletes;


    protected $fillable = [
        'link',
        "platform",
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
