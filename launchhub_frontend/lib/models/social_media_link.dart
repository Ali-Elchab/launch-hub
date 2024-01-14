class SocialMediaLink {
  SocialMediaLink({
    required this.platform,
    required this.link,
    required this.userId,
  });

  final String platform;
  final String link;
  final int userId;

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      platform: json['platform'] as String,
      link: json['link'] as String,
      userId: json['user_id'] as int,
    );
  }
}
