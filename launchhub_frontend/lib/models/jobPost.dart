import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum JobStatus { open, closed }

enum PreferredGender { male, female, any }

enum JobType { fullTime, partTime, contract, internship, temporary }

class JobPost {
  JobPost({
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
  }) : id = uuid.v4();

  final String id;
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
}
