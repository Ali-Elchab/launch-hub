class Niche {
  final int id;
  final String name;
  final int industryId;

  Niche({required this.id, required this.name, required this.industryId});
  factory Niche.fromJson(Map<String, dynamic> json) {
    return Niche(
      id: json['id'] as int,
      name: json['name'] as String,
      industryId: json['industry_id'] as int,
    );
  }
}
