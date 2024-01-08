import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:launchhub_frontend/data/mockData.dart';
import 'package:launchhub_frontend/models/jobPost.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/startup/how_to_write_job_post.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/search_filter.dart';
import 'package:launchhub_frontend/widgets/startup/job_posts_list.dart';
import 'package:launchhub_frontend/widgets/startup/post_job.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class HireTalent extends StatefulWidget {
  const HireTalent({super.key});

  @override
  State<HireTalent> createState() => _HireTalentState();
}

class _HireTalentState extends State<HireTalent> {
  void _openPostJobOverlay() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        elevation: 0,
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

  // void _removeJobPost(JobPost jobPost) {
  //   final jobIndex = dummyJobPosts.indexOf(jobPost);
  //   setState(() {
  //     dummyJobPosts.remove(jobPost);
  //   });
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       duration: const Duration(seconds: 3),
  //       content: const Text('Expense deleted.'),
  //       action: SnackBarAction(
  //         label: 'Undo',
  //         onPressed: () {
  //           setState(() {
  //             dummyJobPosts.insert(jobIndex, jobPost);
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

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

    // if (dummyJobPosts.isNotEmpty) {
    //   mainContent = JobPostsList(
    //     jobPosts: dummyJobPosts,
    //     removeJobPost: _removeJobPost,
    //   );
    // }
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
