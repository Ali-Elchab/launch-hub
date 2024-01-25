// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';
import 'package:uni_links/uni_links.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    handleDeepLink();
  }

  Future handleDeepLink() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        final uri = Uri.parse(initialLink);
        if (uri.scheme == 'myapp') {
          final token = uri.queryParameters['token'];
          if (token != null && token.isNotEmpty) {
            Navigator.pushNamed(context, '/reset-password', arguments: token);
          }
        }
      }
    } on Exception catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            width: MediaQuery.of(context).size.width * 0.73,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35, top: 130),
                    child: SizedBox(
                      width: 130,
                      child: Image.asset('assets/images/forgot-password.jpg'),
                    ),
                  ),
                  Text(
                    'Don’t worry! Enter your Email and we’ll send you a reset link to reset your password.',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 25),
                  InputField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    label: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  SubmitButton('Send Reset Link', () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final response = await myDio.post(
                            ApiRoute.emailResetLink,
                            data: {'email': emailController.text});
                        if (response.statusCode == 200) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              title: Text('Email Sent!'),
                              content: Text(
                                  'Please check your email for the reset link.'),
                            ),
                          );

                          emailController.clear();
                        }
                      } on DioException catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                'Email not found ${e.response!.statusCode}}'),
                          ),
                        );
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text('Email not found'),
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
