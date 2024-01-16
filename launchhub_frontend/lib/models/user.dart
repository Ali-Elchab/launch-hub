class User {
  int id;
  String email;
  int typeId;

  User({
    required this.id,
    required this.email,
    required this.typeId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'], email: json['email'], typeId: json['user_type_id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['user_type_id'] = typeId;
    return data;
  }
}
