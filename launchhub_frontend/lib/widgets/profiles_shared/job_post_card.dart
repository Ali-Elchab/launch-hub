import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/startup.dart';

class JobPostCard extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final startup = company;
    if (startup == null && jobPost.startupName == '') {
      return const CircularProgressIndicator();
    }
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: const Color.fromARGB(255, 230, 229, 229),
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
                      height: 65,
                      width: 65,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            "${baseUrl}assets/images/profile_pics/${jobPost.startupLogo}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
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
                            jobPost.jobLocation,
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
                          jobPost.jobType.toString().split('.').last,
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
                          jobPost.deadline,
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
                    Text(jobPost.startupName!,
                        style: Theme.of(context).textTheme.titleSmall!),
                    const SizedBox(height: 4),
                    Text(jobPost.jobTitle,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    const SizedBox(height: 4),
                    Text(
                      jobPost.jobDescription,
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
