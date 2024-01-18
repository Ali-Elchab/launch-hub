class SocialMediaLink {
  SocialMediaLink({
    required this.id,
    required this.platform,
    required this.link,
    required this.userId,
  });
  final int id;
  final String platform;
  final String link;
  final int userId;

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      id: json['id'] as int,
      platform: json['platform'] as String,
      link: json['link'] as String,
      userId: json['user_id'] as int,
    );
  }

  static List<SocialMediaLink> parseMultipleSocialMediaLinks(
      List<dynamic> json) {
    return json.map((e) => SocialMediaLink.fromJson(e)).toList();
  }
}
