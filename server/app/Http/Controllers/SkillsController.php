<?php

namespace App\Http\Controllers;

use App\Models\Skill;
use Illuminate\Http\Request;

class SkillsController extends Controller
{
    public function getSkillsBySpecialization(Request $request)
    {
        $specialization = $request->specialization_id;
        $skills = Skill::where('specialization_id', $specialization)->get();
        return response()->json(['status' => 'success', 'skills' => $skills]);
    }

    public function getGeneralSkills()
    {
        $skills = Skill::where('specialization_id', null)->get();
        return response()->json(['status' => 'success', 'skills' => $skills]);
    }
}
