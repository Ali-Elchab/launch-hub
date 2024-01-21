import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/startup_screens/startup_edit_profile.dart';
import 'package:launchhub_frontend/screens/startup_screens/startup_home.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/startup/choosing_candidate.dart';

class StartupRootWidget extends StatefulWidget {
  const StartupRootWidget({super.key});

  @override
  State<StartupRootWidget> createState() => _StartupRootWidgetState();
}

class _StartupRootWidgetState extends State<StartupRootWidget> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const StartupHome(),
    const StartupCandidateArticle(),
    const StartupEditProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
