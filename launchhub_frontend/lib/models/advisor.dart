class Advisor {
  final int id;
  final String name;
  final String email;
  final String? location;
  final String phone;
  final String bio;
  final String? profilePic;
  final String category;
  final String expertise;
  Advisor({
    required this.id,
    required this.name,
    required this.email,
    this.location,
    required this.phone,
    required this.bio,
    this.profilePic,
    required this.category,
    required this.expertise,
  });

  factory Advisor.fromJson(Map json) {
    return Advisor(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      location: json['location'] as String?,
      phone: json['phone'] as String,
      bio: json['bio'] as String,
      profilePic: json['photo_url'] as String,
      category: json['category'] as String,
      expertise: json['expertise'] as String,
    );
  }

  static List<Advisor> parseMultipleAdvisors(List<dynamic> jsons) {
    List<Advisor> list = [];
    for (Map json in jsons) {
      list.add(Advisor.fromJson(json));
    }
    return list;
  }
}
