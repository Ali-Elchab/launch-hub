// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final String? token = ModalRoute.of(context)!.settings.arguments as String?;

    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final emailController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Forgot Password'),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/auth_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35, top: 130),
                    child: SizedBox(
                      width: 130,
                      child: Image.asset('assets/images/reset-password.jpg'),
                    ),
                  ),
                  Text(
                    'Create New Password',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 25),
                  InputField(
                    label: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      return null;
                    },
                  ),
                  InputField(
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  InputField(
                    label: 'Confirm Password',
                    isPassword: true,
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (confirmPasswordController.text !=
                          passwordController.text) {
                        return 'Passwords do not match';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  SubmitButton('Reset Password', () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final res = await myDio.post(
                          ApiRoute.resetPassword,
                          data: {
                            'token': token,
                            'email': emailController.text,
                            'password': passwordController.text,
                            'password_confirmation':
                                confirmPasswordController.text
                          },
                        );
                        if (res.statusCode == 200) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              title: Text('Password Reset!'),
                              content: Text(
                                  'Your password has been reset. Please login with your new password.'),
                            ),
                          );
                          navigatorKey.currentState!.pushNamedAndRemoveUntil(
                              '/SignIn', (route) => false);
                        }
                      } on DioException catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                'Password reset failed ${e.response!.statusCode}}'),
                          ),
                        );
                      }
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
