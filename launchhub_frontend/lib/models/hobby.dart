class Hobby {
  final int id;
  final String name;

  Hobby({
    required this.id,
    required this.name,
  });

  factory Hobby.fromJson(Map json) {
    return Hobby(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  static List<Hobby> parseMultipleHobbies(List<dynamic> json) {
    return json.map((hobby) => Hobby.fromJson(hobby)).toList();
  }
}
