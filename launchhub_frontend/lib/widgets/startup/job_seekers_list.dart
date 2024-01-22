import 'package:flutter/material.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_seeker_card.dart';

class JobSeekersList extends StatelessWidget {
  const JobSeekersList({super.key, required this.jobSeekers, onTap});

  final List<JobSeeker> jobSeekers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobSeekers.length,
      itemBuilder: (context, index) {
        return FutureBuilder<String>(
          future: getNicheName(
              jobSeekers[index].industryId, jobSeekers[index].specializationId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator(
                backgroundColor: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                minHeight: 0.5,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  JobSeekerCard(
                    jobSeeker: jobSeekers[index],
                    niche: snapshot.data!,
                  ),
                  const SizedBox(height: 20),
                ],
              );
            } else {
              return const Text('Niche name not found.');
            }
          },
        );
      },
    );
  }

  Future<String> getNicheName(industryId, nicheId) async {
    final niche = await myDio.get('${ApiRoute.getSpecializations}/$nicheId');
    final specialization = Niche.fromJson(niche.data['specialization']);
    return specialization.name;
  }
}
