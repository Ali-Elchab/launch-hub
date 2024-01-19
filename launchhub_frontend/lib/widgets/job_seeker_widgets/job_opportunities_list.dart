// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/startup.dart';
import 'package:launchhub_frontend/providers/job_seeker_profile_provider.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/job_post_view.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_post_card.dart';

class JobOpportunitiesList extends ConsumerWidget {
  const JobOpportunitiesList({
    super.key,
    required this.jobPosts,
    this.onTap,
  });

  final List<JobPost> jobPosts;
  final void Function(JobPost jobPost)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: jobPosts.length,
      itemBuilder: (context, index) => Column(
        children: [
          Dismissible(
            key: ValueKey(jobPosts[index].id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Theme.of(context).colorScheme.primary,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: const Row(
                children: [
                  Text('Easy Apply',
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  Icon(
                    Icons.rocket_launch_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              ),
            ),
            onDismissed: (direction) async {
              final res = ref
                  .read(jobSeekerProfileProvider)
                  .applyJobPost(jobPosts[index].id);
              if (res == 'success') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Applied Successfully'),
                  ),
                );
              } else if (res == 'Already Applied') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Already Applied'),
                  ),
                );
              }
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
