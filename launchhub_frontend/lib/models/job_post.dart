class JobPost {
  JobPost({
    required this.id,
    required this.jobTitle,
    required this.jobDescription,
    required this.jobLocation,
    required this.jobType,
    required this.jobSalary,
    required this.jobQualification,
    required this.experienceLevel,
    required this.educationLevel,
    required this.responsibilities,
    required this.preferredGender,
    required this.deadline,
    required this.requiredSkills,
    required this.jobStatus,
    required this.industryId,
    required this.specializationId,
    required this.startupId,
  });
  final int id;
  final String jobTitle;
  final String jobDescription;
  final String jobLocation;
  final String jobType;
  final String jobSalary;
  final String jobQualification;
  final String responsibilities;
  final String experienceLevel;
  final String educationLevel;
  final String preferredGender;
  final String deadline;
  final String jobStatus;
  final List requiredSkills;
  final int industryId;
  final int specializationId;
  final int startupId;
  factory JobPost.fromJson(Map json) {
    return JobPost(
      id: json['id'] as int,
      jobTitle: json['job_title'] as String,
      jobDescription: json['job_description'] as String,
      jobLocation: json['job_location'] as String,
      jobType: json['job_type'] as String,
      jobSalary: json['job_salary'] as String,
      jobQualification: json['job_qualification'] as String,
      responsibilities: json['responsibilities'] as String,
      experienceLevel: json['experience_level'] as String,
      educationLevel: json['education_level'] as String,
      preferredGender: json['preferred_gender'] as String,
      requiredSkills: json['required_skills'] as List,
      deadline: json['deadline'] as String,
      jobStatus: json['job_status'] as String,
      industryId: json['industry_id'] as int,
      specializationId: json['specialization_id'] as int,
      startupId: json['startup_id'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'job_title': jobTitle,
      'job_description': jobDescription,
      'job_location': jobLocation,
      'job_type': jobType,
      'job_salary': jobSalary,
      'job_qualification': jobQualification,
      'experience_level': experienceLevel,
      'education_level': educationLevel,
      "responsibilities": responsibilities,
      'preferred_gender': preferredGender,
      'required_skills': requiredSkills,
      'deadline': deadline,
      'industry_id': industryId,
      'specialization_id': specializationId,
      'startup_id': startupId,
    };
  }

  static List<JobPost> parseMultipleJobPosts(List<dynamic> jsons) {
    List<JobPost> list = [];
    for (Map json in jsons) {
      list.add(JobPost.fromJson(json));
    }
    return list;
  }
}
