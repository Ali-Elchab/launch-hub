import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/models/startup.dart';
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
  User user;
  JobSeeker jobSeeker;
  List<JobPost> jobPosts = [];
  List<JobPost> filteredJobPosts = [];
  String _errorMessage = '';
  String searchQuery = '';
  JobSeekerProfileProvider({required this.user, required this.jobSeeker});
  Startup? startup;
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

  Future fetchJobPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await myDio.get(
        ApiRoute.getRelatedJobPosts,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      jobPosts = JobPost.parseMultipleJobPosts(response.data['jobPosts']);
      notifyListeners();
      return;
    } on DioException catch (e) {
      _errorMessage = 'Failed to sign up: ${e.response?.data['message']}';
    }
    return _errorMessage;
  }

  Future getStartup(id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await myDio.get(
        '${ApiRoute.getStartup}/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      startup = Startup.fromJson(response.data['startup']);
      notifyListeners();
    } on DioException catch (e) {
      _errorMessage = 'Failed to get startup: ${e.response?.data}';
    }
  }

  applyJobPost(id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await myDio.post(
        '${ApiRoute.applyForJob}/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      notifyListeners();
      return response.data['message'];
    } on DioException catch (e) {
      _errorMessage = 'Failed to apply: ${e.response?.data['message']}';
      return e.response?.data['message'];
    }
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    filterJobPosts();
  }

  void filterJobPosts() {
    if (searchQuery.isEmpty) {
      filteredJobPosts = jobPosts;
    } else {
      filteredJobPosts = jobPosts.where((post) {
        return post.jobTitle.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future updateJobSeekerProfile(json) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      await myDio.post(
        ApiRoute.updateJobSeekerProfile,
        data: json,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final jobseeker = JobSeeker.fromJson(json);
      loadJobSeeker(jobseeker);
      notifyListeners();
      return 'success';
    } on DioException catch (e) {
      _errorMessage = '${e.response?.data}';
      return _errorMessage;
    } catch (e) {
      _errorMessage = 'Failed to update jobseeker profile: $e';
      return _errorMessage;
    }
  }
}
