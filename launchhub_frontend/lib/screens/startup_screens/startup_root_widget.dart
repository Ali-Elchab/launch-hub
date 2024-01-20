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
  int _selectedIndex = 0; // To keep track of the active item index

  // List of screens to display based on the selected index
  final List<Widget> _screens = [
    const StartupHome(),
    const StartupCandidateArticle(),
    const StartupEditProfile(),
    // Add more screens here
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
        child:
            _screens.elementAt(_selectedIndex), // Display the selected screen
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
