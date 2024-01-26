import 'package:flutter/material.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/helpers/open_link.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/job_seeker_card.dart';

class ApplicantsList extends StatelessWidget {
  const ApplicantsList(
      {super.key, required this.jobSeekers, onTap, this.onDismissed});

  final List<JobSeeker> jobSeekers;
  final Function? onDismissed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobSeekers.length,
      itemBuilder: (context, index) => FutureBuilder<String>(
        future: getNicheName(
            jobSeekers[index].industryId, jobSeekers[index].specializationId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              minHeight: 0.5,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Column(
              children: [
                Dismissible(
                  key: ValueKey(jobSeekers[index].id),
                  secondaryBackground: Container(
                    color: const Color.fromARGB(255, 165, 11, 0),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 10),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.thumb_down_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 5),
                        Text('Reject Applicant',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                )),
                      ],
                    ),
                  ),
                  background: Container(
                    color: Theme.of(context).primaryColor,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.contact_page_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 5),
                        Text('Contact',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                )),
                      ],
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      return await showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text(
                            'Do you want to reject application? Tap the card and view the applicant\'s profile to make sure.',
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
                    } else {
                      return await showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Contact Applicant Now!'),
                          content: SizedBox(
                            height: 130,
                            child: Column(
                              children: [
                                TextButton.icon(
                                  icon: Icon(
                                    Icons.email_outlined,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  label: const Text('Contact via Email'),
                                  onPressed: () async {
                                    String email = jobSeekers[index].email!;
                                    String mailtoUrl = "mailto:$email";
                                    openLink(context, mailtoUrl);
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
                                    String phone = jobSeekers[index].phone;
                                    String phoneCallUrl = "tel:$phone";
                                    openLink(context, phoneCallUrl);
                                    navigatorKey.currentState!.pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      onDismissed!(jobSeekers[index].id, 'rejected', index);
                    } else if (direction == DismissDirection.startToEnd) {
                      await showDialog(
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
                    niche: snapshot
                        .data!, // Pass the fetched niche name to the card
                  ),
                ),
                const SizedBox(height: 20),
              ],
            );
          } else {
            // Handle the case where there is no data (e.g., an empty state)
            return const Text('Niche name not found.');
          }
        },
      ),
    );
  }

  Future<String> getNicheName(industryId, nicheId) async {
    final niche = await myDio.get('${ApiRoute.getSpecializations}/$nicheId');
    final specialization = Niche.fromJson(niche.data['specialization']);
    return specialization.name;
  }
}
