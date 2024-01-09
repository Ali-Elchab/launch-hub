import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/experience.dart';

class JobSeekerExperience extends StatelessWidget {
  const JobSeekerExperience({
    super.key,
    required this.toggleHeaderColor,
    required this.experiences,
  });

  final Function()? toggleHeaderColor;
  final List<Experience> experiences;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double customHeight = screenHeight - 200;
    return Container(
      height: customHeight,
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Skills and Hobbies',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
              ),
              IconButton(
                onPressed: () {
                  toggleHeaderColor!();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...experiences.map((experience) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Text(
                                  experience.position,
                                  style:
                                      Theme.of(context).textTheme.titleSmall!,
                                  overflow: TextOverflow
                                      .ellipsis, // Add ellipsis to indicate overflow
                                  maxLines: 2,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(
                                  experience.company,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  overflow: TextOverflow
                                      .ellipsis, // Add ellipsis to indicate overflow
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${experience.startDate} - ',
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                              Text(
                                experience.endDate,
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                experience.location,
                                style: Theme.of(context).textTheme.bodySmall!,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            experience.description,
                            style: Theme.of(context).textTheme.bodySmall!,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
