import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/startup.dart';
import 'package:launchhub_frontend/models/user.dart';
import 'package:launchhub_frontend/providers/startup_register_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final startupProfileProvider = StateProvider<StartupProfileProvider>((ref) {
  return StartupProfileProvider(
    user: User(
      id: 0,
      email: '',
      typeId: 0,
    ),
    startup: Startup(
      id: 0,
      companyName: '',
      companyEmail: '',
      companyPhone: '',
      companyAddress: '',
      companyDescription: '',
      companyWebsiteUrl: '',
      copmanyLogo: '',
      registrationNumber: '',
      foundingDate: '',
      specializationId: 0,
      industryId: 0,
      founders: [],
      ceos: [],
      keyExcecutives: [],
      socialMediaLinks: [],
      userId: 0,
    ),
  );
});

class StartupProfileProvider with ChangeNotifier {
  User user;
  Startup startup;
  String nicheName = '';
  String industryName = '';
  StartupProfileProvider({required this.startup, required this.user});

  void loadUser(User user) {
    user = user;
    notifyListeners();
  }

  void loadStartup(Startup startUp) {
    startup = startUp;
    notifyListeners();
  }

  Future fetchStartupProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await myDio.get(
        ApiRoute.getStartupProfile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final startup = Startup.fromJson(response.data['startup']);
      loadStartup(startup);
    } on DioException catch (e) {
      return 'Failed to get startup profile: ${e.response?.data['message']}';
    } catch (e) {
      return 'Failed to get startup profile: $e';
    }
    notifyListeners();

    return;
  }

  // String getNicheName() {
  //   final industry = industries.firstWhere(
  //     (element) => element.id == startup.industryId,
  //     orElse: () => industries.first,
  //   );
  //   industryName = industry.name;
  //   notifyListeners();
  //   return industryName;
  // }

  Future<String> getNicheName() async {
    try {
      final response = await myDio
          .get('${ApiRoute.getSpecializations}/${startup.specializationId}');
      nicheName = response.data['specialization']['name'];
    } catch (e) {
      return 'Failed to get niche name: $e';
    }
    notifyListeners();
    return nicheName;
  }
}
