import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/startup.dart';
import 'package:launchhub_frontend/models/user.dart';
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
  String _errorMessage = '';
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
      final jsonStartup = await response.data['startup'];
      final startup = Startup.fromJson(jsonStartup);
      loadStartup(startup);
    } on DioException catch (e) {
      _errorMessage = '${e.response?.data['message']}';
      return _errorMessage;
    } catch (e) {
      _errorMessage = 'Failed to get startup profile: $e';
      return _errorMessage;
    }
    notifyListeners();

    return;
  }

  Future updateStartupProfile(json) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      await myDio.post(
        ApiRoute.updateStartupProfile,
        data: json,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final startUp = Startup.fromJson(json);
      loadStartup(startUp);
      notifyListeners();
      return 'success';
    } on DioException catch (e) {
      _errorMessage = '${e.response?.data}';
      return _errorMessage;
    } catch (e) {
      _errorMessage = 'Failed to update startup profile: $e';
      return _errorMessage;
    }
  }
}
