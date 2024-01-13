import 'package:launchhub_frontend/models/social_media_link.dart';

class Startup {
  int id;
  String companyName;
  String companyEmail;
  String companyPhone;
  String copmanyLogo;
  String companyDescription;
  String companyWebsiteUrl;
  String registrationNumber;
  DateTime foundingDate;
  String companyAddress;
  String companyBio;
  int userId;
  int industryId;
  int specializationId;
  List<SocialMediaLink> socialMediaLinks;
  List<String> founders;
  List<String> ceos;
  List<String> keyExcecutives;

  Startup({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.copmanyLogo,
    required this.companyDescription,
    required this.companyWebsiteUrl,
    required this.registrationNumber,
    required this.foundingDate,
    required this.companyAddress,
    required this.companyBio,
    required this.userId,
    required this.industryId,
    required this.specializationId,
    required this.socialMediaLinks,
    required this.founders,
    required this.ceos,
    required this.keyExcecutives,
  });

  factory Startup.fromJson(Map<String, dynamic> json) {
    return Startup(
      id: json['id'],
      companyName: json['companyName'],
      companyEmail: json['companyEmail'],
      companyPhone: json['companyPhone'],
      copmanyLogo: json['copmanyLogo'],
      companyDescription: json['companyDescription'],
      companyWebsiteUrl: json['companyWebsiteUrl'],
      registrationNumber: json['registrationNumber'],
      foundingDate: json['foundingDate'],
      companyAddress: json['companyAddress'],
      companyBio: json['companyBio'],
      userId: json['userId'],
      industryId: json['industryId'],
      specializationId: json['specializationId'],
      socialMediaLinks: json['socialMediaLinks'],
      founders: json['founders'],
      ceos: json['ceos'],
      keyExcecutives: json['keyExcecutives'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['companyName'] = companyName;
    data['companyEmail'] = companyEmail;
    data['companyPhone'] = companyPhone;
    data['copmanyLogo'] = copmanyLogo;
    data['companyDescription'] = companyDescription;
    data['companyWebsiteUrl'] = companyWebsiteUrl;
    data['registrationNumber'] = registrationNumber;
    data['foundingDate'] = foundingDate;
    data['companyAddress'] = companyAddress;
    data['companyBio'] = companyBio;
    data['userId'] = userId;
    data['industryId'] = industryId;
    data['specializationId'] = specializationId;
    data['socialMediaLinks'] = socialMediaLinks;
    data['founders'] = founders;
    data['ceos'] = ceos;
    data['keyExcecutives'] = keyExcecutives;
    return data;
  }
}
