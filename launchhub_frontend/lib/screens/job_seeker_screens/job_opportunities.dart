import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/search_filter.dart';
import 'package:launchhub_frontend/widgets/startup/job_posts_list.dart';

class JobOpportunities extends StatefulWidget {
  const JobOpportunities({super.key});

  @override
  State<JobOpportunities> createState() => _JobOpportunitiesState();
}

class _JobOpportunitiesState extends State<JobOpportunities> {
  @override
  Widget build(BuildContext context) {
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

    if (dummyJobPosts.isNotEmpty) {
      mainContent = JobPostsList(
        jobPosts: dummyJobPosts,
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          title: 'Job Board',
          text:
              'Cultivate your team and shape your company\'s future. Here in the Job board, effortlessly add, view, and manage your job listings, empowering you to connect with top talent seamlessly.',
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              const SizedBox(height: 25),
              SearchFilter(onPressedFilter: () {}),
              Expanded(
                child: mainContent,
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
