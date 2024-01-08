// ignore: file_names
import 'package:launchhub_frontend/models/jobPost.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/models/industry.dart';

List<Industry> industries = [
  Industry(id: 1, name: 'Agriculture'),
  Industry(id: 2, name: 'Automotive'),
  Industry(id: 3, name: 'Banking'),
  Industry(id: 4, name: 'Construction'),
  Industry(id: 5, name: 'Education'),
  Industry(id: 6, name: 'Energy'),
  Industry(id: 7, name: 'Entertainment'),
  Industry(id: 8, name: 'Food'),
  Industry(id: 9, name: 'Healthcare'),
  Industry(id: 10, name: 'Hospitality'),
  Industry(id: 11, name: 'Insurance'),
  Industry(id: 12, name: 'Manufacturing'),
  Industry(id: 13, name: 'Media'),
  Industry(id: 14, name: 'Mining'),
  Industry(id: 15, name: 'Pharmaceutical'),
  Industry(id: 16, name: 'Real Estate'),
  Industry(id: 17, name: 'Retail'),
  Industry(id: 18, name: 'Telecommunications'),
  Industry(id: 19, name: 'Transportation'),
  Industry(id: 20, name: 'Utilities'),
  Industry(id: 21, name: 'Other'),
];

List<Niche> niches = [
  Niche(id: 1, name: 'Organic Farming'),
  Niche(id: 2, name: 'Electric Vehicles'),
  Niche(id: 3, name: 'Investment Banking'),
  Niche(id: 4, name: 'Residential Construction'),
  Niche(id: 5, name: 'Online Education'),
  Niche(id: 6, name: 'Renewable Energy'),
  Niche(id: 7, name: 'Film Production'),
  Niche(id: 8, name: 'Gourmet Foods'),
  Niche(id: 9, name: 'Digital Healthcare'),
  Niche(id: 10, name: 'Boutique Hotels'),
  Niche(id: 11, name: 'Health Insurance'),
  Niche(id: 12, name: 'Consumer Electronics Manufacturing'),
  Niche(id: 13, name: 'Digital Media'),
  Niche(id: 14, name: 'Gold Mining'),
  Niche(id: 15, name: 'Biotechnology Pharmaceuticals'),
  Niche(id: 16, name: 'Commercial Real Estate'),
  Niche(id: 17, name: 'E-Commerce Retail'),
  Niche(id: 18, name: 'Wireless Communication'),
  Niche(id: 19, name: 'Logistics & Freight'),
  Niche(id: 20, name: 'Water & Waste Utilities'),
  Niche(id: 21, name: 'Virtual Reality Technology'),
];

final List<String> skills = [
  'Critical Thinking',
  'Data Analysis',
  'Time management',
  'Teamwork',
  'Networking',
  'Machine Learning',
  'Programming Languages',
  'Resilience',
  'Risk Management',
  'Mentoring',
  'Delegation',
  'Design Thinking',
  'Accounting',
  'Recruitment',
  'Network Security',
  // ... add other skills here ...
];

List<String> hobbies = [
  'Reading',
  'Writing (Creative writing, poetry, blogging)',
  'Painting or Drawing',
  'Playing a Musical Instrument (Guitar, Piano, Violin, etc.)',
  'Photography',
  'Gardening',
  'Cooking or Baking',
  'Knitting or Sewing',
  'Doing Puzzles (Jigsaw, Crossword, Sudoku)',
  'Playing Board Games or Card Games',
  'Hiking or Camping',
  'Bird Watching',
  'Fishing',
  'Rock Climbing',
  'Cycling',
  'Yoga or Pilates',
  'Dancing (Ballroom, Salsa, Contemporary, etc.)',
  'Martial Arts',
  'Pottery or Ceramic Art',
  'Jewelry Making',
  'Woodworking',
  'Model Building (Cars, Airplanes, Ships)',
  'Astronomy',
  'Learning a New Language',
  'Video Gaming',
  'Collecting (Coins, Stamps, Antiques)',
  'Traveling',
  'Volunteering',
  'Meditation',
  'Watching Movies or Theater Performances',
];

List<JobPost> dummyJobPosts = [
  JobPost(
    id: 1,
    jobTitle: "Software Engineer",
    jobDescription:
        "Join as an IT Technician to deliver top-tier technical support, troubleshoot hardware and software challenges, and enhance the overall efficiency of our dynamic IT environment.",
    jobLocation: "San Francisco, CA",
    jobType: jobTypes[1],
    jobSalary: 80000,
    jobQualification: "Bachelor's degree in Computer Science",
    experienceLevel: "2-4 years",
    educationLevel: "Bachelor's degree",
    preferredGender: genders[2],
    deadline: "2024-12-31",
    jobStatus: 'open',
    industryId: 1,
    specializationId: 101,
    startupId: 1,
  ),
  JobPost(
    id: 1,
    jobTitle: "Graphic Designer",
    jobDescription: "Create visually appealing graphics and designs.",
    jobLocation: "New York, NY",
    jobType: jobTypes[0],
    jobSalary: 50000,
    jobQualification: "Bachelor's degree in Graphic Design",
    experienceLevel: "1-3 years",
    educationLevel: "Bachelor's degree",
    preferredGender: genders[0],
    deadline: "2024-12-31",
    jobStatus: 'open',
    industryId: 2,
    specializationId: 102,
    startupId: 1,
  ),
  // Add more dummy job posts as needed
];

final List<String> experienceLevels = [
  '0-1 years',
  '1-3 years',
  '3-5 years',
  '5-10 years',
  '10+ years',
];

final List<String> educationLevels = [
  'High School',
  'Associate Degree',
  'Bachelor\'s Degree',
  'Master\'s Degree',
  'Doctoral Degree',
];

final List<String> jobTypes = [
  'Full-time',
  'Part-time',
  'Contract',
  'Internship',
  'Temporary',
];

final List<String> genders = ['Male', 'Female', 'Any'];

List<String> locations = [
  'Beirut',
  'Tripoli',
  'Sidon',
  'Tyre',
  'Byblos',
  'Baalbek',
  'Jounieh',
  'Zahle',
  'Nabatieh',
  'Anjar',
  'Bcharre',
  'Batroun',
  'Aley',
  'Jeita',
  'Saida',
  'Zgharta',
  'Ehden',
  'Kfardebian',
  'Bekaa Valley',
  'Chouf District',
  'Jezzine',
  'Bentael',
  'Akkar District',
  'Rashaya',
  'Tannourine',
  'Marjayoun',
  'Miziara',
  'Bhamdoun',
  'Deir el Qamar',
  'Jiya',
  'Zahlé District',
  'Broumana',
  'Baskinta',
  'Anfeh',
  'Bikfaya',
  'Dhour El Choueir',
  'Douma',
  'Jal el Dib',
  'Jdeideh',
  'Kousba',
  'Mina, Tripoli',
  'Mtein',
  'Ras Baalbek',
  'Rachaya',
  'Zahle District',
];

// You can use this list of Lebanon locations for your location input field.
