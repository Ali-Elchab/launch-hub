import 'package:flutter/material.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Sign In'),
      extendBodyBehindAppBar: true, // Extend the body behind the AppBar
      body: Stack(
        children: [
          // Full-screen background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/auth_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Centered content with fixed width
          Center(
            child: SizedBox(
              width: 280, // Set the width to 280 pixels
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top +
                      kToolbarHeight, // Adjust top padding for AppBar
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const HeaderSection(),
                    const SignInTextField(label: 'Email'),
                    const SizedBox(height: 16),
                    const SignInTextField(label: 'Password', isPassword: true),
                    const SizedBox(height: 8),
                    const Text('Forgot Password?'),
                    const SizedBox(height: 16),
                    SubmitButton('Sign In', () {}),
                    const SizedBox(height: 16),
                    const DividerWithText(text: 'or continue with'),
                    const SizedBox(height: 16),
                    SocialSignInButton(
                      text: 'Google',
                      imagePath: 'assets/images/google_logo.png',
                      onPressed: () {},
                    ),
                    const SizedBox(height: 16),
                    const Text('Don\'t have an account? SIGN UP!'),
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
      child: FractionallySizedBox(
        heightFactor: 0.2,
        child: Image.asset('assets/logos/logo-nobg.ico'),
      ),
    );
  }
}

class SignInTextField extends StatelessWidget {
  final String label;
  final bool isPassword;

  const SignInTextField(
      {super.key, required this.label, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class SocialSignInButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  const SocialSignInButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Image.asset(imagePath, height: 24), // Social logo here
      label: Text(text),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.blue),
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
          child: Text(text),
        ),
        const Expanded(child: Divider(thickness: 2)),
      ],
    );
  }
}
