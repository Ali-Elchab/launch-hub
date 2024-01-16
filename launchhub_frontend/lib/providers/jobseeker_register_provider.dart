import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/certification.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/models/experience.dart';
import 'package:launchhub_frontend/models/hobby.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/models/skill.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String base64Image = '';
  String resumeName = '';
  String base64Resume = '';
  String? country;
  String? state;
  List socialMediaLinks = [];
  List<Education> educations = [];

  List<Certification> certifications = [];
  List<Experience> experiences = [];
  List<Skill> skills = [];
  List<int> selectedSkills = [];
  List<Hobby> hobbies = [];
  List<int> selectedHobbies = [];

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

  Future getNiches({Industry? industry}) async {
    industry ??= _selectedIndustry;
    try {
      final response = await myDio.get(
        '${ApiRoute.getSpecializations}/${industry?.id}',
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['specializations'];
        niches = data.map((json) => Niche.fromJson(json)).toList();
        notifyListeners();
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
      lastDate: DateTime(2101),
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

  addEducation(Education education) {
    educations.add(education);
    notifyListeners();
  }

  removeEducation(Education education, BuildContext context) {
    final educationIndex = educations.indexOf(education);

    educations.remove(education);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Education deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            educations.insert(educationIndex, education);
            notifyListeners();
          },
        ),
      ),
    );
    notifyListeners();
  }

  addCertification(Certification certification) {
    certifications.add(certification);
    notifyListeners();
  }

  removeCertificate(Certification certification, context) {
    final certificateIndex = certifications.indexOf(certification);

    certifications.remove(certification);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Certification deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            certifications.insert(certificateIndex, certification);
            notifyListeners();
          },
        ),
      ),
    );
    notifyListeners();
  }

  addExperience(Experience experience) {
    experiences.add(experience);
    notifyListeners();
  }

  removeExperience(Experience experience, context) {
    final experienceIndex = experiences.indexOf(experience);
    experiences.remove(experience);
    notifyListeners();

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Experience deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            experiences.insert(experienceIndex, experience);
            notifyListeners();
          },
        ),
      ),
    );
    notifyListeners();
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    resumeName = result!.files.first.name;
    if (result.files.single.bytes != null) {
      final bytes = result.files.single.bytes!;
      base64Resume = base64Encode(bytes);
    } else {}

    notifyListeners();
  }

  Future getSkills({Niche? niche}) async {
    niche ??= _selectedNiche;
    try {
      final response = await myDio.get(
        '${ApiRoute.getSkills}/${niche?.id}',
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

  toggleSkill(Skill skill) {
    if (selectedSkills.contains(skill.id)) {
      selectedSkills.remove(skill.id);
    } else {
      selectedSkills.add(skill.id);
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

  void togglehobby(Hobby hobby) {
    if (selectedHobbies.contains(hobby.id)) {
      selectedHobbies.remove(hobby.id);
    } else {
      selectedHobbies.add(hobby.id);
    }
    notifyListeners();
  }

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phoneNumber => _phoneNumber;
  String get professionalBio => _professionalBio;
  XFile? get selectedImage => _image;
  String get foundingDate => selectedDate.toString();
  Industry? get selectedIndustry => _selectedIndustry;
  Niche? get selectedNiche => _selectedNiche;
  String get address => '$country $state';

  String? get errorMessage => _errorMessage;

  void updatePersonalInfo(String firstName, String lastName, String bio) {
    _firstName = firstName;
    _lastName = lastName;
    _professionalBio = bio;
  }

  void updateContactInfo(String phoneNumber, String linkedInUrl,
      String facebookUrl, String instagramUrl, String gitHubUrl) {
    _phoneNumber = phoneNumber;
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
  Future registerJobSeeker() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      return;
    }
    List<Map<String, dynamic>> educationsJson =
        educations.map((education) => education.toJson()).toList();

    List<Map<String, dynamic>> experiencesJson =
        experiences.map((experience) => experience.toJson()).toList();

    List<Map<String, dynamic>> certificationsJson =
        certifications.map((certification) => certification.toJson()).toList();

    final data = <String, dynamic>{
      "first_name": _firstName,
      "last_name": _lastName,
      "dob": selectedDate.toString(),
      'profilePic': base64Image,
      'resume': base64Resume,
      "phone": phoneNumber,
      "address": address,
      "bio": _professionalBio,
      "industry_id": _selectedIndustry!.id,
      "specialization_id": _selectedNiche!.id,
      'social_media_links': socialMediaLinks,
      'educations': educationsJson,
      'experiences': experiencesJson,
      'certifications': certificationsJson,
      'hobbies': selectedHobbies,
      "skills": selectedSkills,
    };

    try {
      final response = await myDio.post(
        ApiRoute.registerJobseeker,
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
