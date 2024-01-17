import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/startup.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/job_post_view.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_post_card.dart';

class JobPostsList extends StatelessWidget {
  const JobPostsList({
    super.key,
    required this.jobPosts,
    this.removeJobPost,
    this.company,
    this.onTap,
  });

  final List<JobPost> jobPosts;
  final Startup? company;
  final void Function(JobPost jobPost)? onTap;
  final Future Function(JobPost jobPost, dynamic)? removeJobPost;

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
              removeJobPost!(jobPosts[index], context);
            },
            child: JobPostCard(
              jobPost: jobPosts[index],
              company: company,
              onTap: removeJobPost == null
                  ? () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return JobPostView(jobPost: jobPosts[index]);
                      }));
                    }
                  : () {},
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
