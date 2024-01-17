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
      email: '',
      type: 0,
      id: 0,
      startupId: 0,
      companyName: '',
      companyEmail: '',
      companyPhone: '',
      companyAddress: '',
      companyDescription: '',
      companyWebsite: '',
      companyLogo: '',
      companyRegistrationNumber: '',
      foundingDate: '',
      specializationId: 0,
      industryId: 0,
      founders: [],
      ceos: [],
      keyExecutives: [],
      socialMediaLinks: []);
});

class StartupProfileProvider with ChangeNotifier {
  String email;
  int type;
  int id;
  int startupId;
  String companyName;
  String companyEmail;
  String companyPhone;
  String companyAddress;
  String companyDescription;
  String companyWebsite;
  String companyLogo;
  String companyRegistrationNumber;
  String foundingDate;
  int specializationId;
  int industryId;
  List founders;
  List ceos;
  List keyExecutives;
  List socialMediaLinks = [];

  StartupProfileProvider(
      {required this.email,
      required this.type,
      required this.id,
      required this.startupId,
      required this.companyName,
      required this.companyEmail,
      required this.companyPhone,
      required this.companyAddress,
      required this.companyDescription,
      required this.companyWebsite,
      required this.companyLogo,
      required this.companyRegistrationNumber,
      required this.foundingDate,
      required this.specializationId,
      required this.industryId,
      required this.founders,
      required this.ceos,
      required this.keyExecutives,
      required this.socialMediaLinks});

  void loadUser(User user) {
    email = user.email;
    type = user.typeId;
    id = user.id;

    notifyListeners();
  }

  void loadStartup(Startup startup) {
    startupId = startup.id;
    companyName = startup.companyName;
    companyEmail = startup.companyEmail;
    companyPhone = startup.companyPhone;
    companyAddress = startup.companyAddress;
    companyDescription = startup.companyDescription;
    companyWebsite = startup.companyWebsiteUrl ?? '';
    companyLogo = startup.copmanyLogo ?? '';
    companyRegistrationNumber = startup.registrationNumber ?? '';
    foundingDate = startup.foundingDate.toString();
    specializationId = startup.specializationId;
    industryId = startup.industryId;
    founders = startup.founders ?? [];
    ceos = startup.ceos ?? [];
    keyExecutives = startup.keyExcecutives ?? [];
    socialMediaLinks = startup.socialMediaLinks;

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
}
