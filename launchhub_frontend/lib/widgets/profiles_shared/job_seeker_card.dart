// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/providers/data_provider.dart';
import 'package:launchhub_frontend/screens/startup_screens/job_seeker_profile.dart';

class JobSeekerCard extends ConsumerStatefulWidget {
  final JobSeeker jobSeeker;
  final Function()? onTap;
  final String? niche;

  const JobSeekerCard({
    super.key,
    required this.jobSeeker,
    this.niche,
    this.onTap,
  });

  @override
  ConsumerState<JobSeekerCard> createState() => _JobSeekerCard();
}

class _JobSeekerCard extends ConsumerState<JobSeekerCard> {
  @override
  Widget build(BuildContext context) {
    final jobSeeker = widget.jobSeeker;

    return InkWell(
      onTap: () async {
        await ref.watch(dataProvider).getIndustries();
        final industry = ref
            .watch(dataProvider)
            .industries
            .firstWhere((element) => element.id == jobSeeker.industryId);
        await ref.read(dataProvider).getNiches(industry);
        navigator(context, JobSeekerProfile(jobSeeker: jobSeeker));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 0,
        color: const Color.fromARGB(255, 251, 251, 251),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset('assets/logos/default-profile.png',
                            width: 65)),
                    const SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 10,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            jobSeeker.address,
                            style: Theme.of(context).textTheme.bodySmall!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.phone_enabled_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 11,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          jobSeeker.phone,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 11,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${jobSeeker.firstName} ${jobSeeker.lastName}',
                        style: Theme.of(context).textTheme.titleSmall!),
                    const SizedBox(height: 4),
                    Text(widget.niche!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    const SizedBox(height: 4),
                    Text(jobSeeker.bio,
                        style: Theme.of(context).textTheme.bodySmall!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
