import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/jobSeeker.dart';

class JobSeekerCard extends StatelessWidget {
  final JobSeeker jobSeeker;
  final Function()? onTap;

  const JobSeekerCard({
    super.key,
    required this.jobSeeker,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                            jobSeeker.city,
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
                    Text(jobSeeker.specializationId.name,
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
