class Education {
  Education({
    this.id,
    this.jobSeekerId,
    required this.degree,
    required this.organization,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.location,
  });

  int? id;
  int? jobSeekerId;
  final String degree;
  final String organization;
  final String startDate;
  final String endDate;
  final String description;
  final String location;

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] as int,
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
