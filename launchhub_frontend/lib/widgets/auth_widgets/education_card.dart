import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/course.dart';
import 'package:launchhub_frontend/models/education.dart';

class EducationCard extends StatelessWidget {
  final Education? education;
  final Course? course;
  final Function()? onTap;

  const EducationCard({
    super.key,
    this.education,
    this.course,
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
              Text(
                education != null ? education!.degree : course!.name,
                style: Theme.of(context).textTheme.titleSmall!,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                education != null
                    ? education!.organization
                    : course!.organization,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black87,
                      fontSize: 9,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    education != null
                        ? education!.startDate
                        : course!.startDate,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black87,
                          fontSize: 9,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    education != null ? education!.endDate : course!.endDate,
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
                education != null
                    ? education!.description
                    : course!.description,
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
