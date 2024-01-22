class Message {
  final int id;
  final String text;
  final int userId;
  final String sender;
  final String createdAt;

  Message({
    required this.id,
    required this.text,
    required this.userId,
    required this.sender,
    required this.createdAt,
  });

  factory Message.fromJson(Map json) {
    return Message(
      id: json['id'] as int,
      text: json['text'] as String,
      userId: json['user_id'] as int,
      sender: json['sender'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'user_id': userId,
      'sender': sender,
      'created_at': createdAt,
    };
  }

  static List<Message> fromJsonList(List json) {
    return json.map((message) => Message.fromJson(message)).toList();
  }
}
