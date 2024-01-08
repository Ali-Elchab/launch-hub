import 'package:uuid/uuid.dart';

const uuid = Uuid();

class SocialMediaLink {
  SocialMediaLink({
    required this.id,
    required this.platform,
    required this.link,
    required this.userId,
  });

  final String platform;
  final String link;
  final int userId;
  final String id;

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      id: uuid.v4(),
      platform: json['platform'] as String,
      link: json['link'] as String,
      userId: json['user_id'] as int,
    );
  }
}
