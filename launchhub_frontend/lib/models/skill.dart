class Skill {
  final int id;
  final String name;
  int? specializationId;

  Skill({
    required this.id,
    required this.name,
    this.specializationId,
  });

  factory Skill.fromJson(Map json) {
    return Skill(
      id: json['id'] as int,
      name: json['name'] as String,
      specializationId: json['specialization_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization_id': specializationId,
    };
  }

  static List<Skill> parseMultipleSkills(List<dynamic> json) {
    return json.map((skill) => Skill.fromJson(skill)).toList();
  }
}
