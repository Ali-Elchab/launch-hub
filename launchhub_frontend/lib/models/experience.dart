import 'package:uuid/uuid.dart';

class Experience {
  final String id;
  final String position;
  final String company;
  final String industry;
  final String type;
  final String startDate;
  final String endDate;
  final String description;
  final String location;
  final int jobSeekerId;

  Experience({
    required this.id,
    required this.position,
    required this.company,
    required this.industry,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.location,
    required this.jobSeekerId,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as String? ??
          const Uuid().v4(), // Generate a new UUID if not provided
      position: json['position'] as String,
      company: json['company'] as String,
      industry: json['industry'] as String,
      type: json['type'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      jobSeekerId: json['job_seeker_id'] as int,
    );
  }
}
