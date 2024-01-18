class Certification {
  int? id;
  int? jobSeekerId;
  final String name;
  final String certificate;
  final String organization;
  final String startDate;
  final String endDate;
  final String description;
  final String location;

  Certification({
    this.id,
    required this.name,
    required this.certificate,
    required this.organization,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.location,
    this.jobSeekerId,
  });

  factory Certification.fromJson(Map json) {
    return Certification(
      id: json['id'] as int,
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'certificate': certificate,
      'organization': organization,
      'start_date': startDate,
      'end_date': endDate,
      'description': description,
      'location': location,
    };
  }

  static List<Certification> parseMultipleCertifications(List<dynamic> json) {
    return json
        .map((certification) => Certification.fromJson(certification))
        .toList();
  }
}
