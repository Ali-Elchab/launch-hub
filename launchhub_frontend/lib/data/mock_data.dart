// import 'package:launchhub_frontend/data/static_data.dart';
// import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/social_media_link.dart';
import 'package:launchhub_frontend/models/startup.dart';

// // List<Industry> industries = [
// //   Industry(id: 1, name: 'Agriculture'),
// //   Industry(id: 2, name: 'Automotive'),
// //   Industry(id: 3, name: 'Banking'),
// //   Industry(id: 4, name: 'Construction'),
// //   Industry(id: 5, name: 'Education'),
// //   Industry(id: 6, name: 'Energy'),
// //   Industry(id: 7, name: 'Entertainment'),
// //   Industry(id: 8, name: 'Food'),
// //   Industry(id: 9, name: 'Healthcare'),
// //   Industry(id: 10, name: 'Hospitality'),
// //   Industry(id: 11, name: 'Insurance'),
// //   Industry(id: 12, name: 'Manufacturing'),
// //   Industry(id: 13, name: 'Media'),
// //   Industry(id: 14, name: 'Mining'),
// //   Industry(id: 15, name: 'Pharmaceutical'),
// //   Industry(id: 16, name: 'Real Estate'),
// //   Industry(id: 17, name: 'Retail'),
// //   Industry(id: 18, name: 'Telecommunications'),
// //   Industry(id: 19, name: 'Transportation'),
// //   Industry(id: 20, name: 'Utilities'),
// //   Industry(id: 21, name: 'Other'),
// // ];

// // List<Niche> niches = [
// //   Niche(id: 1, name: 'Organic Farming'),
// //   Niche(id: 2, name: 'Electric Vehicles'),
// //   Niche(id: 3, name: 'Investment Banking'),
// //   Niche(id: 4, name: 'Residential Construction'),
// //   Niche(id: 5, name: 'Online Education'),
// //   Niche(id: 6, name: 'Renewable Energy'),
// //   Niche(id: 7, name: 'Film Production'),
// //   Niche(id: 8, name: 'Gourmet Foods'),
// //   Niche(id: 9, name: 'Digital Healthcare'),
// //   Niche(id: 10, name: 'Boutique Hotels'),
// //   Niche(id: 11, name: 'Health Insurance'),
// //   Niche(id: 12, name: 'Consumer Electronics Manufacturing'),
// //   Niche(id: 13, name: 'Digital Media'),
// //   Niche(id: 14, name: 'Gold Mining'),
// //   Niche(id: 15, name: 'Biotechnology Pharmaceuticals'),
// //   Niche(id: 16, name: 'Commercial Real Estate'),
// //   Niche(id: 17, name: 'E-Commerce Retail'),
// //   Niche(id: 18, name: 'Wireless Communication'),
// //   Niche(id: 19, name: 'Logistics & Freight'),
// //   Niche(id: 20, name: 'Water & Waste Utilities'),
// //   Niche(id: 21, name: 'Virtual Reality Technology'),
// // ];

// // List<Skill> mockSkills = [
// //   Skill(id: 1, name: 'Software Development', specializationId: 101),
// //   Skill(id: 2, name: 'Project Management', specializationId: 102),
// //   Skill(id: 3, name: 'Data Analysis', specializationId: 103),
// //   Skill(id: 4, name: 'Graphic Design', specializationId: 104),
// //   Skill(id: 5, name: 'Digital Marketing', specializationId: 105),
// //   Skill(id: 6, name: 'Cybersecurity', specializationId: 106),
// //   Skill(id: 7, name: 'Machine Learning', specializationId: 107),
// //   Skill(id: 8, name: 'Cloud Computing', specializationId: 108),
// //   Skill(id: 9, name: 'UX/UI Design', specializationId: 109),
// //   Skill(id: 10, name: 'DevOps Engineering', specializationId: 110),
// // ];

// // List<Hobby> mockHobbies = [
// //   Hobby(id: 1, name: 'Reading'),
// //   Hobby(id: 2, name: 'Creative writing'),
// //   Hobby(id: 3, name: 'Painting'),
// //   Hobby(id: 4, name: 'Graphic Design'),
// //   Hobby(id: 5, name: 'Musical Instrument'),
// //   Hobby(id: 6, name: 'Photography'),
// //   Hobby(id: 7, name: ' Gardening'),
// //   Hobby(id: 8, name: 'Cooking'),
// //   Hobby(id: 9, name: 'Knitting'),
// //   Hobby(id: 10, name: 'Hiking'),
// //   Hobby(id: 11, name: 'Fishing'),
// //   Hobby(id: 12, name: 'Rock Climbing'),
// //   Hobby(id: 13, name: 'Cycling'),
// //   Hobby(id: 14, name: 'Dancing'),
// //   Hobby(id: 15, name: 'Pottery'),
// //   Hobby(id: 16, name: 'Woodworking'),
// //   Hobby(id: 17, name: 'Video Gaming'),
// //   Hobby(id: 18, name: 'Astronomy'),
// //   Hobby(id: 19, name: 'Traveling'),
// // ];

// List<JobPost> dummyJobPosts = [
//   JobPost(
//     id: 1,
//     jobTitle: "Software Engineer",
//     jobDescription:
//         "Join as an IT Technician to deliver top-tier technical support, troubleshoot hardware and software challenges, and enhance the overall efficiency of our dynamic IT environment.",
//     jobLocation: "San Francisco, CA",
//     jobType: jobTypes[1],
//     jobSalary: 80000,
//     jobQualification: "Bachelor's degree in Computer Science",
//     responsibilities:
//         "Collaborate with department heads to identify staffing needs and devise effective recruitment strategies.Conduct the entire recruitment process, from sourcing and screening to interviewing and onboarding.Foster a positive and inclusive workplace culture through effective employee relations.Implement and maintain HR policies and procedures in alignment with industry best practices.Plan and conduct training sessions on various HR-related topics.Maintain accurate records and documentation related to employee activities.",
//     experienceLevel: "2-4 years",
//     educationLevel: "Bachelor's degree",
//     preferredGender: genders[2],
//     deadline: "2024-12-31",
//     jobStatus: 'open',
//     requiredSkills: [1, 2, 3],
//     industryId: 1,
//     specializationId: 101,
//     startupId: 1,
//   ),
//   JobPost(
//     id: 1,
//     jobTitle: "Graphic Designer",
//     jobDescription: "Create visually appealing graphics and designs.",
//     jobLocation: "New York, NY",
//     jobType: jobTypes[0],
//     jobSalary: 50000,
//     jobQualification: "Bachelor's degree in Graphic Design",
//     responsibilities:
//         "Collaborate with department heads to identify staffing needs and devise effective recruitment strategies.Conduct the entire recruitment process, from sourcing and screening to interviewing and onboarding.Foster a positive and inclusive workplace culture through effective employee relations.Implement and maintain HR policies and procedures in alignment with industry best practices.Plan and conduct training sessions on various HR-related topics.Maintain accurate records and documentation related to employee activities.",
//     experienceLevel: "1-3 years",
//     educationLevel: "Bachelor's degree",
//     preferredGender: genders[0],
//     deadline: "2024-12-31",
//     jobStatus: 'open',
//     industryId: 2,
//     specializationId: 102,
//     startupId: 1,
//     requiredSkills: [5, 8, 9],
//   ),
//   // Add more dummy job posts as needed
// ];

// // List<JobSeeker> dummyJobSeekers = [
// //   JobSeeker(
// //     id: 1,
// //     firstName: 'Ahmad',
// //     lastName: 'Ahmad',
// //     profilePic: 'path/to/profile1.jpg',
// //     dob: '1990, 1, 1',
// //     phone: '123-456-7890',
// //     address: '123 Main St',
// //     bio:
// //         'HR Specialist: Proven expertise in talent management, employee relations, and a commitment to creating a positive workplace environment for organizational success.',
// //     resume: 'path/to/resume1.pdf',
// //     isAvailable: 1,
// //     industryId: 2,
// //     userId: 1,
// //     specializationId: 24,
// //   )
// //   socialMediaLinks: [
// //     {
// //       "platform": 'LinkedIn',
// //       "link": 'https://www.linkedin.com/in/johndoe/',
// //     },
// //     {
// //       'platform': 'facebook',
// //       'link': 'https://www.facebook.com/aliElchab',
// //     }
// //     // ... add more if needed ...
// //   ],
// //   educations: [
// //     Education(
// //       degree: 'BSc Computer Science',
// //       organization: 'University of Example',
// //       startDate: '2010-09-01',
// //       endDate: '2014-06-30',
// //       description: 'Studied computer science.',
// //       location: 'Anytown',
// //     ),
// //     // ... add more if needed ...
// //   ],
// //   experiences: [
// //     Experience(
// //       position: 'Software Developer',
// //       company: 'Tech Corp',
// //       industryId: 2,
// //       specializationId: 25,
// //       type: 'Full-Time',
// //       startDate: '2014-07-01',
// //       endDate: '2019-08-30',
// //       description: 'Developed software.',
// //       location: 'Anytown',
// //       jobSeekerId: 1,
// //     ),
// //     // ... add more if needed ...
// //   ],
// //   certifications: [
// //     Certification(
// //       name: 'Certified Java Programmer',
// //       certificate: 'CJP12345',
// //       organization: 'Java Institute',
// //       startDate: '2015-05-01',
// //       endDate: '2025-05-01',
// //       description: 'Java programming certification.',
// //       location: 'Online',
// //       jobSeekerId: 1,
// //     ),
// //     // ... add more if needed ...
// //   ],
// //   hobbies: [
// //     Hobby(id: 1, name: 'Cycling'),
// //     Hobby(id: 2, name: 'Reading'),
// //     // ... add more if needed ...
// //   ],
// //   skills: [
// //     Skill(id: 1, name: 'Java', specializationId: 1),
// //     Skill(id: 2, name: 'Python', specializationId: 2),
// //     // ... add more if needed ...
// //   ],
// //   jobPosts: [dummyJobPosts[0], dummyJobPosts[1]],
// // ),
// // ];

// // List<Advisor> dummyAdvisors = [
// //   Advisor(
// //     id: 1,
// //     name: 'John Doe',
// //     email: 'john.doe@financecorp.com',
// //     location: 'New York, NY',
// //     phone: '555-0100',
// //     bio:
// //         'Experienced financial advisor with a decade of successful client engagements.',
// //     profilePic: 'assets/images/john_doe.png',
// //     category: 'finance',
// //     expertise: 'Investment Banking',
// //   ),
// //   Advisor(
// //     id: 2,
// //     name: 'Jane Smith',
// //     email: 'jane.smith@marketgurus.com',
// //     location: 'San Francisco, CA',
// //     phone: '555-0200',
// //     bio:
// //         'Marketing expert specializing in digital campaigns and social media strategy.',
// //     profilePic: 'assets/images/jane_smith.png',
// //     category: 'marketing',
// //     expertise: 'Digital Marketing',
// //   ),
// //   Advisor(
// //     id: 3,
// //     name: 'Alice Johnson',
// //     email: 'alice.johnson@legalfirm.com',
// //     location: 'Chicago, IL',
// //     phone: '555-0300',
// //     bio:
// //         'Dedicated legal advisor with a focus on corporate law and compliance.',
// //     profilePic: 'assets/images/alice_johnson.png',
// //     category: 'legal',
// //     expertise: 'Corporate Law',
// //   ),
// // ];

List<Startup> dummyStartups = [
  Startup(
    id: 2,
    companyName: 'Innovatech Solutions',
    companyEmail: 'contact@innovatech.io',
    companyPhone: '123-456-7890',
    copmanyLogo: 'assets/images/innovatech_logo.png',
    companyDescription: 'Pioneering smart IoT solutions for modern businesses.',
    companyWebsiteUrl: 'https://www.innovatech.io',
    registrationNumber: 'REG1234567',
    foundingDate: '2022',
    companyAddress: '123 Tech Drive',
    userId: 2,
    industryId: 2,
    specializationId: 1,
    socialMediaLinks: [
      SocialMediaLink(
        id: 1,
        platform: 'LinkedIn',
        link: 'https://www.linkedin.com/in/johndoe/',
        userId: 1,
      ),
      SocialMediaLink(
        id: 2,
        platform: 'facebook',
        link: 'https://www.facebook.com/aliElchab',
        userId: 1,
      ),
      // ... add more if needed ...
    ],
    founders: ['Alex Johnson', 'Jamie Smith'],
    ceos: ['Alex Johnson'],
    keyExcecutives: ['Jamie Smith - CTO', 'Sam Patel - COO'],
  ),
  Startup(
    id: 1,
    companyName: 'EcoSynth Labs',
    companyEmail: 'info@ecosynthlabs.com',
    companyPhone: '987-654-3210',
    copmanyLogo: 'assets/images/ecosynth_logo.png',
    companyDescription: 'Developing sustainable biotech for a greener future.',
    companyWebsiteUrl: 'https://www.ecosynthlabs.com',
    registrationNumber: 'REG7654321',
    foundingDate: '2',
    companyAddress: '456 Green Lane',
    userId: 4,
    industryId: 2,
    specializationId: 22,
    socialMediaLinks: [
      // ... add more if needed ...
    ],
    founders: ['Morgan Taylor', 'Casey Lee'],
    ceos: ['Morgan Taylor'],
    keyExcecutives: ['Casey Lee - CSO', 'Jordan Chung - CFO'],
  ),
];
