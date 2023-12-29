<?php

namespace Database\Seeders;

use App\Models\Advisor;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class AdvisorsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $advisors =
            [
                [
                    'name' => 'Mahmoud Alamen',
                    'email' => 'JohnDoe@gmail.com',
                    'location' => 'Batroun',
                    'phone' => '05211465',
                    'bio' => 'Results-driven Investment Advisor skilled in portfolio optimization and strategic financial guidance, adept at maximizing returns through insightful market analysis.',
                    'photo_url' => 'finance-advisor(1).png',
                    'category' => 'finance',
                    'expertise' => 'Investment Advisor',
                ],
                [
                    'name' => 'Mariam Barook',
                    'email' => 'mariam.barook@example.com',
                    'location' => 'Beirut',
                    'phone' => '03215478',
                    'bio' => 'Experienced Risk Management Expert with a proven track record in identifying and mitigating risks. Skilled in strategic decision-making for effective risk navigation.',
                    'photo_url' => 'finance-advisor(2).png',
                    'category' => 'finance',
                    'expertise' => 'Risk Management Expert',
                ],
                [
                    'name' => 'Assi Zidan',
                    'email' => 'assi.zidan@example.com',
                    'location' => 'Beirut',
                    'phone' => '04215555',
                    'bio' => 'Strategic Technology Financial Advisor known for seamlessly aligning financial strategies with technological advancements, ensuring optimal business outcomes.',
                    'photo_url' => 'finance-advisor(3).png',
                    'category' => 'finance',
                    'expertise' => 'Technology Financial Advisor',
                ],
                [
                    'name' => 'Amir Haddad',
                    'email' => 'amir.haddad@example.com',
                    'location' => 'Beirut',
                    'phone' => '71542222',
                    'bio' => 'Crafting compelling narratives is my expertise. As a seasoned Copywriter, I bring ideas to life with words, driving engagement and resonance for your brand.',
                    'photo_url' => 'marketing-advisor(1).png',
                    'category' => 'marketing',
                    'expertise' => 'Copywriter',
                ],
                [
                    'name' => 'Maroun Asmar',
                    'email' => 'maroun.asmar@example.com',
                    'location' => 'Beirut',
                    'phone' => '71555555',
                    'bio' => 'As a UI/UX Designer, I blend creativity with functionality, shaping seamless and visually captivating digital experiences. Let me transform your ideas into user-friendly masterpieces.',
                    'photo_url' => 'marketing-advisor(2).png',
                    'category' => 'marketing',
                    'expertise' => 'UI/UX Designer',
                ],
                [
                    'name' => 'Francis Hanna',
                    'email' => 'francis.hanna@example.com',
                    'location' => 'Beirut',
                    'phone' => '03211415',
                    'bio' => 'I breathe life into visuals through animation. As an Animator, I merge creativity and motion to tell engaging stories and captivate audiences.',
                    'photo_url' => 'marketing-advisor(3).png',
                    'category' => 'marketing',
                    'expertise' => 'Animator',
                ],
                [
                    'name' => 'Ibrahim Younis',
                    'email' => 'ibrahim.younis@example.com',
                    'location' => 'Beirut',
                    'phone' => '71542222',
                    'bio' => 'Intellectual Property Attorney specializing in protecting and managing intellectual assets through expert legal counsel on trademarks, patents, and copyrights.',
                    'photo_url' => 'legal-advisor(1).png',
                    'category' => 'legal',
                    'expertise' => 'Intellectual Property Attorney',
                ],
                [
                    'name' => 'Mohamad Farhat',
                    'email' => 'mohamad.farhat@example.com',
                    'location' => 'Beirut',
                    'phone' => '71555555',
                    'bio' => 'Experienced Employment Lawyer specializing in labor laws, providing strategic solutions for legal compliance and a positive work environment.',
                    'photo_url' => 'legal-advisor(2).png',
                    'category' => 'legal',
                    'expertise' => 'Employment Lawyer',
                ],
                [
                    'name' => 'Jad Saliba',
                    'email' => 'jad.saliba@example.com',
                    'location' => 'Beirut',
                    'phone' => '03211415',
                    'bio' => 'Proven expertise in navigating complex tax regulations and providing strategic counsel to businesses. Specialized in tax planning, compliance, and dispute resolution.',
                    'photo_url' => 'legal-advisor(3).png',
                    'category' => 'legal',
                    'expertise' => 'Tax Attorney',
                ],
            ];

        foreach ($advisors as $advisor) {
            Advisor::create($advisor);
        }
    }
}
