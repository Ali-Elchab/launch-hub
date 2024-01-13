import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/providers/auth_provider.dart';
import 'package:launchhub_frontend/screens/auth_screens/company_info1.dart';
import 'package:launchhub_frontend/screens/auth_screens/personal_info.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/radio_buttons.dart';
import 'package:launchhub_frontend/screens/auth_screens/signin.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/google_button.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUp extends ConsumerWidget {
  SignUp({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final provider = ref.watch(authProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Sign Up'),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/auth_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const HeaderSection(),
                    Text(
                      'Empowering Startups\nOne  Click at a Time',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall!,
                    ),
                    const SizedBox(height: 35),
                    InputField(
                      label: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                      controller: emailController,
                    ),
                    InputField(
                      label: 'Password',
                      isPassword: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 3) {
                          return 'Password must be at least 6 characters long';
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
                    RadioButtons(
                      onSelectionChanged: (UserType selectedType) {
                        ref
                            .read(authProvider.notifier)
                            .setSelectedType(selectedType);
                      },
                    ),
                    const SizedBox(height: 20),
                    SubmitButton('Sign Up', () {
                      print(provider.isSignUpSuccessful);
                      if (_formKey.currentState!.validate()) {
                        ref.read(authProvider.notifier).updateCredentials(
                            emailController.text,
                            passwordController.text,
                            provider.selectedType.index);
                        ref.read(authProvider.notifier).signUp();
                        if (provider.isSignUpSuccessful) {
                          navigator(
                              context,
                              provider.selectedType.index == 0
                                  ? const CompanyInfo1()
                                  : const PersonalInfo());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Error: ${provider.errorMessage}')),
                          );
                        }
                      }
                    }),
                    const SizedBox(height: 30),
                    const DividerWithText(text: 'or sign up with'),
                    const SizedBox(height: 16),
                    SocialSignInButton(
                      text: 'Sign Up With Google',
                      imagePath: 'assets/images/google_logo.png',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: textTheme.bodySmall!,
                        children: <TextSpan>[
                          const TextSpan(
                            text: "Already have an account? ",
                          ),
                          TextSpan(
                            text: "Sign In",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 14,
                                    color: const Color(0xFF326789)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                navigator(
                                  context,
                                  SignIn(),
                                );
                              },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   super.dispose();
  // }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 22),
        child: SizedBox(
          width: 130,
          child: Image.asset('assets/logos/logo-nobg.ico'),
        ),
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(child: Divider(thickness: 2)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(text, style: Theme.of(context).textTheme.labelSmall!),
        ),
        const Expanded(child: Divider(thickness: 2)),
      ],
    );
  }
}
