<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class JobPostsTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('job_posts')->insert([
            [
                'job_title' => 'Software Developer',
                'job_description' => 'Develop and maintain software applications.',
                'job_location' => 'Remote',
                'job_type' => 'Full-time',
                'job_salary' => 80000,
                'job_qualification' => 'Bachelor’s Degree in Computer Science',
                'responsibilities' => 'Collaborate with department heads to identify staffing needs and devise effective recruitment strategies.
                Conduct the entire recruitment process, from sourcing and screening to interviewing and onboarding.
                Foster a positive and inclusive workplace culture through effective employee relations.
                Implement and maintain HR policies and procedures in alignment with industry best practices.
                Plan and conduct training sessions on various HR-related topics.
                Maintain accurate records and documentation related to employee activities.',
                'experience_level' => '1-3 years',
                'education_level' => 'Doctoral Degree',
                'preferred_gender' => 'any',
                'deadline' => now()->addWeeks(2),
                'job_status' => 'Open',
                'industry_id' => 1,
                'specialization_id' => 1,
                'startup_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'job_title' => 'Suistainability Manager',
                'job_description' => 'Assist in suistainable management in the company.',
                'job_location' => 'Beirut',
                'job_type' => 'Full-time',
                'job_salary' => 120000,
                'responsibilities' => 'Develop and implement sustainable business strategies, considering environmental, social, and economic aspects.
                Lead and coordinate sustainability projects across various departments within the company.
                Monitor and report on the progress of sustainability initiatives and their impact on the company and environment.
                Collaborate with internal teams and external stakeholders to enhance sustainability practices.
                Ensure company compliance with environmental regulations and standards.
                Research and stay updated on sustainable practices, technologies, and legislation.
                Educate and train staff on sustainable practices and their importance.
                Develop sustainability reports and present findings to senior management and stakeholders.
                Identify opportunities for cost savings and efficiency improvements through sustainable practices.
                Foster a culture of sustainability within the organization through workshops, events, and campaigns.',
                'job_qualification' => 'Bachelor’s or Master’s degree in Environmental Science, Sustainability, Corporate Social Responsibility, or a related field.
                Proven experience in sustainability, environmental management, or corporate social responsibility.
                Strong knowledge of sustainability standards and regulations.
                Excellent leadership and project management skills.
                Ability to analyze data and produce detailed reports.',
                'experience_level' => '1-3 years',
                'education_level' => 'Masters Degree',
                'preferred_gender' => 'any',
                'deadline' => now()->addWeeks(2),
                'job_status' => 'Open',
                'specialization_id' => 76,
                'industry_id' => 8,
                'startup_id' => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],

            [
                'job_title' => 'Data Analyst',
                'job_description' => 'Interpret data and analyze results using statistical techniques.',
                'job_location' => 'San Francisco',
                'job_type' => 'Contract',
                'job_salary' => 90000,
                'responsibilities' => 'Collaborate with department heads to identify staffing needs and devise effective recruitment strategies.
                Conduct the entire recruitment process, from sourcing and screening to interviewing and onboarding.
                Foster a positive and inclusive workplace culture through effective employee relations.
                Implement and maintain HR policies and procedures in alignment with industry best practices.
                Plan and conduct training sessions on various HR-related topics.
                Maintain accurate records and documentation related to employee activities.',
                'job_qualification' => 'Bachelor’s Degree in Statistics or Mathematics',
                'experience_level' => '1-3 years',
                'education_level' => 'Doctoral Degree',
                'preferred_gender' => 'any',
                'deadline' => now()->addWeeks(1),
                'job_status' => 'Open',
                'industry_id' => 1,
                'specialization_id' => 3,
                'startup_id' => 3,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'job_title' => 'Accountant',
                'job_description' => 'Manage financial transactions, analyze financial data, and prepare financial reports.',
                'job_location' => 'New York City',
                'job_type' => 'Full-time',
                'job_salary' => 75000,
                'responsibilities' => 'Maintain financial records and ensure compliance with accounting regulations.
                Prepare monthly, quarterly, and annual financial statements.
                Assist in budget preparation and expense management activities.
                Handle tax filings and liaise with external auditors.
                Analyze financial data to identify trends and financial performance.
                Provide recommendations to improve financial health and processes.',
                'job_qualification' => 'Bachelor’s Degree in Accounting or Finance',
                'experience_level' => '1-3 years',
                'education_level' => 'Bachelor’s Degree',
                'preferred_gender' => 'any',
                'deadline' => now()->addWeeks(3),
                'job_status' => 'Open',
                'industry_id' => 1,
                'specialization_id' => 21,
                'startup_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'job_title' => 'Junior Accountant',
                'job_description' => 'Assist in managing day-to-day accounting operations and financial reporting.',
                'job_location' => 'Chicago',
                'job_type' => 'Part-time',
                'job_salary' => 50000,
                'responsibilities' => 'Support accounts payable and accounts receivable functions.
                Assist in month-end and year-end closing processes.
                Reconcile bank statements and manage ledger entries.
                Provide assistance in financial audits and tax preparation.
                Collaborate with the accounting team to improve financial procedures.',
                'job_qualification' => 'Bachelor’s Degree in Accounting or related field',
                'experience_level' => '1-3 years',
                'education_level' => 'Bachelor’s Degree',
                'preferred_gender' => 'any',
                'deadline' => now()->addWeeks(4),
                'job_status' => 'Open',
                'industry_id' => 3,
                'specialization_id' => 22,
                'startup_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ], [
                'job_title' => 'Customer Service Representative',
                'job_description' => 'Provide outstanding customer service and support to clients.',
                'job_location' => 'Los Angeles',
                'job_type' => 'Full-time',
                'job_salary' => 45000,
                'responsibilities' => 'Respond to customer inquiries via phone, email, and live chat.
                Resolve customer complaints and provide solutions in a timely manner.
                Maintain a high level of customer satisfaction and service excellence.
                Collaborate with the team to improve customer service procedures.
                Keep records of customer interactions and transactions.',
                'job_qualification' => 'High school diploma; additional qualifications in customer service are a plus',
                'experience_level' => '1-3 years',
                'education_level' => 'High School',
                'preferred_gender' => 'any',
                'deadline' => now()->addMonths(1),
                'job_status' => 'Open',
                'industry_id' => 5,
                'specialization_id' => 55,
                'startup_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],


        ]);
    }
}
