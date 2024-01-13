import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

enum UserType { startup, jobseeker }

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider();
});

class AuthProvider with ChangeNotifier {
  String _email = ''; // Make it a variable that can be updated
  String _password = ''; // Add a field for password
  int _userType = 0; // Example field for user type
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

  // Function to update email and password
  void updateCredentials(String email, String password, int userType) {
    _email = email;
    _password = password;
    _userType = userType;
    // Call notifyListeners if necessary
  }

  // Future<void> signIn(String email, String password) async {
  //   // Implement sign-in logic
  //   // Update authentication state
  //   notifyListeners();
  // }

  Future<void> signUp() async {
    try {
      final response = await dio.post(
        'http://lo',
        data: jsonEncode({
          "email": _email,
          "password": _password,
          "userType": _userType,
        }),
      );
      // Handle success
      _isSignUpSuccessful = true;
      _errorMessage = null;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', response.data['token']);
    } catch (e) {
      // Handle error
      _isSignUpSuccessful = false;
      _errorMessage = 'Failed to sign up: ${e.toString()}';
    }
    notifyListeners();
  }
}
