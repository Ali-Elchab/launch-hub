import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launchhub_frontend/data/mockData.dart';
import 'package:launchhub_frontend/models/jobPost.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/startup/how_to_write_job_post.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_post_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/search_filter.dart';
import 'package:launchhub_frontend/widgets/startup/job_posts_list.dart';
import 'package:launchhub_frontend/widgets/startup/post_job.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class JobBoard extends StatefulWidget {
  const JobBoard({super.key});

  @override
  State<JobBoard> createState() => _JobBoardState();
}

class _JobBoardState extends State<JobBoard> {
  void _openPostJobOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => PostJob(postJob: _postJob));
  }

  void _howToWriteJobPost() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => const HowToWriteJobPost());
  }

  void _postJob(JobPost jobPost) {
    setState(() {
      dummyJobPosts.add(jobPost);
    });
  }

  void _removeJobPost(JobPost jobPost) {
    final jobIndex = dummyJobPosts.indexOf(jobPost);
    setState(() {
      dummyJobPosts.remove(jobPost);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              dummyJobPosts.insert(jobIndex, jobPost);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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

    if (dummyJobPosts.isNotEmpty) {
      mainContent = JobPostsList(
        jobPosts: dummyJobPosts,
        removeJobPost: _removeJobPost,
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
              SubmitButton('Post a job', () {
                _openPostJobOverlay();
              }),
              const SizedBox(height: 3),
              InkWell(
                onTap: () {
                  _howToWriteJobPost();
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
