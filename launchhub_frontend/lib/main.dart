import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/start_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0xFF326789),
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      titleLarge: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 23,
      ),
      titleMedium: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleSmall: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headlineLarge: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 42,
      ),
      headlineMedium: GoogleFonts.inter(
        fontWeight: FontWeight.bold,
        fontSize: 30,
      ),
      bodyLarge: GoogleFonts.inter(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      bodyMedium: GoogleFonts.inter(
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Scaffold(body: StartScreen()),
    );
  }
}
