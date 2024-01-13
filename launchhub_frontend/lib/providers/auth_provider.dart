import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

enum UserType { startup, jobseeker }

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider();
});

class AuthProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  int _userType = 0;
  String? _errorMessage;
  bool _isSignUpSuccessful = false;
  UserType _selectedType = UserType.startup;

  UserType get selectedType => _selectedType;
  String? get errorMessage => _errorMessage;
  bool get isSignUpSuccessful => _isSignUpSuccessful;
  String get email => _email;

  void setSelectedType(UserType newType) {
    _selectedType = newType;
    notifyListeners();
  }

  void updateCredentials(String email, String password, int? userType) {
    _email = email;
    _password = password;
    _userType = userType!;
  }

  Future<void> signIn(String email, String password) async {
    // Implement sign-in logic
    // Update authentication state
    notifyListeners();
  }

  Future<void> signUp() async {
    print(_email);
    print(_password);
    print(_userType);
    try {
      final response = await dio.post(
        "${baseURL}signup",
        data: {
          "email": _email,
          "password": _password,
          "user_type_id": _userType,
        },
      );
      if (response.statusCode == 200) {
        _isSignUpSuccessful = true;
        _errorMessage = null;
        if (response.data.containsKey('authorisation')) {
          final authorizationData = response.data['authorisation'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', authorizationData['token']);
        } else {
          _isSignUpSuccessful = false;
          _errorMessage = 'Token not found in response';
        }
      }
    } on DioException catch (e) {
      _isSignUpSuccessful = false;
      _errorMessage = 'Failed to sign up: ${e.response?.data['message']}';
    } catch (e) {
      _isSignUpSuccessful = false;
      _errorMessage = 'Failed to sign up: $e';
    }
    notifyListeners();
  }
}
