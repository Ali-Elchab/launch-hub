<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Startup extends Model
{
    use HasFactory;
    protected $casts = [
        'founders' => 'array',
        'ceos' => 'array',
        'key_executives' => 'array',
    ];
    protected $fillable = [
        'company_name',
        'company_email',
        'company_phone',
        'company_address',
        'company_description',
        'logo_url',
        'registeration_number',
        'founding_date',
        'website_url',
        'founders',
        'key_executives',
        'ceos',
        'user_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function jobPosts()
    {
        return $this->hasMany(JobPost::class);
    }

    public function industry()
    {
        return $this->belongsTo(Industry::class);
    }

    public function specialization()
    {
        return $this->belongsTo(Specialization::class);
    }

    public function startupFeaturedTemplates()
    {
        return $this->hasMany(StartupFeaturedTemplate::class);
    }

    public function startupTrendingArticles()
    {
        return $this->hasMany(StartupTrendingArticle::class);
    }

    public function startupRelatedCourses()
    {
        return $this->hasMany(StartupRelatedCourse::class);
    }
}
