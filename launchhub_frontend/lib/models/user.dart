class User {
  String email;
  String type;

  User({
    required this.email,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(email: json['email'], type: json['type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}
