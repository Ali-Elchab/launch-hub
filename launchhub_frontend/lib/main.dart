import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:launchhub_frontend/screens/auth_screens/education_info.dart';
import 'package:launchhub_frontend/screens/auth_screens/start_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF326789),
    ),
    textTheme: GoogleFonts.interTextTheme().copyWith(
      titleLarge: GoogleFonts.inter(
          fontWeight: FontWeight.bold, fontSize: 21, color: Colors.black),
      titleMedium: GoogleFonts.inter(
          fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
      titleSmall: GoogleFonts.inter(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
      headlineLarge: GoogleFonts.inter(
          fontWeight: FontWeight.bold, fontSize: 42, color: Colors.black),
      headlineMedium: GoogleFonts.inter(
          fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
      headlineSmall: GoogleFonts.inter(
          fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
      bodyLarge: GoogleFonts.inter(
          fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black),
      bodyMedium: GoogleFonts.inter(
          fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
      bodySmall: GoogleFonts.inter(
          fontWeight: FontWeight.normal, fontSize: 10, color: Colors.black),
      labelLarge: GoogleFonts.inter(
          fontWeight: FontWeight.normal,
          fontSize: 18,
          color: const Color.fromARGB(255, 48, 48, 48)),
      labelMedium: GoogleFonts.inter(
          fontWeight: FontWeight.normal,
          fontSize: 16,
          color: const Color.fromARGB(255, 48, 48, 48)),
      labelSmall: GoogleFonts.inter(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: const Color.fromARGB(255, 48, 48, 48)),
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
