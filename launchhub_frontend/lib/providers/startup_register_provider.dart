import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:launchhub_frontend/helpers/base_url.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';

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
  DateTime? selectedDate;

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

  String get companyName => _companyName;
  XFile? get selectedImage => _image;
  String get foundingDate => selectedDate.toString();
  String get registrationNumber => _registrationNumber;
  String get companyDescription => _companyDescription;
  Industry? get selectedIndustry => _selectedIndustry;
  Niche? get selectedNiche => _selectedNiche;

  String? get errorMessage => _errorMessage;

  void updateCredentials(String foundingDate, String companyName,
      String registrationNumber, String companyDescription) {
    _companyName = companyName;
    _registrationNumber = registrationNumber;
    _companyDescription = companyDescription;
  }
}
