import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/startup.dart';
import 'package:launchhub_frontend/providers/job_seeker_profile_provider.dart';

class JobPostCard extends ConsumerStatefulWidget {
  final JobPost jobPost;
  final Function()? onTap;
  final Startup? company;

  const JobPostCard({
    super.key,
    required this.jobPost,
    this.onTap,
    this.company,
  });

  @override
  ConsumerState<JobPostCard> createState() => _JobPostCardState();
}

class _JobPostCardState extends ConsumerState<JobPostCard> {
  @override
  void initState() {
    super.initState();
    loadStartup();
  }

  void loadStartup() async {
    final startupId = widget.jobPost.startupId;
    await ref.read(jobSeekerProfileProvider).getStartup(startupId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(jobSeekerProfileProvider);
    final startup = widget.company ?? provider.startup;
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        elevation: 0,
        color: const Color.fromARGB(255, 251, 251, 251),
        child: Padding(
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
                      child: startup!.copmanyLogo != null
                          ? Image.asset(
                              'assets/logos/default-logo.png',
                              width: 65,
                            )
                          : Image.network(
                              "${baseUrl}assets/logos/${startup.copmanyLogo!}",
                              width: 65),
                    ),
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
                            widget.jobPost.jobLocation,
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
                          Icons.work_outline,
                          color: Theme.of(context).colorScheme.primary,
                          size: 11,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          widget.jobPost.jobType.toString().split('.').last,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 11,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.hourglass_empty_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: 11,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          widget.jobPost.deadline,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(startup.companyName,
                        style: Theme.of(context).textTheme.titleSmall!),
                    const SizedBox(height: 4),
                    Text(widget.jobPost.jobTitle,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    const SizedBox(height: 4),
                    Text(
                      widget.jobPost.jobDescription,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 10,
                          ),
                    ),
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
