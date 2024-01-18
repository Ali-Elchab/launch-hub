import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_seeker_card.dart';

class JobSeekersList extends StatelessWidget {
  const JobSeekersList({super.key, required this.jobSeekers, onTap});

  final List<JobSeeker> jobSeekers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobSeekers.length,
      itemBuilder: (context, index) => Column(
        children: [
          JobSeekerCard(
            jobSeeker: jobSeekers[index],
          ),
          JobSeekerCard(
            jobSeeker: jobSeekers[index],
          ),
          JobSeekerCard(
            jobSeeker: jobSeekers[index],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
