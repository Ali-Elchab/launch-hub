import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/models/startup.dart';
import 'package:launchhub_frontend/providers/startup_profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final hireTalentProvider = StateProvider<HireTalentProvider>((ref) {
  final startupHome = ref.watch(startupProfileProvider);
  return HireTalentProvider(jobSeekers: [], startup: startupHome.startup);
});

class HireTalentProvider with ChangeNotifier {
  HireTalentProvider({required this.jobSeekers, required this.startup});
  Startup startup;
  List<JobSeeker> jobSeekers = [];
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
}
