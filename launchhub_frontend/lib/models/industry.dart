class Industry {
  final int id;
  final String name;

  Industry({required this.id, required this.name});

  factory Industry.fromJson(Map<String, dynamic> json) {
    return Industry(
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
}
