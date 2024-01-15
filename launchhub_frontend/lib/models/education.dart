class Education {
  Education({
    required this.degree,
    required this.organization,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.location,
  });

  final String degree;
  final String organization;
  final String startDate;
  final String endDate;
  final String description;
  final String location;

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'] as String,
      organization: json['organization'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
    );
  }
}
