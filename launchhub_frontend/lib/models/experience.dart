class Experience {
  int? id;
  final String position;
  final String company;
  final int? industryId;
  final int? specializationId;
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
    required this.industryId,
    required this.specializationId,
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
      industryId: json['industry_id'] as int,
      type: json['type'] as String,
      specializationId: json['specialization_id'] as int,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      jobSeekerId: json['job_seeker_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'company': company,
      'industry_id': industryId,
      'specialization_id': specializationId,
      'type': type,
      'start_date': startDate,
      'end_date': endDate,
      'description': description,
      'location': location,
    };
  }
}
