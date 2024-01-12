import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/experience.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/experience_card.dart';

class ExperienceList extends StatelessWidget {
  const ExperienceList({
    super.key,
    required this.experiences,
    this.removeExperience,
    this.onTap,
  });

  final List<Experience> experiences;
  final void Function(Experience experiences)? onTap;
  final void Function(Experience experiences)? removeExperience;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: experiences.length,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Dismissible(
            key: ValueKey(experiences[index].id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: const Color.fromARGB(255, 167, 11, 0),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 4,
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
            confirmDismiss: (direction) {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text(
                    'Do you want to remove?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              );
            },
            onDismissed: (direction) {
              removeExperience!(experiences[index]);
            },
            child: ExperienceCard(
              experience: experiences[index],
              onTap: () {},
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
