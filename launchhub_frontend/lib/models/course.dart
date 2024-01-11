class Course {
  Course({
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

  final String certificate;
  final String name;
  final String organization;
  final String startDate;
  final String endDate;
  final String description;
  final String location;
  final int jobSeekerId;
  final int id;

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'], // Generate a new UUID if not provided
      organization: json['organization'] as String,
      certificate: json['certificate'] as String,
      name: json['name'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      jobSeekerId: json['job_seeker_id'] as int,
    );
  }
}
