<?php

namespace Database\Seeders;

use App\Models\Industry;
use App\Models\Specialization;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class SpecializationsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $industrySpecializations = [
            'Technology' => [
                'Software Development',
                'Cybersecurity',
                'Data Science',
                'AI & Machine Learning',
                'Cloud Computing',
                'Network Engineering',
                'UI/UX Design',
                'Mobile App Development',
                'Game Development',
                'IT Project Management'
            ],
            'Healthcare' => [
                'Nursing',
                'General Medicine',
                'Dentistry',
                'Pediatrics',
                'Radiology',
                'Pharmacology',
                'Biomedical Engineering',
                'Healthcare Administration',
                'Physical Therapy',
                'Mental Health Services'
            ],
            'Finance' => [
                'Investment Banking',
                'Accounting',
                'Financial Planning',
                'Insurance',
                'Corporate Finance',
                'Financial Analysis',
                'Tax Advisory',
                'Risk Management',
                'Wealth Management',
                'Regulatory Compliance'
            ],
            'Education' => [
                'Early Childhood Education',
                'Special Education',
                'Curriculum Development',
                'Educational Administration',
                'Tutoring',
                'E-Learning',
                'Higher Education',
                'Educational Technology',
                'Literacy Program Coordination',
                'Career Counseling'
            ],
            'Manufacturing' => [
                'Quality Control',
                'Supply Chain Management',
                'Industrial Engineering',
                'Product Design',
                'Plant Management',
                'Operations Research',
                'Lean Manufacturing',
                'Safety Management',
                'Process Engineering',
                'Maintenance Supervision'
            ],
            'Retail' => [
                'Store Management',
                'Merchandising',
                'Retail Buying',
                'Sales Strategy',
                'Customer Service',
                'E-Commerce',
                'Visual Merchandising',
                'Supply Chain Coordination',
                'Brand Promotion',
                'Inventory Management'
            ],
            'Construction' => [
                'Project Management',
                'Civil Engineering',
                'Architecture',
                'Cost Estimation',
                'Site Supervision',
                'Safety Regulation Compliance',
                'Sustainability Design',
                'Urban Planning',
                'Construction Law',
                'Interior Design'
            ],
            'Energy' => [
                'Renewable Energy',
                'Petroleum Engineering',
                'Energy Efficiency Consulting',
                'Solar Energy System Design',
                'Wind Turbine Engineering',
                'Nuclear Power Management',
                'Power Grid Control',
                'Environmental Compliance',
                'Geoscience',
                'Energy Policy'
            ],
            'Telecommunications' => [
                'Network Architecture',
                'Telecom Engineering',
                'Wireless Communication',
                'Satellite Communication',
                'Fiber Optics Engineering',
                'Radio Frequency Engineering',
                'Network Security',
                'Broadband Systems',
                'Mobile Network Management',
                'Telecom Regulation'
            ],
            'Pharmaceuticals' => [
                'Clinical Research',
                'Pharmaceutical Sales',
                'Medicinal Chemistry',
                'Drug Development',
                'Regulatory Affairs',
                'Pharmacovigilance',
                'Quality Assurance',
                'Biotechnology',
                'Pharmacy Management',
                'Toxicology'
            ]
        ];


        $industries = Industry::all();
        foreach ($industries as $industry) {
            $industryName = $industry->name;
            if (isset($industrySpecializations[$industryName])) {
                foreach ($industrySpecializations[$industryName] as $specialization) {
                    Specialization::create([
                        'name' => $specialization,
                        'industry_id' => $industry?->id
                    ]);
                }
            }
        }
    }
}
