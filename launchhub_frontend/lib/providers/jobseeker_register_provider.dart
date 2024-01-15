import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:launchhub_frontend/helpers/base_url.dart';
import 'package:launchhub_frontend/models/certification.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/models/experience.dart';
import 'package:launchhub_frontend/models/hobby.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/models/skill.dart';

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
  String resume = '';
  File? resumeFile;
  String? country;
  String? state;
  List socialMediaLinks = [];
  List<Education> educations = [
    Education(
      degree: 'degree',
      organization: 'organization',
      startDate: 'startDate',
      endDate: 'endDate',
      description: 'description',
      location: ' location',
    ),
  ];

  List<Certification> certifications = [
    Certification(
      name: 'web dev',
      certificate: 'certificate',
      organization: 'organization',
      startDate: 'startDate',
      endDate: 'endDate',
      description: 'description',
      location: ' location',
    )
  ];
  List<Experience> experiences = [
    Experience(
      position: 'degree',
      company: 'organization',
      startDate: 'startDate',
      industry: 1,
      specialization: 2,
      type: 'fulltime',
      endDate: 'endDate',
      description: 'description',
      location: ' location',
    ),
  ];
  List<Skill> skills = [];
  List<Skill> selectedSkills = [];
  List<Hobby> hobbies = [];
  List<Hobby> selectedHobbies = [];

  String? _errorMessage;

  void setSelectedIndustry(Industry newIndustry) {
    _selectedIndustry = newIndustry;
    _selectedNiche = null;
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

  Future getNiches({Industry? industry}) async {
    industry ??= _selectedIndustry;
    try {
      final response = await dio.get(
        "${baseURL}specializations/${industry?.id}",
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
    if (result != null && result.files.isNotEmpty) {
      resumeFile = File(result.files.first.path!);
    } else {}
    notifyListeners();
  }

  Future getSkills({Niche? niche}) async {
    niche ??= _selectedNiche;
    try {
      final response = await dio.get(
        "${baseURL}skills/${niche?.id}",
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
      final response = await dio.get(
        "${baseURL}general_skills",
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
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
    notifyListeners();
  }

  Future getHobbies() async {
    try {
      final response = await dio.get(
        "${baseURL}hobbies",
      );
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
    if (selectedHobbies.contains(hobby)) {
      selectedHobbies.remove(hobby);
    } else {
      selectedHobbies.add(hobby);
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

  void updatePersonalInfo(
      String firstName, String lastName, String phoneNumber, String bio) {
    _firstName = firstName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _professionalBio = bio;
  }

  void updateContactInfo(String phoneNumber, String linkedInUrl,
      String facebookUrl, String instagramUrl, String gitHubUrl) {
    _phoneNumber = phoneNumber;
    if (linkedInUrl.isNotEmpty) {
      socialMediaLinks.add({
        'name': 'LinkedIn',
        'url': linkedInUrl,
      });
      if (facebookUrl.isNotEmpty) {
        socialMediaLinks.add({
          'name': 'Facebook',
          'url': facebookUrl,
        });
        if (instagramUrl.isNotEmpty) {
          socialMediaLinks.add({
            'name': 'Instagram',
            'url': instagramUrl,
          });
        }
        if (gitHubUrl.isNotEmpty) {
          socialMediaLinks.add({
            'name': 'Github',
            'url': gitHubUrl,
          });
        }
      }
    }
  }
}
