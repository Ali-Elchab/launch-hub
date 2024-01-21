import 'package:flutter/material.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/helpers/open_link.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_seeker_card.dart';

class ApplicantsList extends StatelessWidget {
  const ApplicantsList({super.key, required this.jobSeekers, onTap});

  final List<JobSeeker> jobSeekers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobSeekers.length,
      itemBuilder: (context, index) => Column(
        children: [
          Dismissible(
            key: ValueKey(jobSeekers[index].id),
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
            secondaryBackground: Container(
              color: Theme.of(context).primaryColor,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: const Icon(
                Icons.contact_page_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                return await showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text(
                      'Do you want to remove the item from the list?',
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
              }
              return null;
            },
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                // Provider.of<Cart>(context, listen: false)
                //     .removeItem(product.id);
              } else if (direction == DismissDirection.startToEnd) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Contact Applicant Now!'),
                    content: Column(
                      children: [
                        TextButton.icon(
                          icon: Icon(
                            Icons.email_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: const Text('Contact via Email'),
                          onPressed: () async {
                            await openLink(
                              context,
                              jobSeekers[index].email!,
                            );
                            navigatorKey.currentState!.pop();
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton.icon(
                          icon: Icon(
                            Icons.phone,
                            color: Theme.of(context).primaryColor,
                          ),
                          label: const Text('Contact via Phone'),
                          onPressed: () async {
                            await openLink(
                              context,
                              jobSeekers[index].phone,
                            );
                            navigatorKey.currentState!.pop();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            child: JobSeekerCard(
              jobSeeker: jobSeekers[index],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
