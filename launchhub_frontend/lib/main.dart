import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/screens/auth_screens/company_info1.dart';
import 'package:launchhub_frontend/screens/auth_screens/personal_info.dart';
import 'package:launchhub_frontend/screens/auth_screens/reset_password.dart';
import 'package:launchhub_frontend/screens/auth_screens/signin.dart';
import 'package:launchhub_frontend/screens/auth_screens/signup.dart';
import 'package:launchhub_frontend/screens/auth_screens/start_screen.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/job_seeker_home.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/jobseeker_root_widget.dart';
import 'package:launchhub_frontend/screens/startup_screens/hire_talent.dart';
import 'package:launchhub_frontend/screens/startup_screens/startup_home.dart';
import 'package:launchhub_frontend/screens/startup_screens/startup_root_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uni_links/uni_links.dart';
import 'firebase_options.dart';
import 'package:launchhub_frontend/helpers/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();

  String? initialLink;
  try {
    initialLink = await getInitialLink();
  } catch (e) {
    print(e);
  }

  runApp(ProviderScope(child: App(initialLink: initialLink)));
}

class App extends StatelessWidget {
  final String? initialLink;
  App({super.key, this.initialLink});
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
    return StreamBuilder(
      stream: uriLinkStream,
      initialData: initialLink,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final uri = Uri.parse(snapshot.data.toString());
          if (uri.scheme == 'http' && uri.host == 'reset-password') {
            final token = uri.queryParameters['token'];
            if (token != null && token.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                navigatorKey.currentState
                    ?.pushNamed('/reset-password', arguments: token);
              });
            }
          }
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          routes: {
            '/SignUp': (context) => SignUp(),
            '/SignIn': (context) => SignIn(),
            '/CompanyInfo1': (context) => const CompanyInfo1(),
            '/PersonalInfo': (context) => const PersonalInfo(),
            '/StartupHome': (context) => const StartupHome(),
            '/StartupRoot': (context) => const StartupRootWidget(),
            '/JobSeekerHome': (context) => const JobSeekerHome(),
            '/JobSeekerRoot': (context) => const JobSeekerRootWidget(),
            '/HireTalent': (context) => const HireTalent(),
            '/reset-password': (context) => ResetPassword(),
          },
          theme: theme,
          home: const Scaffold(
            resizeToAvoidBottomInset: false,
            body: StartScreen(),
          ),
        );
      },
    );
  }
}
