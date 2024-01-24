import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/advisor.dart';
import 'package:launchhub_frontend/models/hobby.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/models/skill.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dataProvider = ChangeNotifierProvider<DataProvider>((ref) {
  return DataProvider();
});

class DataProvider with ChangeNotifier {
  String? _errorMessage;
  List<Industry> industries = [];
  List<Niche> niches = [];
  List<Skill> skills = [];
  List<Hobby> hobbies = [];
  List<Advisor> advisors = [];
  String nicheName = '';
  String industryName = '';
  String? get errorMessage => _errorMessage;

  Future getIndustries() async {
    try {
      final response = await myDio.get(ApiRoute.getIndustries);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['industries'];
        industries = data.map((json) => Industry.fromJson(json)).toList();
      }
    } on DioException catch (e) {
      _errorMessage =
          'Failed to get industries: ${e.response?.data['message']}';
    } catch (e) {
      _errorMessage = 'Failed to get industries: $e';
    }
    notifyListeners();
  }

  Future getNiches(industry) async {
    niches = [];
    try {
      final response = await myDio.get(
        '${ApiRoute.getIndustrySpecializations}/${industry.id}',
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['specializations'];
        niches = data.map((json) => Niche.fromJson(json)).toList();
      }
    } on DioException catch (e) {
      _errorMessage =
          'Failed to get Specializations: ${e.response?.data['message']}';
    } catch (e) {
      _errorMessage = 'Failed to get industries: $e';
    }
    notifyListeners();
  }

  Future getSkills(Niche niche) async {
    try {
      final response = await myDio.get(
        '${ApiRoute.getSkills}/${niche.id}',
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['skills'];
        skills = data.map((json) => Skill.fromJson(json)).toList();
      }
    } on DioException catch (e) {
      _errorMessage = 'Failed to get Skills: ${e.response?.data['message']}';
    } catch (e) {
      _errorMessage = 'Failed to get Skills: $e';
    }
    try {
      final response = await myDio.get(
        ApiRoute.getGeneralSkills,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['skills'];
        skills = [...skills, ...data.map((json) => Skill.fromJson(json))];
        notifyListeners();
      }
    } on DioException catch (e) {
      _errorMessage = 'Failed to get Skills: ${e.response?.data['message']}';
    } catch (e) {
      _errorMessage = 'Failed to get Skills: $e';
    }
    notifyListeners();
  }

  Future getHobbies() async {
    try {
      final response = await myDio.get(ApiRoute.getHobbies);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['hobbies'];
        hobbies = data.map((json) => Hobby.fromJson(json)).toList();
      }
    } on DioException catch (e) {
      _errorMessage = 'Failed to get Hobbies: ${e.response?.data['message']}';
    } catch (e) {
      _errorMessage = 'Failed to get Hobbies: $e';
    }

    notifyListeners();
  }

  Future getAdvisors() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await myDio.get(
        ApiRoute.getAdvisors,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      advisors = Advisor.parseMultipleAdvisors(response.data);
      notifyListeners();
    } catch (e) {
      return 'Failed to get advisors: $e';
    }
  }

  Future<String> getNicheName(nicheId) async {
    try {
      final response =
          await myDio.get('${ApiRoute.getSpecializations}/$nicheId');
      nicheName = response.data['specialization']['name'];
    } catch (e) {
      return 'Failed to get niche name: $e';
    }
    notifyListeners();
    return nicheName;
  }

  Future<List<dynamic>> fetchUdemyCourses(String searchQuery) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await myDio.get(
        '${ApiRoute.getUdemyCourses}/$searchQuery',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final List<dynamic> courses = response.data['results'];
      return courses;
    } catch (e) {
      return [];
    }
  }
}
