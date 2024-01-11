import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/job_post_view.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_post_card.dart';

class JobPostsList extends StatelessWidget {
  const JobPostsList({
    super.key,
    required this.jobPosts,
    this.removeJobPost,
    this.onTap,
  });

  final List<JobPost> jobPosts;
  final void Function(JobPost jobPost)? onTap;
  final void Function(JobPost jobPost)? removeJobPost;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyJobPosts.length,
      itemBuilder: (context, index) => Column(
        children: [
          Dismissible(
            key: ValueKey(dummyJobPosts[index].id),
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
              removeJobPost!(dummyJobPosts[index]);
            },
            child: JobPostCard(
              jobPost: dummyJobPosts[index],
              onTap: removeJobPost == null
                  ? () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return JobPostView(jobPost: dummyJobPosts[index]);
                      }));
                    }
                  : () {},
            ),
          ),
          const SizedBox(height: 20),
          JobPostCard(
            jobPost: dummyJobPosts[index],
            onTap: () {},
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
