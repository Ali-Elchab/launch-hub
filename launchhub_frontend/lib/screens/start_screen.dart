import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/auth_screens/signin.dart';
import 'package:launchhub_frontend/screens/startup_screens/home.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void _getStarted(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/splashscreen_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/splashscreen-img.png', width: 300),
                const SizedBox(height: 15),
                Text(
                  'Welcome To LunchHub',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const SizedBox(height: 15),
                Text(
                  'Launch your startup journey with a fresh perspective',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: const Color.fromARGB(204, 204, 204, 204),
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    'Join us on a dynamic startup journey,  where we empower your business.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: const Color.fromARGB(204, 204, 204, 204),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
                const SizedBox(height: 55),
                SubmitButton('Get Started', () {
                  _getStarted(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
