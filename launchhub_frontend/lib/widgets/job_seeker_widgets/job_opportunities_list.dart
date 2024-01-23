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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.rocket_launch_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(width: 5),
                  Text('Easy Apply',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          )),
                ],
              ),
            ),
            confirmDismiss: (direction) async {
              await showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Apply For Job?'),
                  content: const Text(
                    'Do you want to easy apply for this job?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final res = await ref
                            .read(jobSeekerProfileProvider)
                            .applyJobPost(jobPosts[index].id);
                        if (res == 'Applied successfully') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              content: const Text('Applied Successfully!'),
                            ),
                          );
                        } else if (res == 'Already applied') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              content: const Text(
                                  'Already Applied! You can only apply once, wait for the startup to contact you!'),
                            ),
                          );
                        }
                        Navigator.of(ctx).pop(false);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
              return null;
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
