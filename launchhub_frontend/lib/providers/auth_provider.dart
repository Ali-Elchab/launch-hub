import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();
// class AuthNotifier extends StateNotifier {
//   AuthNotifier() : super({}){
//     email = '';
//     String password = '';

//   };

//   String get email => _email;

//   set email(String value) {
//     _email = value;
//   }

//   void login() {
//     state = true;
//   }

//   void logout() {
//     state = false;
//   }
// }

// final authProvider = StateNotifierProvider((ref) {
//   return AuthNotifier();
// });

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider();
});

class AuthProvider with ChangeNotifier {
  String _email = ''; // Make it a variable that can be updated
  String _password = ''; // Add a field for password
  int _userType = 0; // Example field for user type
  String? _errorMessage;
  bool _isSignUpSuccessful = false;

  String? get errorMessage => _errorMessage;
  bool get isSignUpSuccessful => _isSignUpSuccessful;
  String get email => _email;

  // Function to update email and password
  void updateCredentials(String email, String password, int userType) {
    _email = email;
    _password = password;
    _userType = userType;
    // Call notifyListeners if necessary
  }

  Future<void> signIn(String email, String password) async {
    // Implement sign-in logic
    // Update authentication state
    notifyListeners();
  }

  Future<void> signUp() async {
    try {
      final response = await dio.post(
        'http://localhost:3000/api/v1/users',
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

  // Add other auth-related methods

