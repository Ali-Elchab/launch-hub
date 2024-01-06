import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/start_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launchhub_frontend/screens/startup_screens/job_board.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Scaffold(body: JobBoard()),
    );
  }
}
