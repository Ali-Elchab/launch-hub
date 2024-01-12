import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/auth_screens/signin.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
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
                    label: 'Password',
                    isPassword: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 3) {
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
                  SubmitButton('Reset Password', () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
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
