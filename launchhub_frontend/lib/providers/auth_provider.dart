import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
  bool _isSignInSuccessful = false;
  UserType _selectedType = UserType.startup;

  UserType get selectedType => _selectedType;
  String? get errorMessage => _errorMessage;
  bool get isSignUpSuccessful => _isSignUpSuccessful;
  bool get isSignInSuccessful => _isSignInSuccessful;
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

  Future signIn(String email, String password) async {
    try {
      final response = await myDio.post(
        ApiRoute.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        _isSignInSuccessful = true;
        _errorMessage = null;
        _selectedType = response.data['user']['user_type_id'] == 1
            ? UserType.startup
            : response.data['user']['user_type_id'] == 2
                ? UserType.jobseeker
                : UserType.startup;
        if (response.data.containsKey('authorisation')) {
          final authorizationData = response.data['authorisation'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', authorizationData['token']);
          return response.data;
        } else {
          _isSignInSuccessful = false;
          _errorMessage = 'Token not found in response';
        }
      }
    } on DioException catch (e) {
      _isSignInSuccessful = false;
      _errorMessage = '${e.response?.data['message']['email'][0]}';
      return _errorMessage;
    } catch (e) {
      _isSignUpSuccessful = false;
      _errorMessage = 'Failed to sign in: $e';
      return _errorMessage;
    }
    notifyListeners();
  }

  Future signUp() async {
    try {
      final response = await myDio.post(
        ApiRoute.signup,
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
          return response.data;
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

  Future<void> refreshTokenIfNeeded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    if (token != null) {
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      if (decodedToken.containsKey('exp')) {
        final int expirationTimestamp = decodedToken['exp'];
        final int currentTimestamp =
            DateTime.now().millisecondsSinceEpoch ~/ 1000;

        if (currentTimestamp > expirationTimestamp) {
          final refresh = await myDio.post(ApiRoute.refresh);
          if (refresh.statusCode == 200) {
            if (refresh.data.containsKey('authorisation')) {
              final authorizationData = refresh.data['authorisation'];
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('token', authorizationData['token']);
            } else {
              _isSignUpSuccessful = false;
              _errorMessage = 'Token not found in response';
            }
          }
        }
      }
    }
  }
}
