import 'job_post.dart';
import 'education.dart';
import 'experience.dart';
import 'certification.dart';
import 'hobby.dart';
import 'skill.dart';

class JobSeeker {
  int? id;
  final String firstName;
  final String lastName;
  final String? profilePic;
  final DateTime dob;
  final String phone;
  final String address;
  final String bio;
  final String? resume;
  bool? isAvailable;
  final int industryId;
  int? userId;
  final int specializationId;
  final List? socialMediaLinks;
  final List<Education>? educations;
  final List<Experience>? experiences;
  final List<Certification>? certifications;
  final List<Hobby>? hobbies;
  final List<Skill>? skills;
  final List<JobPost>? jobPosts;
  JobSeeker({
    this.id,
    required this.firstName,
    required this.lastName,
    this.profilePic,
    required this.dob,
    required this.phone,
    required this.address,
    required this.bio,
    this.resume,
    this.isAvailable,
    required this.industryId,
    this.userId,
    required this.specializationId,
    this.socialMediaLinks,
    this.educations,
    this.experiences,
    this.certifications,
    this.hobbies,
    this.skills,
    this.jobPosts,
  });

  factory JobSeeker.fromJson(Map<String, dynamic> json) {
    return JobSeeker(
      id: json['id'],
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      profilePic: json['profile_pic'] as String?,
      dob: DateTime.parse(json['dob'] as String),
      phone: json['phone'] as String,
      address: json['address'] as String,
      bio: json['bio'] as String,
      resume: json['resume'] as String?,
      isAvailable: json['is_available'],
      userId: json['user_id'] as int?,
      industryId: json['industry_id'] as int,
      specializationId: json['industry_id'] as int,
      // socialMediaLinks: (json['socialMediaLinks'] as List)
      //     .map((i) => SocialMediaLink.fromJson(i))
      //     .toList(),
      // educations: (json['educations'] as List)
      //     .map((i) => Education.fromJson(i))
      //     .toList(),
      // experiences: (json['experiences'] as List)
      //     .map((i) => Experience.fromJson(i))
      //     .toList(),
      // certifications: (json['certifications'] as List)
      //     .map((i) => Certification.fromJson(i))
      //     .toList(),
      // hobbies: (json['hobbies'] as List).map((i) => Hobby.fromJson(i)).toList(),
      // skills: (json['skills'] as List).map((i) => Skill.fromJson(i)).toList(),
      // jobPosts:
      //     (json['job_posts'] as List).map((i) => JobPost.fromJson(i)).toList(),
    );
  }

  static Map<String, dynamic> toJson(
      {firstName,
      lastName,
      profilePic,
      dob,
      phone,
      address,
      bio,
      resume,
      industryId,
      userId,
      specializationId,
      socialMediaLinks,
      educations,
      experiences,
      certifications,
      hobbies,
      skills,
      jobPosts}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['profile_pic'] = profilePic;
    data['dob'] = dob;
    data['phone'] = phone;
    data['address'] = address;
    data['bio'] = bio;
    data['resume'] = resume;
    data['industry_id'] = industryId;
    data['user_id'] = userId;
    data['specialization_id'] = specializationId;
    data['social_media_links'] = socialMediaLinks;
    data['educations'] = educations;
    data['experiences'] = experiences;
    data['certifications'] = certifications;
    data['hobbies'] = hobbies;
    data['skills'] = skills;
    return data;
  }
}
