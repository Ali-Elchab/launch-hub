import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/providers/job_seeker_profile_provider.dart';
import 'package:launchhub_frontend/widgets/job_seeker_widgets/job_opportunities_list.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/search_filter.dart';

class JobOpportunities extends ConsumerWidget {
  const JobOpportunities({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(jobSeekerProfileProvider);
    Widget mainContent = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 80,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          const SizedBox(height: 30),
          Text('NO JOB POSTS FOUND',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center),
        ],
      ),
    );

    if (provider.jobPosts.isNotEmpty) {
      mainContent = JobOpportunitiesList(
        jobPosts: provider.jobPosts,
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          title: 'Job Opportunities',
          text:
              'Embark on a journey of endless possibilities with our Job Opportunities page – your gateway to a world of exciting career prospects! Dive into our diverse range of job listings and discover your next professional adventure.',
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              const SizedBox(height: 25),
              SearchFilter(onChanged: (String query) {
                provider.searchQuery = query;
                provider.filterJobPosts();
              }),
              Expanded(
                child: mainContent,
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
