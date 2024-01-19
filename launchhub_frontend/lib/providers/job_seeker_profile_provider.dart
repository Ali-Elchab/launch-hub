import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

final jobSeekerProfileProvider =
    ChangeNotifierProvider<JobSeekerProfileProvider>((ref) {
  return JobSeekerProfileProvider(
      user: User(
        id: 0,
        email: '',
        typeId: 0,
      ),
      jobSeeker: JobSeeker(
        id: 0,
        firstName: '',
        lastName: '',
        phone: '',
        address: '',
        bio: '',
        dob: '',
        isAvailable: 0,
        profilePic: '',
        resume: '',
        specializationId: 0,
        industryId: 0,
        userId: 0,
      ));
});

class JobSeekerProfileProvider with ChangeNotifier {
  JobSeekerProfileProvider({required this.user, required this.jobSeeker});
  User user;
  JobSeeker jobSeeker;
  void loadUser(User u) {
    user = u;
    notifyListeners();
  }

  void loadJobSeeker(JobSeeker jobseeker) {
    jobSeeker = jobseeker;
    notifyListeners();
  }

  Future fetchJobSeeker() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await myDio.get(
        ApiRoute.getJobSeekerBasicProfile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final jobSeeker = JobSeeker.fromJson(response.data['jobSeeker']);
      loadJobSeeker(jobSeeker);
    } on DioException catch (e) {
      return 'Failed to get jobSeeker profile: ${e.response?.data['message']}';
    } catch (e) {
      return 'Failed to get jobSeeker profile: $e';
    }
    notifyListeners();

    return;
  }
}
