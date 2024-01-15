import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:launchhub_frontend/helpers/base_url.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';

final dio = Dio();

final jobSeekerRegisterProvider =
    ChangeNotifierProvider<JobSeekerRegisterProvider>((ref) {
  return JobSeekerRegisterProvider();
});

class JobSeekerRegisterProvider with ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  TextEditingController date = TextEditingController();
  DateTime? selectedDate;
  String _phoneNumber = '';
  String _professionalBio = '';
  Industry? _selectedIndustry;
  Niche? _selectedNiche;
  List<Industry> industries = [];
  List<Niche> niches = [];
  XFile? _image;

  // String? country;
  // String? state;
  // String _companyWebsite = '';
  // List socialMediaLinks = [];
  // List<String> founders = [];
  // List<String> ceos = [];
  // List<String> keyExecutives = [];

  String? _errorMessage;

  void setSelectedIndustry(Industry newIndustry) {
    _selectedIndustry = newIndustry;
    notifyListeners();
  }

  Future getIndustries() async {
    try {
      final response = await dio.get(
        "${baseURL}industries",
      );
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
      final response = await dio.get(
        "${baseURL}specializations/${_selectedIndustry?.id}",
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
    }
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      date.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  // setCountry(String? value) {
  //   country = value;
  // }

  // setStateForState(String? value) {
  //   state = value;
  // }

  // addNewFounder(founder) {
  //   founders.add(founder);
  //   notifyListeners();
  // }

  // void removeFounder(founder) {
  //   founders.remove(founder);
  //   notifyListeners();
  // }

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phoneNumber => _phoneNumber;
  String get professionalBio => _professionalBio;
  XFile? get selectedImage => _image;
  String get foundingDate => selectedDate.toString();
  Industry? get selectedIndustry => _selectedIndustry;
  Niche? get selectedNiche => _selectedNiche;
  // String get address => '$country $state';

  String? get errorMessage => _errorMessage;

  void updatePersonalInfo(
      String firstName, String lastName, String phoneNumber, String bio) {
    _firstName = firstName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _professionalBio = bio;
  }

  // void updateContactInfo(
  //     String email,
  //     String phoneNumber,
  //     String websiteUrl,
  //     String linkedInUrl,
  //     String facebookUrl,
  //     String instagramUrl,
  //     String gitHubUrl) {
  //   _companyEmail = email;
  //   _companyWebsite = websiteUrl;
  //   _companyPhoneNumber = phoneNumber;
  //   if (linkedInUrl.isNotEmpty) {
  //     socialMediaLinks.add({
  //       'name': 'LinkedIn',
  //       'url': linkedInUrl,
  //     });
  //     if (facebookUrl.isNotEmpty) {
  //       socialMediaLinks.add({
  //         'name': 'Facebook',
  //         'url': facebookUrl,
  //       });
  //       if (instagramUrl.isNotEmpty) {
  //         socialMediaLinks.add({
  //           'name': 'Instagram',
  //           'url': instagramUrl,
  //         });
  //       }
  //       if (gitHubUrl.isNotEmpty) {
  //         socialMediaLinks.add({
  //           'name': 'Github',
  //           'url': gitHubUrl,
  //         });
  //       }
  //     }
  //   }
  // }
}
