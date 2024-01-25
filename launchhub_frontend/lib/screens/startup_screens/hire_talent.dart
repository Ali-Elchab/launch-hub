import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/providers/hire_talent_provider.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/startup/applicants_list.dart';
import 'package:launchhub_frontend/widgets/startup/choosing_candidate.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/search_filter.dart';
import 'package:launchhub_frontend/widgets/startup/job_seekers_list.dart';

class HireTalent extends ConsumerStatefulWidget {
  const HireTalent({super.key});

  @override
  ConsumerState<HireTalent> createState() => _HireTalent();
}

class _HireTalent extends ConsumerState<HireTalent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = 0;
    loadData();
  }

  Future loadData() async {
    await ref.read(hireTalentProvider).fetchJobSeekers();
    await ref.read(hireTalentProvider).getApplications();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hiretalentprovider = ref.read(hireTalentProvider.notifier);

    Widget mainContent = _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.clear_rounded,
                  size: 80,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                const SizedBox(height: 30),
                Text('No Job seekers suggested at the moment.',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                    textAlign: TextAlign.center),
              ],
            ),
          );

    if (ref.read(hireTalentProvider).jobSeekers.isNotEmpty) {
      if (_tabController.index == 0) {
        mainContent = JobSeekersList(
          jobSeekers: ref.watch(hireTalentProvider.notifier).filteredJobSeekers,
        );
      } else if (_tabController.index == 1) {
        if (hiretalentprovider.applicants.isEmpty) {
          mainContent = Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.clear_rounded,
                  size: 80,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                const SizedBox(height: 30),
                Text('No Job seekers applied at the moment.',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                    textAlign: TextAlign.center),
              ],
            ),
          );
        } else if (hiretalentprovider.applicants.isNotEmpty) {
          mainContent = ApplicantsList(
            jobSeekers: hiretalentprovider.applicants,
            onDismissed: (id, status, index) {
              hiretalentprovider.respondToApplication(id, status, index);
            },
          );
        }
      }
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
          width: MediaQuery.of(context).size.width * 0.73,
          child: Column(
            children: [
              const SizedBox(height: 25),
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
              SearchFilter(
                onChanged: (String query) =>
                    hiretalentprovider.updateSearchQuery(query),
                margin: 10,
              ),
              const SizedBox(height: 10),
              TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                onTap: (index) {
                  setState(() {
                    _tabController.index = index;
                  });
                },
                controller: _tabController,
                tabs: [
                  Text(
                    'Suggested',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  Text(
                    'Applicants ',
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
