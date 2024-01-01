import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/signin.dart';
import 'package:launchhub_frontend/screens/start_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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

  final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xFF326789),
    ),
    textTheme: GoogleFonts.interTextTheme(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Scaffold(body: StartScreen()),
    );
  }
}
