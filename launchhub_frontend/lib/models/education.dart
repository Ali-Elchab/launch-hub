import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Education {
  Education({
    required this.id,
    required this.degree,
    required this.organization,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.location,
    required this.jobSeekerId,
  });

  final String degree;
  final String organization;
  final String startDate;
  final String endDate;
  final String description;
  final String location;
  final int jobSeekerId;
  final String id;

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] as String? ??
          const Uuid().v4(), // Generate a new UUID if not provided
      degree: json['degree'] as String,
      organization: json['organization'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      jobSeekerId: json['job_seeker_id'] as int,
    );
  }
}
