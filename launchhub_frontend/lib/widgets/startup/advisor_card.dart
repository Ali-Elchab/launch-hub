import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/advisor.dart';
import 'package:launchhub_frontend/models/advisor.dart';

class AdvisorCard extends StatelessWidget {
  final Advisor advisor;

  const AdvisorCard({
    super.key,
    required this.advisor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
              width: 110,
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
                          advisor.location ?? '',
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
                        advisor.phone,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                  Text(advisor.name,
                      style: Theme.of(context).textTheme.titleSmall!),
                  const SizedBox(height: 4),
                  Text(advisor.expertise,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(height: 4),
                  Text(advisor.bio,
                      style: Theme.of(context).textTheme.bodySmall!),
                  const SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.email_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 11,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          advisor.email,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 9,
                                  ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
