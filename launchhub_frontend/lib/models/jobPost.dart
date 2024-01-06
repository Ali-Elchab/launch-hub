// "id": 1,
// "job_title": "Software Developer",
// "job_description": "Develop and maintain software applications.",
// "job_location": "Remote",
// "job_type": "Full-time",
// "job_salary": 80000,
// "job_qualification": "Bachelor’s Degree in Computer Science",
// "experience_level": "Mid-level",
// "education_level": "Bachelors",
// "preferred_gender": "any",
// "deadline": "2024-01-19",
// "job_status": "open",
// "created_at": "2024-01-05T09:21:19.000000Z",
// "updated_at": "2024-01-05T09:21:19.000000Z",
// "industry_id": 1,
// "specialization_id": 1,
// "startup_id": 1
enum JobStatus { open, closed }

enum PreferredGender { male, female, any }

enum JobType { fullTime, partTime, contract, internship, temporary }

class JobPost {
  const JobPost({
    required this.id,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobLocation,
    required this.jobType,
    required this.jobSalary,
    required this.jobQualification,
    required this.experienceLevel,
    required this.educationLevel,
    required this.preferredGender,
    required this.deadline,
    required this.jobStatus,
    required this.industryId,
    required this.specializationId,
    required this.startupId,
  });

  final int id;
  final String jobTitle;
  final String jobDescription;
  final String jobLocation;
  final JobType jobType;
  final int jobSalary;
  final String jobQualification;
  final String experienceLevel;
  final String educationLevel;
  final PreferredGender preferredGender;
  final String deadline;
  final JobStatus jobStatus;
  final int industryId;
  final int specializationId;
  final int startupId;
}
