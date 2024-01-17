<?php

namespace App\Http\Controllers;

use App\Models\Hobby;
use App\Models\Industry;
use App\Models\Skill;
use App\Models\Specialization;
use Illuminate\Http\Request;

class DataController extends Controller
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

    public function getHobbies()
    {
        $hobbies = Hobby::all();
        return response()->json(['status' => 'success', 'hobbies' => $hobbies]);
    }

    public function getIndustries($id = null)
    {
        if ($id) {
            $industry = Industry::where('id', $id)->first();
            return response()->json(['status' => 'success', 'industry' => $industry]);
        }
        $industries = Industry::all();
        return response()->json(['status' => 'success', 'industries' => $industries]);
    }

    public function getSpecializations($id = null)
    {
        if ($id) {
            $specialization = Specialization::where('id', $id)->first();
            return response()->json(['status' => 'success', 'specialization' => $specialization]);
        }
        $specializations = Specialization::all();
        return response()->json(['status' => 'success', 'specializations' => $specializations]);
    }
    public function getSpecializationsByIndustry(Request $request)
    {
        $industry = $request->industry_id;
        $specializations = Specialization::where('industry_id', $industry)->get();
        return response()->json(['status' => 'success', 'specializations' => $specializations]);
    }
}
