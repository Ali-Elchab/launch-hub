import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

final startupRegisterProvider =
    ChangeNotifierProvider<StartupRegisterProvider>((ref) {
  return StartupRegisterProvider();
});

class StartupRegisterProvider with ChangeNotifier {
  String _companyName = '';
  TextEditingController date = TextEditingController();
  String _registrationNumber = '';
  String _companyDescription = '';
  Industry? _selectedIndustry;
  Niche? _selectedNiche;
  List<Industry> industries = [];
  List<Niche> niches = [];
  XFile? _image;
  String base64Image = '';
  DateTime? selectedDate;
  String? country;
  String? state;
  String _companyPhoneNumber = '';
  String _companyEmail = '';
  String _companyWebsite = '';
  List socialMediaLinks = [];
  List<String> founders = [];
  List<String> ceos = [];
  List<String> keyExecutives = [];

  String? _errorMessage;

  void setSelectedIndustry(Industry newIndustry) {
    _selectedIndustry = newIndustry;
    _selectedNiche = null;
    notifyListeners();
  }

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

  void setSelectedNiche(Niche newNiche) {
    _selectedNiche = newNiche;
    notifyListeners();
  }

  Future getNiches() async {
    try {
      final response = await myDio.get(
        '${ApiRoute.getSpecializations}/${_selectedIndustry?.id}',
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

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      _image = selectedImage;
      Uint8List bytes = await _image!.readAsBytes();
      base64Image = base64Encode(bytes);
    }

    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      date.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  setCountry(String? value) {
    country = value;
  }

  setStateForState(String? value) {
    state = value;
  }

  addNewFounder(founder) {
    founders.add(founder);
    notifyListeners();
  }

  addNewCEO(ceo) {
    ceos.add(ceo);
    notifyListeners();
  }

  addNewKeyExecutive(keyExecutive) {
    keyExecutives.add(keyExecutive);
    notifyListeners();
  }

  void removeFounder(founder) {
    founders.remove(founder);
    notifyListeners();
  }

  void removeCEO(ceo) {
    ceos.remove(ceo);
    notifyListeners();
  }

  void removeKeyExecutive(keyExecutive) {
    keyExecutives.remove(keyExecutive);
    notifyListeners();
  }

  String get address => '$country $state';
  String get companyName => _companyName;
  String get companyEmail => _companyEmail;
  String get companyPhoneNumber => _companyPhoneNumber;
  String get companyWebsite => _companyWebsite;
  XFile? get selectedImage => _image;
  String get foundingDate => selectedDate.toString();
  String get registrationNumber => _registrationNumber;
  String get companyDescription => _companyDescription;
  Industry? get selectedIndustry => _selectedIndustry;
  Niche? get selectedNiche => _selectedNiche;

  String? get errorMessage => _errorMessage;

  void updateCredentials(String companyName, String registrationNumber,
      String companyDescription) {
    _companyName = companyName;
    _registrationNumber = registrationNumber;
    _companyDescription = companyDescription;
  }

  void updateContactInfo(
      String email,
      String phoneNumber,
      String websiteUrl,
      String linkedInUrl,
      String facebookUrl,
      String instagramUrl,
      String gitHubUrl) {
    _companyEmail = email;
    _companyWebsite = websiteUrl;
    _companyPhoneNumber = phoneNumber;
    if (linkedInUrl.isNotEmpty) {
      socialMediaLinks.add({
        'platform': 'LinkedIn',
        'link': linkedInUrl,
      });
    }
    if (facebookUrl.isNotEmpty) {
      socialMediaLinks.add({
        'platform': 'Facebook',
        'link': facebookUrl,
      });
    }
    if (instagramUrl.isNotEmpty) {
      socialMediaLinks.add({
        'platform': 'Instagram',
        'link': instagramUrl,
      });
    }
    if (gitHubUrl.isNotEmpty) {
      socialMediaLinks.add({
        'platform': 'Github',
        'url': gitHubUrl,
      });
    }
  }

  bool _isRegistered = false;
  bool get isRegistered => _isRegistered;
  Future registerStartup() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return;
    }

    final data = <String, dynamic>{
      "company_name": _companyName,
      "registration_number": _registrationNumber,
      "founding_date": selectedDate.toString(),
      'profilePic': base64Image,
      "company_description": _companyDescription,
      "industry_id": _selectedIndustry!.id,
      "specialization_id": _selectedNiche!.id,
      "company_phone": _companyPhoneNumber,
      "company_email": _companyEmail,
      "company_address": address,
      "website_url": _companyWebsite,
      'social_media_links': socialMediaLinks,
      'founders': founders,
      'ceos': ceos,
      'key_executives': keyExecutives,
    };

    try {
      final response = await myDio.post(
        ApiRoute.registerStartup,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        _isRegistered = true;
        notifyListeners();
        return response.data;
      }
    } on DioException catch (e) {
      _isRegistered = false;
      _errorMessage = 'Failed: ${e.response!.data['message']}';
    } catch (e) {
      _isRegistered = false;
      _errorMessage = 'Failed to register:  ${e.toString()}';
    }
    notifyListeners();
  }
}
