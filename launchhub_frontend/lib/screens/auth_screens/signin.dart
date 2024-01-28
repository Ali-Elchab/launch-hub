import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/models/user.dart';
import 'package:launchhub_frontend/providers/auth_provider.dart';
import 'package:launchhub_frontend/providers/job_seeker_profile_provider.dart';
import 'package:launchhub_frontend/providers/startup_profile_provider.dart';
import 'package:launchhub_frontend/screens/auth_screens/forgot_password.dart';

import 'package:launchhub_frontend/widgets/auth_widgets/google_button.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends ConsumerWidget {
  SignIn({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void showProfileWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Profile Incomplete'),
          content: Text(
              'Your profile is incomplete. Redirecting to complete your profile.'),
        );
      },
    );
    Future.delayed(const Duration(seconds: 4));
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.pushNamed(context, '/CompanyInfo1');
  }

  Future<firebase_auth.User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth != null) {
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      firebase_auth.UserCredential userCredential = await firebase_auth
          .FirebaseAuth.instance
          .signInWithCredential(credential);

      return userCredential.user;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Sign In'),
      extendBodyBehindAppBar: true, // Extend the body behind the AppBar
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
              width: MediaQuery.of(context).size.width * 0.73,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const HeaderSection(),
                    Text(
                      'Welcome Back to LaunchHub!\nYour Startup Oasis',
                      textAlign: TextAlign.center,
                      style: textTheme.titleSmall!,
                    ),
                    const SizedBox(height: 35),
                    InputField(
                      label: 'Email',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
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
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        }),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPassword()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: textTheme.labelSmall!.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SubmitButton('Sign In', () async {
                      final provider = ref.read(authProvider);
                      if (_formKey.currentState!.validate()) {
                        ref.read(authProvider.notifier).updateCredentials(
                            emailController.text, passwordController.text, 0);
                        final response = await ref
                            .read(authProvider.notifier)
                            .signIn(
                                emailController.text, passwordController.text);

                        if (provider.isSignInSuccessful) {
                          final user = User.fromJson(response['user']);
                          if (user.typeId == 1) {
                            ref.read(startupProfileProvider).loadUser(user);
                            try {
                              final res = await ref
                                  .read(startupProfileProvider)
                                  .fetchStartupProfile();
                              if (res == 'Startup not found') {
                                showProfileWarning(context);
                              } else {
                                navigatorKey.currentState
                                    ?.pushNamedAndRemoveUntil('/StartupRoot',
                                        (Route<dynamic> route) => false);
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('$e')));
                            }
                          } else if (user.typeId == 2) {
                            ref.read(jobSeekerProfileProvider).loadUser(user);
                            try {
                              final res = await ref
                                  .read(jobSeekerProfileProvider)
                                  .fetchJobSeeker();
                              if (res == 'Failed to get jobSeeker profile') {
                                showProfileWarning(context);
                              } else {
                                navigatorKey.currentState
                                    ?.pushNamedAndRemoveUntil('/JobSeekerRoot',
                                        (Route<dynamic> route) => false);
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('$e')));
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('${provider.errorMessage}'),
                                backgroundColor:
                                    const Color.fromARGB(255, 175, 12, 0)),
                          );
                        }
                      }
                    }),
                    const SizedBox(height: 30),
                    const DividerWithText(text: 'or continue with'),
                    const SizedBox(height: 16),
                    SocialSignInButton(
                      text: 'Sign in with Google',
                      imagePath: 'assets/images/google_logo.png',
                      onPressed: () {
                        signInWithGoogle();
                      },
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: "Don't have an account? ",
                              style: Theme.of(context).textTheme.bodySmall!),
                          TextSpan(
                            text: "Sign Up",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize: 14, color: colorScheme.primary),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                navigatorKey.currentState?.pushNamed('/SignUp');
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
