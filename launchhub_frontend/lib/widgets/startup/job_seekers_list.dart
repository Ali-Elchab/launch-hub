import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_seeker_card.dart';

class JobSeekersList extends StatelessWidget {
  const JobSeekersList({super.key, required this.jobSeekers, onTap});

  final List<JobSeeker> jobSeekers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyJobSeekers.length,
      itemBuilder: (context, index) => Column(
        children: [
          JobSeekerCard(
            jobSeeker: dummyJobSeekers[index],
          ),
          JobSeekerCard(
            jobSeeker: dummyJobSeekers[index],
          ),
          JobSeekerCard(
            jobSeeker: dummyJobSeekers[index],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
