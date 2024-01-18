import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/certification.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/models/experience.dart';
import 'package:launchhub_frontend/models/hobby.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/models/skill.dart';
import 'package:launchhub_frontend/models/social_media_link.dart';
import 'package:launchhub_frontend/models/startup.dart';
import 'package:launchhub_frontend/providers/startup_profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final hireTalentProvider = ChangeNotifierProvider<HireTalentProvider>((ref) {
  final startupHome = ref.watch(startupProfileProvider);
  return HireTalentProvider(jobSeekers: [], startup: startupHome.startup);
});

class HireTalentProvider with ChangeNotifier {
  HireTalentProvider({required this.jobSeekers, required this.startup});
  Startup startup;
  List<JobSeeker> jobSeekers = [];
  List<SocialMediaLink> socialMediaLinks = [];
  List<Education> educations = [];
  List<Experience> experiences = [];
  List<Certification> certifications = [];
  List<Hobby> hobbies = [];
  List<Skill> skills = [];
  String _errorMessage = '';
  void loadJobSeekers(List<JobSeeker> jobSeekers) {
    jobSeekers = jobSeekers;
    notifyListeners();
  }

  Future fetchJobSeekers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await myDio.get(
        '${ApiRoute.getRelatedJobSeekers}/${startup.specializationId}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      jobSeekers =
          JobSeeker.parseMultipleJobSeekers(response.data['jobseekers']);
      loadJobSeekers(jobSeekers);
      notifyListeners();
      return;
    } on DioException catch (e) {
      _errorMessage = 'Failed to sign up: ${e.response?.data['message']}';
    }
    return _errorMessage;
  }

  Future getJobSeekerProfile(id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await myDio.get(
        '${ApiRoute.getJobSeekerProfile}/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print(response);
      final data = response.data['jobSeeker'];
      socialMediaLinks = SocialMediaLink.parseMultipleSocialMediaLinks(
          data['socialMediaLinks']);
      educations = Education.parseMultipleEducations(data['educations']);
      experiences = Experience.parseMultipleExperiences(data['experiences']);
      certifications =
          Certification.parseMultipleCertifications(data['certifications']);
      hobbies = Hobby.parseMultipleHobbies(data['hobbies']);
      skills = Skill.parseMultipleSkills(data['skills']);

      notifyListeners();
      return;
    } on DioException catch (e) {
      _errorMessage = 'Failed to sign up: ${e.response?.data['message']}';
      print(_errorMessage + 'error');
    }
    return;
  }
}
