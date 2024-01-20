import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/providers/hire_talent_provider.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/startup/choosing_candidate.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/search_filter.dart';
import 'package:launchhub_frontend/widgets/startup/job_seekers_list.dart';

class HireTalent extends ConsumerWidget {
  const HireTalent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hiretalentprovider = ref.watch(hireTalentProvider);
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

    if (hiretalentprovider.jobSeekers.isNotEmpty) {
      mainContent = JobSeekersList(
        jobSeekers: hiretalentprovider.filteredJobSeekers,
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
                onChanged: (String query) =>
                    hiretalentprovider.updateSearchQuery(query),
                margin: 10,
              ),
              InkWell(
                onTap: () {
                  showModal(const StartupCandidateArticle(), context);
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
    );
  }
}
