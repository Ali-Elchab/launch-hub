// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/startup.dart';
import 'package:launchhub_frontend/providers/job_seeker_profile_provider.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/job_post_view.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_post_card.dart';

class JobOpportunitiesList extends StatelessWidget {
  const JobOpportunitiesList({
    super.key,
    required this.jobPosts,
    this.onTap,
  });

  final List<JobPost> jobPosts;
  final void Function(JobPost jobPost)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobPosts.length,
      itemBuilder: (context, index) => Column(
        children: [
          Dismissible(
            key: ValueKey(jobPosts[index].id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text(
                    'Do you want to remove the job post?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) {
              // removeJobPost!(jobPosts[index], context);
            },
            child: Consumer(
              builder: (context, ref, child) => JobPostCard(
                jobPost: jobPosts[index],
                onTap: () async {
                  final startupId = jobPosts[index].startupId;
                  final Startup startUp = await ref
                      .read(jobSeekerProfileProvider)
                      .getStartup(startupId);
                  navigator(context,
                      JobPostView(jobPost: jobPosts[index], startup: startUp));
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
