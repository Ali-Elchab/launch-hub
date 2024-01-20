import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/providers/job_board_provider.dart';
import 'package:launchhub_frontend/providers/startup_profile_provider.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/startup/how_to_write_job_post.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/search_filter.dart';
import 'package:launchhub_frontend/widgets/startup/job_posts_list.dart';
import 'package:launchhub_frontend/widgets/startup/post_job.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class JobBoard extends ConsumerStatefulWidget {
  const JobBoard({super.key});

  @override
  ConsumerState<JobBoard> createState() => _JobBoardState();
}

class _JobBoardState extends ConsumerState<JobBoard> {
  @override
  void initState() {
    super.initState();
    ref.read(jobBoardProvider.notifier).fetchJobPosts();
  }

  @override
  Widget build(BuildContext context) {
    final jobBoardNotifier = ref.watch(jobBoardProvider.notifier);
    final jobBoard = ref.watch(jobBoardProvider);
    final startup = ref.read(startupProfileProvider);
    Widget mainContent = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            FontAwesomeIcons.folderOpen,
            size: 80,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          const SizedBox(height: 30),
          Text('NO JOB POSTS YET\nSTART ADDING SOME!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center),
        ],
      ),
    );

    if (jobBoard.jobPosts.isNotEmpty) {
      mainContent = JobPostsList(
        jobPosts: jobBoard.filteredJobPosts,
        removeJobPost: jobBoardNotifier.removeJobPost,
        company: startup.startup,
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
              SearchFilter(
                onChanged: (String query) => jobBoard.updateSearchQuery(query),
              ),
              Expanded(
                child: mainContent,
              ),
              SubmitButton('Post a job', () {
                showModal(const PostJob(), context, color: Colors.white);
              }),
              const SizedBox(height: 3),
              InkWell(
                onTap: () {
                  showModal(const HowToWriteJobPost(), context,
                      color: Colors.white);
                },
                child: Text(
                  'How To Write An Effective Job Posting',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
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
