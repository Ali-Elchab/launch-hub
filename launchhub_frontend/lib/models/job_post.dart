import 'package:launchhub_frontend/models/skill.dart';

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
  final int jobSalary;
  final String jobQualification;
  final String experienceLevel;
  final String educationLevel;
  final String preferredGender;
  final String deadline;
  final String jobStatus;
  final List<Skill> requiredSkills;
  final int industryId;
  final int specializationId;
  final int startupId;
  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      id: json['id'] as int,
      jobTitle: json['job_title'] as String,
      jobDescription: json['job_description'] as String,
      jobLocation: json['job_location'] as String,
      jobType: json['job_type'] as String,
      jobSalary: json['job_salary'] as int,
      jobQualification: json['job_qualification'] as String,
      experienceLevel: json['experience_level'] as String,
      educationLevel: json['education_level'] as String,
      preferredGender: json['preferred_gender'] as String,
      requiredSkills: json['required_skills'] as List<Skill>,
      deadline: json['deadline'] as String,
      jobStatus: json['job_status'] as String,
      industryId: json['industry_id'] as int,
      specializationId: json['specialization_id'] as int,
      startupId: json['startup_id'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_title': jobTitle,
      'job_description': jobDescription,
      'job_location': jobLocation,
      'job_type': jobType,
      'job_salary': jobSalary,
      'job_qualification': jobQualification,
      'experience_level': experienceLevel,
      'education_level': educationLevel,
      'preferred_gender': preferredGender,
      'required_skills': requiredSkills,
      'deadline': deadline,
      'job_status': jobStatus,
      'industry_id': industryId,
      'specialization_id': specializationId,
      'startup_id': startupId,
    };
  }
}

class JobPostPivot {
  final int jobSeekerId;
  final int jobPostId;
  final String status;

  JobPostPivot({
    required this.jobSeekerId,
    required this.jobPostId,
    required this.status,
  });

  factory JobPostPivot.fromJson(Map<String, dynamic> json) {
    return JobPostPivot(
      jobSeekerId: json['job_seeker_id'] as int,
      jobPostId: json['job_post_id'] as int,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job_seeker_id': jobSeekerId,
      'job_post_id': jobPostId,
      'status': status,
    };
  }
}
