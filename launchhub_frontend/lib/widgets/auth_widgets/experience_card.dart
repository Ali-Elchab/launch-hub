import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/experience.dart';

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final Function()? onTap;

  const ExperienceCard({
    super.key,
    required this.experience,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: const Color(0xFFF5F5F5),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                experience.position,
                style: Theme.of(context).textTheme.titleSmall!,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    experience.company,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black87,
                          fontSize: 9,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 9),
                  Text(
                    experience.location,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: const Color.fromARGB(221, 65, 65, 65),
                          fontSize: 9,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    experience.startDate,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black87,
                          fontSize: 9,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    experience.endDate,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black87,
                          fontSize: 9,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                experience.description,
                style: Theme.of(context).textTheme.bodySmall!,
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
