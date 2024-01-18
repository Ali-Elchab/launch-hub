import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:shared_preferences/shared_preferences.dart';

final jobBoardProvider = StateProvider<JobBoardProvider>((ref) {
  return JobBoardProvider(jobPosts: []);
});

class JobBoardProvider with ChangeNotifier {
  List<JobPost> jobPosts;
  String _errorMessage = '';
  Industry? _selectedIndustry;
  Niche? _selectedNiche;
  String? country;
  String? state;
  JobBoardProvider({required this.jobPosts});

  String? get address => '$country $state';
  String? get errorMessage => _errorMessage;
  Industry? get selectedIndustry => _selectedIndustry;
  Niche? get selectedNiche => _selectedNiche;
  void loadJobPosts(List<JobPost> jobPosts) {
    jobPosts = jobPosts;
    notifyListeners();
  }

  Future fetchJobPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await myDio.get(
        ApiRoute.getStartupJobPosts,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      jobPosts = jobPosts = JobPost.parseMultipleJobPosts(response.data);
      loadJobPosts(jobPosts);
      notifyListeners();
      return;
    } on DioException catch (e) {
      _errorMessage = 'Failed to sign up: ${e.response?.data['message']}';
    }
    return _errorMessage;
  }

  Future postJob(JobPost jobPost) async {
    final data = jobPost.toJson();
    print(data);
    jobPosts.add(jobPost);
    try {
      print('in tr ');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await myDio.post(
        ApiRoute.postJob,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      _errorMessage = 'Failed to post job: ${response.data['message']}';

      notifyListeners();
    } on DioException catch (e) {
      jobPosts.remove(jobPost);
      _errorMessage = 'Failed to post job: ${e.response}';
      print(_errorMessage);
    } catch (e) {
      jobPosts.remove(jobPost);
      _errorMessage = "Error: $e";
      print(_errorMessage);
    }
    notifyListeners();
  }

  Future removeJobPost(JobPost jobPost, context) async {
    jobPosts.remove(jobPost);
    try {
      final id = jobPost.id;
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await myDio.delete(
        '${ApiRoute.deleteJobPost}/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('Job Post Deleted.'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              jobPosts.add(jobPost);
              postJob(jobPost);
            },
          ),
        ),
      );
      _errorMessage = response.data['message'];
      notifyListeners();
    } catch (e) {
      _errorMessage = "Error: $e";
    }
    notifyListeners();
  }

  setCountry(String? value) {
    country = value;
  }

  setStateForState(String? value) {
    state = value;
  }

  Future updateJobPost(json) async {
    jobPosts[jobPosts.indexWhere((element) => element.id == json['id'])] =
        JobPost.fromJson(json);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await myDio.post(
        '${ApiRoute.updateJobPost}/${json['id']}',
        data: json,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      _errorMessage = response.data['message'];
      notifyListeners();
    } catch (e) {
      _errorMessage = "Error: $e";
    }
    notifyListeners();
  }
}
