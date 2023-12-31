import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/signin.dart';
import 'package:launchhub_frontend/screens/start_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var activeScreen = 'splashScreen';

  void changeScreen() {
    setState(() {
      activeScreen = 'signIn';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Inter',
        primaryColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      home: Scaffold(
        body: Container(
          child: activeScreen == 'splashScreen'
              ? StartScreen(changeScreen)
              : const SignIn(),
        ),
      ),
    );
  }
}
