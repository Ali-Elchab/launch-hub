import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/auth_screens/company_info1.dart';
import 'package:launchhub_frontend/screens/auth_screens/personal_info.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/radio_buttons.dart';
import 'package:launchhub_frontend/screens/auth_screens/signin.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/google_button.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  UserType _selectedType = UserType.startup;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onRadioSelectionChanged(UserType selectedType) {
    setState(() {
      _selectedType = selectedType;
    });
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
              width: 280,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const HeaderSection(),
                    Text(
                      'Empowering Startups\nOne  Click at a Time',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 35),
                    InputField(label: 'Email', validator: validator),
                    InputField(
                      label: 'Password',
                      isPassword: true,
                      validator: validator,
                    ),
                    InputField(
                        label: 'Confirm Password',
                        isPassword: true,
                        validator: validator),
                    RadioButtons(
                      onSelectionChanged: _onRadioSelectionChanged,
                    ),
                    const SizedBox(height: 20),
                    SubmitButton('Sign Up', () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    _selectedType == UserType.startup
                                        ? const CompanyInfo1()
                                        : _selectedType == UserType.jobseeker
                                            ? const PersonalInfo()
                                            : const SignUp()));
                      }
                    }),
                    const SizedBox(height: 30),
                    const DividerWithText(text: 'or sign up with'),
                    const SizedBox(height: 16),
                    SocialSignInButton(
                      text: 'Google',
                      imagePath: 'assets/images/google_logo.png',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: "Already have an account? ",
                              style: Theme.of(context).textTheme.bodySmall!),
                          TextSpan(
                            text: "Sign In",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: const Color(0xFF326789)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()),
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
