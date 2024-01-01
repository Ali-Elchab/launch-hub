import 'package:flutter/material.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.splashScreen, {super.key});

  final void Function() splashScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              const Text(
                'Welcome To LunchHub',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'inter',
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Launch your startup journey with a fresh perspective',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(204, 204, 204, 204),
                  fontFamily: 'inter',
                ),
              ),
              const SizedBox(
                width: 250,
                child: Text(
                  'Join us on a dynamic startup journey,  where we empower your business.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(204, 204, 204, 204),
                    fontFamily: 'inter',
                  ),
                ),
              ),
              const SizedBox(height: 55),
              SubmitButton('Get Started', splashScreen),
            ],
          ),
        ),
      ),
    );
  }
}
