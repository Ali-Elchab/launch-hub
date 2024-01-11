import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/education.dart';

class EducationCard extends StatelessWidget {
  final Education education;
  final Function()? onTap;

  const EducationCard({
    super.key,
    required this.education,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: const Color.fromARGB(255, 251, 251, 251),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  education.degree,
                  style: Theme.of(context).textTheme.titleSmall!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Text(
                  education.organization,
                  style: Theme.of(context).textTheme.bodyMedium!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    education.startDate,
                    style: Theme.of(context).textTheme.bodyMedium!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    education.endDate,
                    style: Theme.of(context).textTheme.bodyMedium!,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Text(
                  education.description,
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
