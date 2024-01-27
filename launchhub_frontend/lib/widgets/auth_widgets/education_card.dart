import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/certification.dart';
import 'package:launchhub_frontend/models/education.dart';

class EducationCard extends StatelessWidget {
  final Education? education;
  final Certification? certificationation;
  final Function()? onTap;

  const EducationCard({
    super.key,
    this.education,
    this.certificationation,
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
                education != null
                    ? education!.degree
                    : certificationation!.name,
                style: Theme.of(context).textTheme.titleSmall!,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                education != null
                    ? education!.organization
                    : certificationation!.organization,
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
                        : certificationation!.startDate,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.black87,
                          fontSize: 9,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    education != null
                        ? education!.endDate
                        : certificationation!.endDate,
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
                    : certificationation!.description,
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
