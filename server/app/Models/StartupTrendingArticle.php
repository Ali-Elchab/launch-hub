<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StartupTrendingArticle extends Model
{
    use HasFactory;


    protected $fillable = [
        'article_name',
        'description',
        'link',
        'image_url',
        'startup_id',
    ];

    public function startup()
    {
        return $this->belongsTo(Startup::class);
    }
}
