import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/job_seeker_home.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/jobseeker_edit_profile.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/startup/choosing_candidate.dart';

class JobSeekerRootWidget extends StatefulWidget {
  const JobSeekerRootWidget({super.key});

  @override
  State<JobSeekerRootWidget> createState() => _JobSeekerRootWidgetState();
}

class _JobSeekerRootWidgetState extends State<JobSeekerRootWidget> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const JobSeekerHome(),
    const StartupCandidateArticle(),
    const JobSeekerEditProfile(),
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
