class Experience {
  int? id;
  final String position;
  final String company;
  final int industry;
  final int specialization;
  final String type;
  final String startDate;
  final String endDate;
  final String description;
  final String location;
  final int? jobSeekerId;

  Experience({
    this.id,
    required this.position,
    required this.company,
    required this.industry,
    required this.specialization,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.location,
    this.jobSeekerId,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as int,
      position: json['position'] as String,
      company: json['company'] as String,
      industry: json['industry'] as int,
      type: json['type'] as String,
      specialization: json['specialization'] as int,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      jobSeekerId: json['job_seeker_id'] as int,
    );
  }
}
