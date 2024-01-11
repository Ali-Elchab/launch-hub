import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/job_post.dart';

class JobPostCard extends StatelessWidget {
  final JobPost jobPost;
  final Function()? onTap;

  const JobPostCard({
    super.key,
    required this.jobPost,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // splashFactory: NoSplash.splashFactory,

      // splashColor: Colors.transparent,
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
                        child: Image.asset('assets/logos/default-logo.png',
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
                    Text('Vast Technologies',
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
