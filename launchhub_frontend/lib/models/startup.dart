class Startup {
  int id;
  String companyName;
  String companyEmail;
  String companyPhone;
  String? copmanyLogo;
  String companyDescription;
  String? companyWebsiteUrl;
  String? registrationNumber;
  String foundingDate;
  String companyAddress;
  int userId;
  int industryId;
  int specializationId;
  List socialMediaLinks;
  List? founders;
  List? ceos;
  List? keyExcecutives;

  Startup({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    this.copmanyLogo,
    required this.companyDescription,
    this.companyWebsiteUrl,
    this.registrationNumber,
    required this.foundingDate,
    required this.companyAddress,
    required this.userId,
    required this.industryId,
    required this.specializationId,
    required this.socialMediaLinks,
    required this.founders,
    this.ceos,
    this.keyExcecutives,
  });

  factory Startup.fromJson(Map<String, dynamic> json) {
    return Startup(
      id: json['id'],
      companyName: json['company_name'],
      companyEmail: json['company_email'],
      companyPhone: json['company_phone'],
      copmanyLogo: json['logo_url'],
      companyDescription: json['company_description'],
      companyWebsiteUrl: json['website_url'],
      registrationNumber: json['registration_number'],
      foundingDate: json['founding_date'],
      companyAddress: json['company_address'],
      userId: json['user_id'],
      industryId: json['industry_id'],
      specializationId: json['specialization_id'],
      socialMediaLinks: json['socialMediaLinks'],
      founders: json['founders'],
      ceos: json['ceos'],
      keyExcecutives: json['key_executives'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    data['company_email'] = companyEmail;
    data['company_phone'] = companyPhone;
    data['logo_url'] = copmanyLogo;
    data['company_description'] = companyDescription;
    data['registration_number'] = registrationNumber;
    data['founding_date'] = foundingDate;
    data['company_address'] = companyAddress;
    data['website_url'] = companyWebsiteUrl;
    data['user_id'] = userId;
    data['industry_id'] = industryId;
    data['specialization_id'] = specializationId;
    data['socialMediaLinks'] = socialMediaLinks;
    data['founders'] = founders;
    data['ceos'] = ceos;
    data['key_executives'] = keyExcecutives;
    return data;
  }
}
