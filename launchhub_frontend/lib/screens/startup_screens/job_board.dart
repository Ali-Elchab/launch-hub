import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mockData.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/how_to_write_job_post.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_post_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/search_filter.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class JobBoard extends StatefulWidget {
  const JobBoard({super.key});

  @override
  State<JobBoard> createState() => _JobBoardState();
}

class _JobBoardState extends State<JobBoard> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => const HowToWriteJobPost());
  }

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 45),
              SearchFilter(onPressedFilter: () {}),
              Expanded(
                child: ListView.builder(
                  itemCount: dummyJobPosts.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      JobPostCard(
                        jobPost: dummyJobPosts[index],
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                      JobPostCard(
                        jobPost: dummyJobPosts[index],
                        onTap: () {},
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SubmitButton('Post job', () {}),
              const SizedBox(height: 3),
              InkWell(
                onTap: () {
                  _openAddExpenseOverlay();
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
