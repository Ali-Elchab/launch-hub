import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mockData.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/job_post_view.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_post_card.dart';

class EducationsList extends StatelessWidget {
  const EducationsList({
    super.key,
    required this.educations,
    this.removeEducation,
    this.onTap,
  });

  final List<Education> educations;
  final void Function(Education education)? onTap;
  final void Function(Education education)? removeEducation;

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
                    'Do you want to remove education?',
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
              removeEducation!(educations[index]);
            },
            child: JobPostCard(
              jobPost: dummyJobPosts[index],
              onTap: () {},
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
