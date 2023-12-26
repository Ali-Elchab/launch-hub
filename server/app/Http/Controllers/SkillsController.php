<?php

namespace App\Http\Controllers;

use App\Models\Skill;
use Illuminate\Http\Request;

class SkillsController extends Controller
{
    public function getSkillsByIndustry(Request $request)
    {
        $industry = $request->industry_id;
        $skills = Skill::where('industry_id', $industry)->get();
        return response()->json(['status' => 'success', 'skills' => $skills]);
    }

    public function getGeneralSkills()
    {
        $skills = Skill::where('industry_id', null)->get();
        return response()->json(['status' => 'success', 'skills' => $skills]);
    }
}
