// ignore: file_names
import 'package:uuid/uuid.dart';

const uuid = Uuid();

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
    this.jobStatus = 'open',
    required this.industryId,
    required this.specializationId,
  }) : id = uuid.v4();

  final String id;
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
  String jobStatus = 'open';
  final int industryId;
  final int specializationId;
}
