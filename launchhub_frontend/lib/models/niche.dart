class Niche {
  final int id;
  final String name;

  Niche({required this.id, required this.name});
  factory Niche.fromJson(Map<String, dynamic> json) {
    return Niche(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
