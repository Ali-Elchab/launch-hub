import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mockData.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/startup/choosing_candidate.dart';
import 'package:launchhub_frontend/widgets/startup/how_to_write_job_post.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/search_filter.dart';
import 'package:launchhub_frontend/widgets/startup/job_seekers_list.dart';

class HireTalent extends StatefulWidget {
  const HireTalent({super.key});

  @override
  State<HireTalent> createState() => _HireTalentState();
}

class _HireTalentState extends State<HireTalent> {
  void _choosingPerfectCandidate() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => const StartupCandidateArticle());
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.clear_rounded,
            size: 80,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          const SizedBox(height: 30),
          Text('No Job seekers found',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center),
        ],
      ),
    );

    if (dummyJobSeekers.isNotEmpty) {
      mainContent = JobSeekersList(
        jobSeekers: dummyJobSeekers,
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          title: 'Hire Talent',
          text:
              'Explore a diverse pool of talented job seekers from various backgrounds on our hiring page, tailored for startups seeking exceptional candidates.',
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              const SizedBox(height: 25),
              SearchFilter(
                onPressedFilter: () {},
                margin: 10,
              ),
              InkWell(
                onTap: () {
                  _choosingPerfectCandidate();
                },
                child: Text(
                  'Choosing The Perfect Candidate For Your Startup',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 11),
                ),
              ),
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
