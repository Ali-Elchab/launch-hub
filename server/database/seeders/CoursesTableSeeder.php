<?php

namespace Database\Seeders;

use App\Models\JobSeekerEnhaceSkillsCourse;
use App\Models\Specialization;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CoursesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $courseSeedData = [
            "Software Development" => [
                [
                    'course_name' => 'Advanced Software Engineering',
                    'link' => 'https://example.com/software-course-1',
                    'image_url' => 'https://example.com/images/software-course-1.jpg',
                    'description' => 'A comprehensive course on modern software development practices and principles.'
                ],
                [
                    'course_name' => 'Full Stack Development Essentials',
                    'link' => 'https://example.com/software-course-2',
                    'image_url' => 'https://example.com/images/software-course-2.jpg',
                    'description' => 'Explore full stack development with hands-on experience in front-end and back-end technologies.'
                ]
            ],
            "Data Science" => [
                [
                    'course_name' => 'Data Science and Analytics',
                    'link' => 'https://example.com/datascience-course-1',
                    'image_url' => 'https://example.com/images/datascience-course-1.jpg',
                    'description' => 'Comprehensive overview of data science concepts, including statistics and data analysis.'
                ],
                [
                    'course_name' => 'Machine Learning for Data Science',
                    'link' => 'https://example.com/datascience-course-2',
                    'image_url' => 'https://example.com/images/datascience-course-2.jpg',
                    'description' => 'Explore machine learning techniques and their applications in data science.'
                ]
            ],
            "Cyber Security" => [
                [
                    'course_name' => 'Cyber Security Fundamentals',
                    'link' => 'https://example.com/cybersecurity-course-1',
                    'image_url' => 'https://example.com/images/cybersecurity-course-1.jpg',
                    'description' => 'Learn the fundamentals of cyber security and its applications in the real world.'
                ],
                [
                    'course_name' => 'Cyber Security for Business',
                    'link' => 'https://example.com/cybersecurity-course-2',
                    'image_url' => 'https://example.com/images/cybersecurity-course-2.jpg',
                    'description' => 'Learn how to protect your business from cyber attacks and data breaches.'
                ]
            ],

            "Cloud Computing" => [
                [
                    'course_name' => 'Cloud Infrastructure and Services',
                    'link' => 'https://example.com/cloudcomputing-course',
                    'image_url' => 'https://example.com/images/cloudcomputing-course.jpg',
                    'description' => 'Explore the fundamentals of cloud services, including architecture, deployment models, and key services.'
                ]
            ],
            "Network Engineering" => [
                [
                    'course_name' => 'Advanced Network Engineering Principles',
                    'link' => 'https://example.com/networkengineering-course',
                    'image_url' => 'https://example.com/images/networkengineering-course.jpg',
                    'description' => 'Dive into the core concepts of network design, implementation, and management.'
                ]
            ],
            "UI/UX Design" => [
                [
                    'course_name' => 'UI/UX Design Mastery',
                    'link' => 'https://example.com/uiuxdesign-course',
                    'image_url' => 'https://example.com/images/uiuxdesign-course.jpg',
                    'description' => 'Learn the art and science of creating engaging and user-friendly digital interfaces.'
                ]
            ],
            "Mobile App Development" => [
                [
                    'course_name' => 'Mobile App Development from Scratch',
                    'link' => 'https://example.com/mobileappdev-course',
                    'image_url' => 'https://example.com/images/mobileappdev-course.jpg',
                    'description' => 'Comprehensive guide to building mobile applications for iOS and Android platforms.'
                ]
            ],
            "Game Development" => [
                [
                    'course_name' => 'Game Development Essentials',
                    'link' => 'https://example.com/gamedev-course',
                    'image_url' => 'https://example.com/images/gamedev-course.jpg',
                    'description' => 'An introduction to game development, covering game design, programming, and graphics.'
                ]
            ],
            "IT Project Management" => [
                [
                    'course_name' => 'IT Project Management Certification',
                    'link' => 'https://example.com/itprojmgmt-course',
                    'image_url' => 'https://example.com/images/itprojmgmt-course.jpg',
                    'description' => 'Master the skills necessary to successfully manage IT projects, including planning, execution, and monitoring.'
                ]
            ],
            "Investment Banking" => [
                [
                    'course_name' => 'Essentials of Investment Banking',
                    'link' => 'https://example.com/investmentbanking-course',
                    'image_url' => 'https://example.com/images/investmentbanking-course.jpg',
                    'description' => 'Learn the fundamentals of investment banking, including financial markets, M&A, and capital raising.'
                ]
            ],
            "Accounting" => [
                [
                    'course_name' => 'Advanced Accounting Techniques',
                    'link' => 'https://example.com/accounting-course',
                    'image_url' => 'https://example.com/images/accounting-course.jpg',
                    'description' => 'A comprehensive overview of modern accounting practices, including financial reporting and auditing.'
                ]
            ],
            "Financial Planning" => [
                [
                    'course_name' => 'Certified Financial Planning Masterclass',
                    'link' => 'https://example.com/financialplanning-course',
                    'image_url' => 'https://example.com/images/financialplanning-course.jpg',
                    'description' => 'Gain expertise in financial planning, including risk management, retirement planning, and investment strategies.'
                ]
            ],
            "Insurance" => [
                [
                    'course_name' => 'Insurance and Risk Management',
                    'link' => 'https://example.com/insurance-course',
                    'image_url' => 'https://example.com/images/insurance-course.jpg',
                    'description' => 'Explore the principles of insurance, underwriting, and risk management in this comprehensive course.'
                ]
            ],
            "Nursing" => [
                [
                    'course_name' => 'Advanced Nursing Practices',
                    'link' => 'https://example.com/nursing-course',
                    'image_url' => 'https://example.com/images/nursing-course.jpg',
                    'description' => 'Explore in-depth nursing concepts, patient care techniques, and healthcare management.'
                ]
            ],
            "General Medicine" => [
                [
                    'course_name' => 'Modern General Medicine Fundamentals',
                    'link' => 'https://example.com/generalmedicine-course',
                    'image_url' => 'https://example.com/images/generalmedicine-course.jpg',
                    'description' => 'Comprehensive insights into general medical practices, diagnostics, and patient management.'
                ]
            ],
            "Dentistry" => [
                [
                    'course_name' => 'Comprehensive Dentistry Techniques',
                    'link' => 'https://example.com/dentistry-course',
                    'image_url' => 'https://example.com/images/dentistry-course.jpg',
                    'description' => 'Delve into advanced dentistry, including oral health, cosmetic procedures, and dental surgery.'
                ]
            ],
            "Quality Control" => [
                [
                    'course_name' => 'Quality Control and Assurance Strategies',
                    'link' => 'https://example.com/qualitycontrol-course',
                    'image_url' => 'https://example.com/images/qualitycontrol-course.jpg',
                    'description' => 'Master quality control processes and methodologies in manufacturing and service industries.'
                ]
            ],
            "Supply Chain Management" => [
                [
                    'course_name' => 'Effective Supply Chain Optimization',
                    'link' => 'https://example.com/supplychain-course',
                    'image_url' => 'https://example.com/images/supplychain-course.jpg',
                    'description' => 'Learn about the latest trends and strategies in supply chain management and logistics.'
                ]
            ],
            "Industrial Engineering" => [
                [
                    'course_name' => 'Advanced Industrial Engineering Concepts',
                    'link' => 'https://example.com/industrialeng-course',
                    'image_url' => 'https://example.com/images/industrialeng-course.jpg',
                    'description' => 'Deep dive into industrial engineering principles, process optimization, and system design.'
                ]
            ],
            "Store Management" => [
                [
                    'course_name' => 'Retail Store Management and Operations',
                    'link' => 'https://example.com/storemanagement-course',
                    'image_url' => 'https://example.com/images/storemanagement-course.jpg',
                    'description' => 'Comprehensive guide to managing retail stores, focusing on operations, staff management, and sales strategies.'
                ]
            ],
            "Merchandising" => [
                [
                    'course_name' => 'Effective Merchandising Techniques',
                    'link' => 'https://example.com/merchandising-course',
                    'image_url' => 'https://example.com/images/merchandising-course.jpg',
                    'description' => 'Explore the art and science of merchandising in the retail industry, including product placement and branding.'
                ]
            ],
            "Retail Buying" => [
                [
                    'course_name' => 'Retail Buying and Procurement Strategies',
                    'link' => 'https://example.com/retailbuying-course',
                    'image_url' => 'https://example.com/images/retailbuying-course.jpg',
                    'description' => 'Learn about retail buying, procurement processes, and effective negotiation strategies for retail purchasing.'
                ]
            ], "Project Management" => [
                [
                    'course_name' => 'Advanced Project Management Techniques',
                    'link' => 'https://example.com/projectmanagement-course',
                    'image_url' => 'https://example.com/images/projectmanagement-course.jpg',
                    'description' => 'Deep dive into project management methodologies, tools, and best practices.'
                ]
            ],
            "Civil Engineering" => [
                [
                    'course_name' => 'Modern Civil Engineering and Infrastructure',
                    'link' => 'https://example.com/civilengineering-course',
                    'image_url' => 'https://example.com/images/civilengineering-course.jpg',
                    'description' => 'Explore the latest trends and technologies in civil engineering, including sustainable infrastructure design.'
                ]
            ],
            "Architecture" => [
                [
                    'course_name' => 'Architectural Design and Innovation',
                    'link' => 'https://example.com/architecture-course',
                    'image_url' => 'https://example.com/images/architecture-course.jpg',
                    'description' => 'Comprehensive insights into contemporary architecture, including design principles and emerging trends.'
                ]
            ],
            "Renewable Energy" => [
                [
                    'course_name' => 'Renewable Energy Systems and Sustainability',
                    'link' => 'https://example.com/renewableenergy-course',
                    'image_url' => 'https://example.com/images/renewableenergy-course.jpg',
                    'description' => 'Learn about renewable energy sources, their implementation, and impact on sustainability.'
                ]
            ],
            "Petroleum Engineering" => [
                [
                    'course_name' => 'Advanced Petroleum Engineering Concepts',
                    'link' => 'https://example.com/petroleumengineering-course',
                    'image_url' => 'https://example.com/images/petroleumengineering-course.jpg',
                    'description' => 'Explore the principles of petroleum engineering, including drilling, reservoir management, and production strategies.'
                ]
            ],
            "Energy Efficiency Consulting" => [
                [
                    'course_name' => 'Energy Efficiency and Sustainability Consulting',
                    'link' => 'https://example.com/energyefficiency-course',
                    'image_url' => 'https://example.com/images/energyefficiency-course.jpg',
                    'description' => 'Master the skills in energy auditing, efficiency strategies, and sustainable consulting practices.'
                ]
            ],
            "Network Architecture" => [
                [
                    'course_name' => 'Network Architecture and Systems Design',
                    'link' => 'https://example.com/networkarchitecture-course',
                    'image_url' => 'https://example.com/images/networkarchitecture-course.jpg',
                    'description' => 'In-depth coverage of network architecture principles, design methodologies, and future trends.'
                ]
            ],
            "Telecom Engineering" => [
                [
                    'course_name' => 'Telecommunications Engineering Essentials',
                    'link' => 'https://example.com/telecomengineering-course',
                    'image_url' => 'https://example.com/images/telecomengineering-course.jpg',
                    'description' => 'Learn about the foundations of telecommunications engineering, including network design and signal processing.'
                ]
            ],
            "Wireless Communication" => [
                [
                    'course_name' => 'Wireless Communication Technologies',
                    'link' => 'https://example.com/wirelesscommunication-course',
                    'image_url' => 'https://example.com/images/wirelesscommunication-course.jpg',
                    'description' => 'Explore the technologies and methodologies used in modern wireless communication systems.'
                ]
            ],
            "Clinical Research" => [
                [
                    'course_name' => 'Clinical Research and Trial Management',
                    'link' => 'https://example.com/clinicalresearch-course',
                    'image_url' => 'https://example.com/images/clinicalresearch-course.jpg',
                    'description' => 'Gain insights into the design, execution, and management of clinical research trials.'
                ]
            ],
            "Pharmaceutical Sales" => [
                [
                    'course_name' => 'Pharmaceutical Sales Strategies',
                    'link' => 'https://example.com/pharmaceuticalsales-course',
                    'image_url' => 'https://example.com/images/pharmaceuticalsales-course.jpg',
                    'description' => 'Master the art and science of pharmaceutical sales, including market analysis and customer engagement.'
                ]
            ],
            "Medicinal Chemistry" => [
                [
                    'course_name' => 'Advancements in Medicinal Chemistry',
                    'link' => 'https://example.com/medicinalchemistry-course',
                    'image_url' => 'https://example.com/images/medicinalchemistry-course.jpg',
                    'description' => 'Explore the latest developments in medicinal chemistry, drug discovery, and pharmaceutical analysis.'
                ]
            ]




        ];

        foreach ($courseSeedData as $specializationName => $courses) {
            $specialization = Specialization::where('name', $specializationName)->first();

            if ($specialization) {
                foreach ($courses as $course) {
                    JobSeekerEnhaceSkillsCourse::create([
                        'course_name' => $course['course_name'],
                        'link' => $course['link'],
                        'image_url' => $course['image_url'],
                        'description' => $course['description'],
                        'specialization_id' => $specialization->id
                    ]);
                }
            }
        }
    }
}
