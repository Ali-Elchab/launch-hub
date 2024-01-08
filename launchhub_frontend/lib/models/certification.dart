import 'package:uuid/uuid.dart';

class Certification {
  final String id;
  final String name;
  final String certificate;
  final String organization;
  final String startDate;
  final String endDate;
  final String description;
  final String location;
  final int jobSeekerId;

  Certification({
    required this.id,
    required this.name,
    required this.certificate,
    required this.organization,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.location,
    required this.jobSeekerId,
  });

  factory Certification.fromJson(Map<String, dynamic> json) {
    return Certification(
      id: json['id'] as String? ??
          const Uuid().v4(), // Generate a new UUID if not provided
      name: json['name'] as String,
      certificate: json['certificate'] as String,
      organization: json['organization'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      jobSeekerId: json['job_seeker_id'] as int,
    );
  }
}
